/*
 * File   : $Source$
 * Date   : $Date$
 * Version: $Revision$
 *
 * This library is part of OpenCms -
 * the Open Source Content Management System
 *
 * Copyright (C) 2002 - 2009 Alkacon Software (http://www.alkacon.com)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * For further information about Alkacon Software, please see the
 * company website: http://www.alkacon.com
 *
 * For further information about OpenCms, please see the
 * project website: http://www.opencms.org
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

package com.alkacon.bootstrap.search.client;

import com.alkacon.bootstrap.search.client.CmsSearchConfig.CmsFacetConfig;
import com.alkacon.bootstrap.search.client.CmsSearchConfig.CmsWidgetConfig;
import com.alkacon.bootstrap.search.client.CmsSearchConfig.WIDGET_TYPES;
import com.alkacon.bootstrap.search.client.CmsSearchJSONLoader.I_CmsSearchCallback;
import com.alkacon.bootstrap.search.client.widgets.CmsAutoCompleteWidget;
import com.alkacon.bootstrap.search.client.widgets.CmsPaginationWidget;
import com.alkacon.bootstrap.search.client.widgets.CmsResetFacetWidget;
import com.alkacon.bootstrap.search.client.widgets.CmsResultAdvisorWidget;
import com.alkacon.bootstrap.search.client.widgets.CmsResultCountWidget;
import com.alkacon.bootstrap.search.client.widgets.CmsResultListWidget;
import com.alkacon.bootstrap.search.client.widgets.CmsResultShareWidget;
import com.alkacon.bootstrap.search.client.widgets.CmsSortBarWidget;
import com.alkacon.bootstrap.search.client.widgets.CmsTextFacetWidget;
import com.alkacon.bootstrap.search.client.widgets.I_CmsSearchWidget;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.google.gwt.core.client.GWT;
import com.google.gwt.event.logical.shared.ValueChangeEvent;
import com.google.gwt.event.logical.shared.ValueChangeHandler;
import com.google.gwt.http.client.Request;
import com.google.gwt.http.client.RequestBuilder;
import com.google.gwt.http.client.RequestCallback;
import com.google.gwt.http.client.RequestException;
import com.google.gwt.http.client.Response;
import com.google.gwt.i18n.client.DateTimeFormat;
import com.google.gwt.i18n.client.DateTimeFormat.PredefinedFormat;
import com.google.gwt.json.client.JSONArray;
import com.google.gwt.json.client.JSONObject;
import com.google.gwt.json.client.JSONParser;
import com.google.gwt.json.client.JSONValue;
import com.google.gwt.user.client.History;
import com.google.gwt.user.client.Timer;
import com.google.gwt.user.client.Window;
import com.google.gwt.user.client.ui.HTMLPanel;
import com.google.gwt.user.client.ui.Image;
import com.google.gwt.user.client.ui.RootPanel;
import com.google.gwt.user.client.ui.SuggestOracle;
import com.google.gwt.user.client.ui.SuggestOracle.Suggestion;

/** 
 * Search controller containing the client side search logic.<p>
 */
public class CmsSearchController {

    /**
     * A map comparator.<p>
     * 
     * This comparator imposes orderings that are inconsistent with equals.<p>
     */
    protected class ValueComparator implements Comparator<String> {

        /** The base map. */
        protected Map<String, Integer> m_base;

        /**
         * Constructor.<p>
         * 
         * @param base the map base
         */
        public ValueComparator(Map<String, Integer> base) {

            m_base = base;
        }

        /**
         * Note: this comparator imposes orderings that are inconsistent with equals.
         * 
         * @see java.util.Comparator#compare(java.lang.Object, java.lang.Object)
         */
        public int compare(String a, String b) {

            if (m_base.get(a).intValue() >= m_base.get(b).intValue()) {
                return -1;
            } else {
                return 1;
            } // returning 0 would merge keys
        }
    }

    /**
     * The history handler.<p>
     */
    private class CmsHistoryValueChangeHandler implements ValueChangeHandler<String> {

        /** The forward query. */
        private String m_forwardQuery;

        /** The Search configuration. */
        private CmsSearchConfig m_searchConfig;

        /** The Search context. */
        private CmsSearchContext m_searchContext;

        /**
         * Public constructor with parameters.<p>
         * 
         * @param config the Search configuration
         * @param context the Search context
         */
        public CmsHistoryValueChangeHandler(CmsSearchConfig config, CmsSearchContext context) {

            m_searchConfig = config;
            m_searchContext = context;
        }

        /**
         * @see com.google.gwt.event.logical.shared.ValueChangeHandler#onValueChange(com.google.gwt.event.logical.shared.ValueChangeEvent)
         */
        public void onValueChange(ValueChangeEvent<String> event) {

            if (event.getValue().equals(m_lastQuery) || event.getValue().equals(m_forwardQuery)) {
                CmsSearchQueryData data = createSearchData(m_searchConfig, m_searchContext, event.getValue());
                if (data.hasSelection()) {
                    m_forwardQuery = CmsSearchQueryData.shortQuery(m_searchData.createQueryString(isTitle()));
                    doSearch(data, false);
                }
            }
        }
    }

    /** The logging object for this class. */
    private static final Logger LOG = Logger.getLogger("SearchController");

    /** Signals initialization status. */
    protected boolean m_init;

    /** The last executed query.*/
    protected String m_lastQuery;

    /** The last window location hash that was set manually. */
    protected String m_newLocationQuery;

    /** The search data bean. */
    protected CmsSearchQueryData m_searchData;

    /** Stores the search widgets. */
    protected Map<String, I_CmsSearchWidget> m_searchWidgets = new HashMap<String, I_CmsSearchWidget>();

    /** All titles. */
    protected List<String> m_titles = new ArrayList<String>();

    /** A timer. */
    private Timer m_autocompleteTimer;

    /** The initial Search configuration. */
    private CmsSearchConfig m_config;

    /** The current search context. */
    private CmsSearchContext m_context;

    /** A timer. */
    private Timer m_loadingTimer;

    /** A timer. */
    private Timer m_searchTimer;

    /** The share widget. */
    private CmsResultShareWidget m_shareWidget;

    /** Suggestions. */
    private TreeMap<String, Integer> m_suggestions;

    /**
     * Creates a controller.<p>
     * 
     * @param config the configuration
     * @param context the context
     */
    public CmsSearchController(CmsSearchConfig config, CmsSearchContext context) {

        if (GWT.isProdMode()) {
            LOG.setLevel(Level.OFF);
        } else {
            LOG.setLevel(Level.INFO);
        }

        createLoading();

        History.addValueChangeHandler(new CmsHistoryValueChangeHandler(config, context));
        m_config = config;
        m_context = context;
        m_searchData = createSearchData(config, context, null);

        initWidgets();
    }

    /**
     * Creates a search data object.<p>
     * 
     * @param config the configuration
     * @param context the context
     * @param queryString the optional query
     * 
     * @return the search data object
     */
    protected static CmsSearchQueryData createSearchData(
        CmsSearchConfig config,
        CmsSearchContext context,
        String queryString) {

        CmsSearchQueryData data = null;
        if (queryString != null) {
            data = CmsSearchQueryData.fromShortQuery(config, queryString);
        }
        if ((data == null) || !data.hasSelection()) {
            data = CmsSearchQueryData.fromShortQuery(config, Window.Location.getHref());
            if (data != null) {
                data.setFromLocation(true);
            }
        }
        if ((data == null)
            || ((!data.hasSelection() && !CmsSearchStringUtil.isEmpty(context.getInitialQuery())) && CmsSearchStringUtil.isEmpty(context.getSearchQuery()))) {
            data = CmsSearchQueryData.fromShortQuery(config, context.getInitialQuery());
        }
        if ((data == null) || !data.hasSelection()) {
            data = new CmsSearchQueryData(config);
            data.setSearchQuery(context.getSearchQuery());
        } else {
            data.setRestored(true);
        }

        CmsSearchQueryData searchData = data;
        searchData.setRootSite(context.getRootSite());
        List<String> searchRoots = new ArrayList<String>();
        searchRoots.add("\"" + context.getGlobalPath() + "\"");
        searchRoots.add("\"" + context.getSubSitePath() + "\"");
        searchData.setParentFolders(searchRoots);
        searchData.setSubSitePath(context.getSubSitePath());
        searchData.setRows(config.getRows());

        String q = searchData.getSearchQuery();
        if (q != null) {
            if (q.endsWith("&#034;") && q.startsWith("&#034;")) {
                q = q.replaceFirst("&#034;", "\"");
                if (q.length() > 5) {
                    q = q.substring(0, q.length() - 6);
                    q += "\"";
                    searchData.setSearchQuery(q);
                }
            }
        }
        return searchData;
    }

    /**
     * Executes the Search search for auto completion.<p>
     * 
     * @param widgetToUpdate the name of the widget to update
      */
    public void doAutoComplete(final String widgetToUpdate) {

        showLoading(20);
        if (m_autocompleteTimer != null) {
            m_autocompleteTimer.cancel();
        }
        m_autocompleteTimer = new Timer() {

            @Override
            public void run() {

                executeAutoCompletion(widgetToUpdate);
            }
        };
        m_autocompleteTimer.schedule(m_config.getAutocompletedelay());
    }

    /**
     * Caller method.<p>
     * 
     * @param clearParams <code>true</code> if params should be cleared
     */
    public void doSearch(boolean clearParams) {

        doSearch(null, clearParams);
    }

    /**
     * Calls the Search server to do the search.<p>
     * 
     * @param data a optinal data object 
     * @param clearParameters flag to clear all additional search parameters and facet filters
     */
    public void doSearch(CmsSearchQueryData data, boolean clearParameters) {

        showLoading(20);
        if (data != null) {
            m_searchData = data;
        }

        m_lastQuery = History.getToken();

        // clear the search parameters if required
        if (clearParameters) {
            m_searchData.clearAll();
        }

        I_CmsSearchJsonCommand callback = new I_CmsSearchJsonCommand() {

            /**
             * @see com.alkacon.bootstrap.search.client.I_CmsSearchJsonCommand#execute(com.google.gwt.json.client.JSONObject)
             */
            public void execute(JSONObject jsonObject) {

                getSearchData().setSearchQuery(getSearchData().getSearchQuery());

                CmsSearchDocumentList result = processSearch(jsonObject);
                for (I_CmsSearchWidget inputWidget : m_searchWidgets.values()) {
                    inputWidget.update(result);
                }
                if (!getSearchData().isFromLocation()) {
                    m_newLocationQuery = CmsSearchQueryData.shortQuery(getSearchData().createQueryString(isTitle()));
                    History.newItem(m_newLocationQuery, false);
                }
                getSearchData().setFromLocation(false);
                hideLoading();
            }
        };

        String q = m_searchData.createQueryString(isTitle());
        String url = m_config.getSearchUrl() + q;
        sendRequest(url, callback);
    }

    /**
     * Caller method.<p>
     * 
     * @param textq the textual query
     * @param delay the delay in ms 
     */
    public void doSearch(final String textq, int delay) {

        if (m_searchTimer != null) {
            m_searchTimer.cancel();
        }
        m_searchTimer = new Timer() {

            @Override
            public void run() {

                m_searchData.clearAll();

                if ((textq == null) || (textq.trim().equals("") || textq.replaceAll("\"", "").trim().isEmpty())) {
                    m_searchData.setSearchQuery(null);
                } else {
                    m_searchData.setSearchQuery(textq.trim());
                }

                doSearch(m_searchData, false);
            }
        };
        m_searchTimer.schedule(delay);
    }

    /**
     * Executes the Search search for auto completion.<p>
     * 
     * @param request the suggestion request
     * @param callback the suggestion callback to execute
     * @param widget a widget to update
     */
    public void doSuggesting(
        final SuggestOracle.Request request,
        final SuggestOracle.Callback callback,
        final CmsResultListWidget widget) {

        showLoading(20);
        if (m_autocompleteTimer != null) {
            m_autocompleteTimer.cancel();
        }
        m_autocompleteTimer = new Timer() {

            /**
             * @see com.google.gwt.user.client.Timer#run()
             */
            @Override
            public void run() {

                executeAutoCompletion(request, callback, widget);
            }
        };
        m_autocompleteTimer.schedule(m_config.getAutocompletedelay());

    }

    /**
     * Returns the configuration.<p>
     *
     * @return the configuration
     */
    public CmsSearchConfig getConfig() {

        return m_config;
    }

    /**
     * Returns the context.<p>
     * 
     * @return the context
     */
    public CmsSearchContext getContext() {

        return m_context;
    }

    /**
     * Generates the link that can be shared.<p>
     * 
     * @return the share link
     */
    public String getLinkToShare() {

        String query = getSearchData().createQueryString(isTitle()).substring(1);
        String onlineLink = getContext().getOnlineUrl();
        String queryParams = CmsSearchQueryData.shortQuery(query);
        String link = onlineLink + "?" + queryParams;
        link = link.replace("/index.html", "");
        return link;
    }

    /**
     * Returns the searchData.<p>
     *
     * @return the searchData
     */
    public CmsSearchQueryData getSearchData() {

        return m_searchData;
    }

    /**
     * Returns the shareWidget.<p>
     *
     * @return the shareWidget
     */
    public CmsResultShareWidget getShareWidget() {

        return m_shareWidget;
    }

    /**
     * The last suggestions.<p>
     * 
     * @return the last suggestions
     */
    public TreeMap<String, Integer> getSuggestions() {

        return m_suggestions;
    }

    /**
     * Returns the titles.<p>
     *
     * @return the titles
     */
    public List<String> getTitles() {

        return m_titles;
    }

    /**
     * Returns the widget configuration for the given type.<p>
     * 
     * @param type the type to get the configuration for
     * 
     * @return the configuration for the given widget type
     */
    public CmsWidgetConfig getWidgetConfig(WIDGET_TYPES type) {

        return m_config.getWidgets().get(type.toString());
    }

    /**
     * Hides the loading animation.<p>
     */
    public void hideLoading() {

        if (m_loadingTimer != null) {
            m_loadingTimer.cancel();
        }

        if (RootPanel.get("loading") != null) {
            RootPanel.get("loading").setStyleName("hide");
            RootPanel.get("leftCol").setStyleName("visible");
            RootPanel.get("rightCol").setStyleName("visible");
        }

    }

    /**
     * Initializes the titles.<p>
     */
    public void initSuggestions() {

        I_CmsSearchJsonCommand callback = new I_CmsSearchJsonCommand() {

            /**
             * @see com.alkacon.bootstrap.search.client.I_CmsSearchJsonCommand#execute(com.google.gwt.json.client.JSONObject)
             */
            public void execute(JSONObject jsonObject) {

                getTitles().clear();
                // get the facets
                try {
                    JSONObject joFaceCounts = jsonObject.get(I_CmsSearchConstants.NODE_FACETS).isObject();
                    JSONObject joFacetFields = joFaceCounts.get(I_CmsSearchConstants.NODE_FACETFIELDS).isObject();
                    Map<String, List<CmsSearchFacet>> factes = toFacetBeans(joFacetFields);
                    List<CmsSearchFacet> beans = factes.get("Title_exact");
                    for (CmsSearchFacet facet : beans) {
                        getTitles().add(facet.getName());
                    }
                    if (!m_init) {
                        init();
                    }
                } catch (Throwable t) {
                    // no facets found, so do nothing here
                }
            }

        };

        if (getTitles().isEmpty()) {
            sendRequest(m_config.getSearchUrl() + m_config.getTitleQuery(), callback);
        }
    }

    /**
     * Registers a search widget.<p>
     * 
     * @param name the name for the widget
     * @param widget the widget
     */
    public void registerSearchWidget(String name, I_CmsSearchWidget widget) {

        m_searchWidgets.put(name, widget);
    }

    /**
     * Shows the loading animation.<p>
     * 
     * @param delay the delay
     */
    public void showLoading(int delay) {

        if (m_loadingTimer != null) {
            m_loadingTimer.cancel();
        }
        if (RootPanel.get("loading") != null) {
            m_loadingTimer = new Timer() {

                @Override
                public void run() {

                    RootPanel.get("loading").setStyleName("show");
                    RootPanel.get("leftCol").setStyleName("invisible");
                    RootPanel.get("rightCol").setStyleName("invisible");
                }
            };
            m_loadingTimer.schedule(50);
        }

    }

    /**
     * Executes the auto completion.<p>
     * 
     * @param widgetToUpdate the widget to update
     */
    protected void executeAutoCompletion(final String widgetToUpdate) {

        I_CmsSearchJsonCommand callback = new I_CmsSearchJsonCommand() {

            /**
             * @see com.alkacon.bootstrap.search.client.I_CmsSearchJsonCommand#execute(com.google.gwt.json.client.JSONObject)
             */
            public void execute(JSONObject jsonObject) {

                processAutoComplete(widgetToUpdate, jsonObject);
            }
        };

        String url = m_config.getSearchUrl() + m_searchData.createAutocompleteString();
        sendRequest(url, callback);
    }

    /**
     * Executes the auto completion.<p>
     * 
     * @param request the suggestion request
     * @param callback the suggestion callback to execute
     * @param widget a widget to update
     */
    protected void executeAutoCompletion(
        final SuggestOracle.Request request,
        final SuggestOracle.Callback callback,
        final CmsResultListWidget widget) {

        I_CmsSearchJsonCommand searchCallback = new I_CmsSearchJsonCommand() {

            /**
             * @see com.alkacon.bootstrap.search.client.I_CmsSearchJsonCommand#execute(com.google.gwt.json.client.JSONObject)
             */
            public void execute(JSONObject jsonObject) {

                processAutoComplete(request, callback, jsonObject);
                CmsSearchDocumentList result = processSearch(jsonObject);
                for (I_CmsSearchWidget inputWidget : m_searchWidgets.values()) {
                    if (widget != null) {
                        widget.addSuggs(result);
                    } else if (inputWidget.updateOnSearch()) {
                        inputWidget.update(result);
                    }
                }
                hideLoading();
            }
        };
        m_searchData.clearAll();
        String url = m_config.getSpellUrl() + m_searchData.createAutocompleteString();
        sendRequest(url, searchCallback);
    }

    /**
     * Performs initial search.<p>
     */
    protected void init() {

        if (m_searchData.isRestored()) {
            doSearch(null, false);
        } else {
            if (m_context.isInitialized()) {
                doSearch(null, true);
            }
        }

        m_init = true;
    }

    /**
     * Returns true if a title search has been executed.<p>
     * 
     * @return true if a title search has been executed
     */
    protected boolean isTitle() {

        return m_titles.contains(getSearchData().getSearchQuery());
    }

    /**
     * @param autoCompleteWidget
     * @param object
     */
    protected void processAutoComplete(final String autoCompleteWidget, JSONObject object) {

        // process the search result to get search result objects
        CmsSearchDocumentList result = processSearch(object);

        for (String facetName : result.getFacetNames()) {
            // first get all values for the current facet
            List<CmsSearchFacet> facetValues = result.getFacet(facetName);
            // iterate over them to get the auto completion results
            for (CmsSearchFacet facetBean : facetValues) {
                result.addAutoCompletion(facetBean.getName());
            }
            if (m_searchWidgets.get(autoCompleteWidget) != null) {
                m_searchWidgets.get(autoCompleteWidget).update(result);
            }
        }
    }

    /**
     * Processes the JSON result.<p>
     * 
     * @param request the suggestion request
     * @param callback the suggestion callback to execute
     * @param object the JSON object to parse
     */
    protected void processAutoComplete(SuggestOracle.Request request, SuggestOracle.Callback callback, JSONObject object) {

        try {

            m_suggestions = new TreeMap<String, Integer>();

            String q = m_searchData.getSearchQuery().replaceAll("\"", "");
            q = q.toLowerCase();

            HashMap<String, Integer> map = new HashMap<String, Integer>();
            TreeMap<String, Integer> collationMap = new TreeMap<String, Integer>(new ValueComparator(map));

            if (object.get("spellcheck") != null) {
                try {
                    JSONObject spellcheck = object.get("spellcheck").isObject();
                    JSONArray suggestions = spellcheck.get("suggestions").isArray();

                    for (int i = 0; i < suggestions.size(); i++) {
                        try {
                            JSONValue val = suggestions.get(i);
                            if (val.isString() != null) {
                                String sugg = val.isString().stringValue();
                                if (sugg.equals("collation")) {
                                    JSONArray collations = suggestions.get(i + 1).isArray();
                                    String collq = collations.get(1).isString().toString().replaceAll("\\\\\"", "").replaceAll(
                                        "\"",
                                        "");
                                    Integer count = new Integer(collations.get(3).isNumber().toString());
                                    map.put(collq, count);
                                }
                            }
                        } catch (Throwable t) {
                            // noop
                        }
                    }
                    // sort the result by hits
                    collationMap.putAll(map);

                } catch (Throwable t) {
                    // noop
                }
            }

            List<Suggestion> res = new LinkedList<Suggestion>();
            for (final String title : m_titles) {
                if (title.toLowerCase().startsWith(q)) {
                    res.add(new Suggestion() {

                        /**
                         * @see com.google.gwt.user.client.ui.SuggestOracle.Suggestion#getDisplayString()
                         */
                        public String getDisplayString() {

                            return title;
                        }

                        /**
                         * @see com.google.gwt.user.client.ui.SuggestOracle.Suggestion#getReplacementString()
                         */
                        public String getReplacementString() {

                            return title;
                        }
                    });
                }
            }

            for (final Map.Entry<String, Integer> sug : collationMap.entrySet()) {
                final String sugg = sug.getKey().replaceAll("\"", "");

                res.add(new Suggestion() {

                    /**
                     * @see com.google.gwt.user.client.ui.SuggestOracle.Suggestion#getDisplayString()
                     */
                    public String getDisplayString() {

                        return sugg + " (" + sug.getValue() + ")";
                    }

                    /**
                     * @see com.google.gwt.user.client.ui.SuggestOracle.Suggestion#getReplacementString()
                     */
                    public String getReplacementString() {

                        return sugg;
                    }
                });

            }
            if (callback != null) {
                SuggestOracle.Response response = new SuggestOracle.Response();
                response.setSuggestions(res);
                callback.onSuggestionsReady(request, response);
            }
            m_suggestions = collationMap;

        } catch (Throwable t) {
            LOG.log(Level.WARNING, "Suggestion is not a String", t);
        }
    }

    /**
     * Processes the received JSON Object to create a list of result objects.<p>
     *
     * @param jsonSearchResult result received
     * 
     * @return CmsSearchDocumentList 
     */
    protected CmsSearchDocumentList processSearch(JSONObject jsonSearchResult) {

        CmsSearchDocumentList searchResult = new CmsSearchDocumentList();
        JSONObject response = jsonSearchResult.get(I_CmsSearchConstants.NODE_RESPONSE).isObject();
        searchResult.setHits(new Integer(response.get(I_CmsSearchConstants.NODE_NUM_FOUND).isNumber().toString()).intValue());

        // get the found documents
        JSONArray docs = response.get(I_CmsSearchConstants.NODE_DOCS).isArray();
        List<JSONObject> documentObjects = new LinkedList<JSONObject>();

        if (docs != null) {
            for (int i = 0; i <= (docs.size() - 1); i++) {

                // iterate over the found documents
                JSONObject document = docs.get(i).isObject();
                documentObjects.add(document);
                // build the result object
                CmsSearchDocument result = new CmsSearchDocument();

                //---------------------------------------------------------------------------------------------------
                // get the direct result values
                //----------------------------------------------------------------------------------------------------

                // get the title
                String undefined = UserMessages.getMessage("label.undefined");
                String title = undefined;
                try {
                    title = document.get(CmsSearchDocumentList.FL_TITLE_PROP).isString().stringValue();
                } catch (Throwable t) {
                    // nothing to do here, title was empty
                }
                result.setTitle(title);

                // get the resource path
                String path = undefined;
                try {
                    path = document.get(CmsSearchDocumentList.FL_PATH).isString().stringValue();
                } catch (Throwable t) {
                    // nothing to do here, path was empty
                }
                result.setPath(path);

                // get the "gg.version_exact" field
                String version = undefined;
                try {
                    if (document.get("version") != null) {
                        version = document.get("version").isString().stringValue();
                    }
                } catch (Throwable t) {
                    // nothing to do here, path was empty
                }
                result.setVersion(version);

                // get the "lastmodified" field
                String lastmodified = undefined;
                try {
                    lastmodified = document.get("lastmodified").isString().stringValue();
                    // 2012-10-10T11:55:17.13Z
                    // yyyy-MM-ddTHH:mm:ssZ
                    lastmodified = lastmodified.substring(0, 19);
                    DateTimeFormat format = DateTimeFormat.getFormat("yyyy-MM-ddTHH:mm:ss");
                    Date mDate = format.parse(lastmodified);
                    result.setLastModificationAsLong(mDate.getTime());
                    lastmodified = DateTimeFormat.getFormat(PredefinedFormat.DATE_MEDIUM).format(mDate);
                } catch (Throwable t) {
                    System.out.println(t);
                }
                result.setLastModification(lastmodified);

                // get the "gg.version_exact" field
                String suffix = undefined;
                try {
                    suffix = document.get("suffix").isString().stringValue();
                } catch (Throwable t) {
                    // nothing to do here, path was empty
                }
                result.setSuffix(suffix);

                // get the "size" field
                String size = undefined;
                try {
                    int bytes = new Integer(document.get("size").isNumber().toString()).intValue();
                    int kb = Math.round(bytes / 1000);
                    size = kb + " KB";
                } catch (Throwable t) {
                    // nothing to do here, path was empty
                }
                result.setSize(size);

                // get the resource path
                String link = undefined;
                try {
                    link = document.get(CmsSearchDocumentList.FL_LINK).isString().stringValue();
                } catch (Throwable t) {
                    // nothing to do here, path was empty
                }
                result.setLink(link);

                // get the resource type
                String type = "";
                try {
                    type = document.get(CmsSearchDocumentList.FL_TYPE).isString().stringValue();
                } catch (Throwable t) {
                    // nothing to do here, type was empty
                }
                // if no type is found, use file extension as fallback
                if (type.equals("binary") || type.equals("")) {
                    int pos = path.lastIndexOf(".");
                    if (pos > 0) {
                        type = path.substring(pos + 1, path.length()).toUpperCase();
                    }
                }
                result.setType(type);

                // get the resource id
                String id = "";
                try {
                    id = document.get(CmsSearchDocumentList.FL_ID).isString().stringValue();
                } catch (Throwable t) {
                    // nothing to do here, id was empty
                }
                result.setId(id);

                // get the content locales
                List<String> locales = new ArrayList<String>();
                try {
                    JSONArray arr = document.get(CmsSearchDocumentList.FL_CON_LOCALES).isArray();
                    if (arr != null) {
                        for (int j = 0; j < arr.size(); j++) {
                            String loc = arr.get(j).isString().stringValue();
                            if (loc != null) {
                                locales.add(loc);
                            }
                        }
                    }
                } catch (Throwable t) {
                    // nothing to do here, id was empty
                }
                result.setContentLocales(locales);

                //----------------------------------------------------------------------------------------------------
                // get the highlighting
                //----------------------------------------------------------------------------------------------------

                // check if there is some highlighting info for this entry
                if (jsonSearchResult.get(I_CmsSearchConstants.NODE_HIGHLIGHTING) != null) {
                    JSONObject highlighting = jsonSearchResult.get(I_CmsSearchConstants.NODE_HIGHLIGHTING).isObject();
                    if (highlighting != null) {
                        try {
                            JSONObject joHeiglight = highlighting.get(id).isObject();

                            // now look into the highlight relevant fields
                            String excerpt = "";

                            for (String highlightField : m_config.getHighlightFields()) {

                                try {
                                    excerpt = joHeiglight.get(highlightField).toString();
                                    excerpt = excerpt.substring(2, excerpt.length() - 2);
                                    break;

                                } catch (Throwable t) {
                                    // nothing to do here, highlighting was empty
                                }
                            }

                            // clean up the excerpt
                            excerpt = excerpt.replaceAll("\\\\n", " ");
                            excerpt = excerpt.replaceAll("\\\\t", "");
                            result.setExcerpt(excerpt);
                        } catch (Throwable t) {
                            // nothing to do here, highlighting was empty
                        }
                    }
                }
                // finally add the search result
                searchResult.addDocument(result);
            }
        }

        //----------------------------------------------------------------------------------------------------
        // get the facets
        //----------------------------------------------------------------------------------------------------

        try {

            // get the facets
            JSONObject joFaceCounts = jsonSearchResult.get(I_CmsSearchConstants.NODE_FACETS).isObject();
            // collect the facets
            JSONObject joFacetFields = joFaceCounts.get(I_CmsSearchConstants.NODE_FACETFIELDS).isObject();
            // get all the facets
            Set<String> facetKeys = joFacetFields.keySet();

            for (String facetKey : facetKeys) {

                // for each facet found, extract the values and counts
                List<CmsSearchFacet> facetBeans = new ArrayList<CmsSearchFacet>();
                JSONArray jaSingleFacet = joFacetFields.get(facetKey).isArray();

                for (int j = 0; j <= (jaSingleFacet.size() - 1); j += 2) {
                    String name = jaSingleFacet.get(j).toString();
                    name = name.replaceAll("\"", "");
                    int count = new Double(jaSingleFacet.get(j + 1).isNumber().doubleValue()).intValue();
                    // add only those facet values to the result that have a count larger than 0
                    if (count > 0) {
                        CmsSearchFacet facetBean = new CmsSearchFacet(name, count);
                        facetBeans.add(facetBean);
                    }
                }
                // add the facet to the search result under its name
                searchResult.addFacet(facetKey, facetBeans);
            }
        } catch (Throwable t) {
            // no facetes found, so do nothing here
        }
        return searchResult;
    }

    /**
     * Converts the given JSON object to facet beans.<p>
     * 
     * @param joFacetFields the JSON
     * 
     * @return facet beans
     */
    protected Map<String, List<CmsSearchFacet>> toFacetBeans(JSONObject joFacetFields) {

        long facetsStart = System.currentTimeMillis();
        Map<String, List<CmsSearchFacet>> facets = new HashMap<String, List<CmsSearchFacet>>();
        for (String facetKey : joFacetFields.keySet()) {
            // for each facet found, extract the values and counts
            List<CmsSearchFacet> facetBeans = new ArrayList<CmsSearchFacet>();
            JSONArray jaSingleFacet = joFacetFields.get(facetKey).isArray();
            for (int j = 0; j <= (jaSingleFacet.size() - 1); j += 2) {
                String name = jaSingleFacet.get(j).toString();
                name = name.replaceAll("\"", "");
                int count = new Double(jaSingleFacet.get(j + 1).isNumber().doubleValue()).intValue();
                // add only those facet values to the result that have a count larger than 0
                if (count > 0) {
                    CmsSearchFacet facetBean = new CmsSearchFacet(name, count);
                    facetBeans.add(facetBean);
                }
            }
            // add the facet to the search result under its name
            facets.put(facetKey, facetBeans);
        }
        LOG.log(Level.INFO, "Facet Time: " + (System.currentTimeMillis() - facetsStart));
        return facets;
    }

    /**
     * Creates the loading.<p>
     */
    private void createLoading() {

        if (RootPanel.get("loading") != null) {
            Image img = new Image(I_CmsSearchLayoutBundle.INSTANCE.loading());
            img.setTitle(UserMessages.getMessage("label.loading"));
            img.setAltText(UserMessages.getMessage("label.loading"));
            HTMLPanel p = new HTMLPanel("p", UserMessages.getMessage("label.loading"));
            RootPanel.get("loading").add(img);
            RootPanel.get("loading").add(p);
        }
    }

    /**
     * Initializes the widgets.<p>
     */
    private void initWidgets() {

        for (Map.Entry<String, CmsWidgetConfig> widgetConfig : m_config.getWidgets().entrySet()) {
            String id = widgetConfig.getValue().getId();
            RootPanel.get().setStyleName("bodyScroll");
            RootPanel panel = RootPanel.get(id);
            if (panel != null) {
                switch (widgetConfig.getValue().getType()) {
                    case shareResult:
                        m_shareWidget = new CmsResultShareWidget(panel, this, widgetConfig.getValue());
                        break;
                    case advisorButton:
                        new CmsResultAdvisorWidget(panel, this, widgetConfig.getValue());
                        break;
                    case autocomplete:
                        new CmsAutoCompleteWidget(panel, this, widgetConfig.getValue());
                        break;
                    case autocompleteHeader:
                        new CmsAutoCompleteWidget(panel, this, widgetConfig.getValue());
                        break;
                    case resetFacets:
                        new CmsResetFacetWidget(panel, this, widgetConfig.getValue());
                        break;
                    case resultCount:
                        new CmsResultCountWidget(panel, this, widgetConfig.getValue());
                        break;
                    case resultList:
                        new CmsResultListWidget(panel, this, widgetConfig.getValue());
                        break;
                    case resultPagination:
                        new CmsPaginationWidget(panel, this, widgetConfig.getValue());
                        break;
                    case sortBar:
                        new CmsSortBarWidget(panel, this, widgetConfig.getValue());
                        break;
                    case textFacets:
                        for (CmsFacetConfig config : widgetConfig.getValue().getFacets().values()) {
                            if (!config.isHidden()) {
                                new CmsTextFacetWidget(
                                    panel,
                                    this,
                                    widgetConfig.getValue(),
                                    config.getField(),
                                    config.getLabel(),
                                    config.getSort(),
                                    config.isShowAll(),
                                    config.getDefaultCount(),
                                    config.getCssClass());
                            }
                        }
                        break;
                    default:
                        break;
                }
            }
        }
    }

    /**
     * Calls the given url as JSONP request and executes the given callback
     * with the resulting Json Object as parameter.<p>
     * 
     * @param requestUrl the URL to use for auto completion 
     * @param callback the callback to execute on success
     */
    private void sendJsonpRequest(final String requestUrl, final I_CmsSearchJsonCommand callback) {

        // create a new JSONLoader and send the request
        CmsSearchJSONLoader loader = new CmsSearchJSONLoader();
        loader.load(requestUrl, new I_CmsSearchCallback() {

            /**
             * @see com.alkacon.bootstrap.search.client.CmsSearchJSONLoader.I_CmsSearchCallback#onLoad(com.google.gwt.json.client.JSONObject)
             */
            public void onLoad(JSONObject jsonObject) {

                callback.execute(jsonObject);
            }
        });
    }

    /**
     * Calls the given url as JSON request and executes the given callback
     * with the resulting JSON Object as parameter.<p>
     * 
     * @param requestUrl the URL to use for auto completion 
     * @param callback the callback to execute on success
     */
    private void sendJsonRequest(final String requestUrl, final I_CmsSearchJsonCommand callback) {

        // Send request to server and catch any errors.
        try {
            new RequestBuilder(RequestBuilder.GET, requestUrl).sendRequest(null, new RequestCallback() {

                /**
                 * @see com.google.gwt.http.client.RequestCallback#onError(com.google.gwt.http.client.Request, java.lang.Throwable)
                 */
                public void onError(Request request, Throwable t) {

                    // Window.alert("Couldn't retrieve JSON " + t.getLocalizedMessage());
                }

                /**
                 * @see com.google.gwt.http.client.RequestCallback#onResponseReceived(com.google.gwt.http.client.Request, com.google.gwt.http.client.Response)
                 */
                public void onResponseReceived(Request request, Response response) {

                    if (200 == response.getStatusCode()) {
                        JSONObject jsonObject = JSONParser.parseStrict(response.getText()).isObject();
                        callback.execute(jsonObject);
                    } else {
                        // Window.alert("Couldn't retrieve JSON (" + response.getStatusText() + ")");
                    }
                }
            });
        } catch (RequestException e) {
            // Window.alert("Couldn't retrieve JSON " + e.getLocalizedMessage());
        }
    }

    /**
     * Sends a asynchronous JSON request.<p>
     * 
     * @param url the url to request
     * @param callback the callback executed on success
     */
    private void sendRequest(final String url, final I_CmsSearchJsonCommand callback) {

        if (m_config.isJsonp()) {
            sendJsonpRequest(url, callback);
        } else {
            sendJsonRequest(url, callback);
        }
    }
}
