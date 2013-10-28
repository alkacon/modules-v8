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

package com.alkacon.bootstrap.solr.client;

import com.alkacon.bootstrap.solr.client.CmsSolrConfig.CmsFacetConfig;
import com.alkacon.bootstrap.solr.client.CmsSolrConfig.CmsWidgetConfig;
import com.alkacon.bootstrap.solr.client.CmsSolrConfig.WIDGET_TYPES;
import com.alkacon.bootstrap.solr.client.CmsSolrJSONLoader.I_CmsSearchCallback;
import com.alkacon.bootstrap.solr.client.widgets.CmsAutoCompleteWidget;
import com.alkacon.bootstrap.solr.client.widgets.CmsPaginationWidget;
import com.alkacon.bootstrap.solr.client.widgets.CmsResetFacetWidget;
import com.alkacon.bootstrap.solr.client.widgets.CmsResultAdvisorWidget;
import com.alkacon.bootstrap.solr.client.widgets.CmsResultCountWidget;
import com.alkacon.bootstrap.solr.client.widgets.CmsResultListWidget;
import com.alkacon.bootstrap.solr.client.widgets.CmsResultShareWidget;
import com.alkacon.bootstrap.solr.client.widgets.CmsSelectionWidget;
import com.alkacon.bootstrap.solr.client.widgets.CmsSortBarWidget;
import com.alkacon.bootstrap.solr.client.widgets.I_CmsSearchWidget;
import com.alkacon.bootstrap.solr.client.widgets.datepicker.CmsDateFacetWidget;
import com.alkacon.bootstrap.solr.client.widgets.facet.CmsTextFacetWidget;

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
import com.google.gwt.user.client.ui.RootPanel;
import com.google.gwt.user.client.ui.SuggestOracle;
import com.google.gwt.user.client.ui.SuggestOracle.Suggestion;

/** 
 * Search controller containing the client side search logic.<p>
 */
public class CmsSolrController {

    /**
     * A map comparator.<p>
     * 
     * This comparator imposes orderings that are inconsistent with equals.<p>
     */
    protected class ValueComparator implements Comparator<String> {

        /** The base map. */
        protected Map<String, Double> m_base;

        /**
         * Constructor.<p>
         * 
         * @param base the map base
         */
        public ValueComparator(Map<String, Double> base) {

            m_base = base;
        }

        /**
         * Note: this comparator imposes orderings that are inconsistent with equals.
         * 
         * @see java.util.Comparator#compare(java.lang.Object, java.lang.Object)
         */
        public int compare(String a, String b) {

            if (m_base.get(a).doubleValue() >= m_base.get(b).doubleValue()) {
                return 1;
            } else {
                return -1;
            } // returning 0 would merge keys
        }
    }

    /**
     * The history handler.<p>
     */
    private class CmsHistoryValueChangeHandler implements ValueChangeHandler<String> {

        /** The forward query. */
        private String m_forwardQuery;

        /** The Solr config. */
        private CmsSolrConfig m_solrConfig;

        /** The Solr context. */
        private CmsSolrContext m_solrContext;

        /**
         * Public constructor with paramters.<p>
         * 
         * @param config the Solr configuration
         * @param context the Solr context
         */
        public CmsHistoryValueChangeHandler(CmsSolrConfig config, CmsSolrContext context) {

            m_solrConfig = config;
            m_solrContext = context;
        }

        /**
         * @see com.google.gwt.event.logical.shared.ValueChangeHandler#onValueChange(com.google.gwt.event.logical.shared.ValueChangeEvent)
         */
        public void onValueChange(ValueChangeEvent<String> event) {

            if (event.getValue().equals(m_lastQuery) || event.getValue().equals(m_forwardQuery)) {
                CmsSolrQueryData data = createSearchData(m_solrConfig, m_solrContext, event.getValue());
                if (data.hasSelection()) {
                    m_forwardQuery = CmsSolrQueryData.shortQuery(m_searchData.createQueryString());
                    doSearch(data, false);
                }
            }
        }
    }

    /** The logging object for this class. */
    private static final Logger LOG = Logger.getLogger("SearchController");

    /** The last executed query.*/
    protected String m_lastQuery;

    /** The last window location hash that was set manually. */
    protected String m_newLocationQuery;

    /** The search data bean. */
    protected CmsSolrQueryData m_searchData;

    /** Stores the search widgets. */
    protected Map<String, I_CmsSearchWidget> m_searchWidgets = new HashMap<String, I_CmsSearchWidget>();

    /** All titles. */
    List<String> m_titles = new ArrayList<String>();

    /** A timer. */
    private Timer m_autocompleteTimer;

    /** The initial Solr configuration. */
    private CmsSolrConfig m_config;

    /** The current search context. */
    private CmsSolrContext m_context;

    /** A timer. */
    private Timer m_loadingTimer;

    /** A timer. */
    private Timer m_searchTimer;

    /** The share widget. */
    private CmsResultShareWidget m_shareWidget;

    /** Suggestions. */
    private List<String> m_suggestions;

    /**
     * Creates a controller.<p>
     * 
     * @param config the configuration
     * @param context the context
     */
    public CmsSolrController(CmsSolrConfig config, CmsSolrContext context) {

        if (GWT.isProdMode()) {
            LOG.setLevel(Level.OFF);
        } else {
            LOG.setLevel(Level.INFO);
        }

        History.addValueChangeHandler(new CmsHistoryValueChangeHandler(config, context));

        m_config = config;
        m_context = context;
        m_searchData = createSearchData(config, context, null);
        if (m_searchData.isRestored()) {
            doSearch(null, false);
        } else {
            if (m_context.isInitialized()) {
                doSearch(null, true);
            }
        }
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
    protected static CmsSolrQueryData createSearchData(CmsSolrConfig config, CmsSolrContext context, String queryString) {

        CmsSolrQueryData data = null;
        if (queryString != null) {
            data = CmsSolrQueryData.fromShortQuery(config, queryString);
        }
        if ((data == null) || !data.hasSelection()) {
            data = CmsSolrQueryData.fromShortQuery(config, Window.Location.getHref());
            if (data != null) {
                data.setFromLocation(true);
            }
        }
        if ((data == null) || (!data.hasSelection() && (context.getInitialQuery() != null))) {
            data = CmsSolrQueryData.fromShortQuery(config, context.getInitialQuery());
        }
        if ((data == null) || !data.hasSelection()) {
            data = new CmsSolrQueryData(config);
            data.setSearchQuery(context.getSearchQuery());
        } else {
            data.setRestored(true);
        }

        CmsSolrQueryData searchData = data;
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
     * Executes the Solr search for auto completion.<p>
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
     * Executes the Solr search for auto completion.<p>
     * 
     * @param request the suggestion request
     * @param callback the suggestion callback to execute
     */
    public void doAutoComplete(final SuggestOracle.Request request, final SuggestOracle.Callback callback) {

        showLoading(20);
        if (m_autocompleteTimer != null) {
            m_autocompleteTimer.cancel();
        }
        m_autocompleteTimer = new Timer() {

            @Override
            public void run() {

                executeAutoCompletion(request, callback);
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
     * Calls the Solr server to do the search.<p>
     * 
     * @param data a optinal data object 
     * @param clearParameters flag to clear all additional search parameters and facet filters
     */
    public void doSearch(CmsSolrQueryData data, boolean clearParameters) {

        showLoading(20);
        if (data != null) {
            m_searchData = data;
        }

        m_lastQuery = History.getToken();

        // clear the search parameters if required
        if (clearParameters) {
            m_searchData.clearAll();
        }

        I_CmsSolrJsonCommand callback = new I_CmsSolrJsonCommand() {

            /**
             * @see com.alkacon.bootstrap.solr.client.I_CmsSolrJsonCommand#execute(com.google.gwt.json.client.JSONObject)
             */
            public void execute(JSONObject jsonObject) {

                String q = getSearchData().getSearchQuery().replaceAll("\"", "");
                if (m_titles.contains(q)) {
                    getSearchData().setSearchQuery(q);
                }

                CmsSolrDocumentList result = processSearch(jsonObject);
                for (I_CmsSearchWidget inputWidget : m_searchWidgets.values()) {
                    inputWidget.update(result);
                }
                if (!getSearchData().isFromLocation()) {
                    m_newLocationQuery = CmsSolrQueryData.shortQuery(getSearchData().createQueryString());
                    History.newItem(m_newLocationQuery, false);
                }
                getSearchData().setFromLocation(false);
                hideLoading();
            }
        };

        String q = m_searchData.createQueryString();
        String url = m_config.getSolrUrl() + q;
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
     * Returns the configuration.<p>
     *
     * @return the configuration
     */
    public CmsSolrConfig getConfig() {

        return m_config;
    }

    /**
     * Returns the context.<p>
     * 
     * @return the context
     */
    public CmsSolrContext getContext() {

        return m_context;
    }

    /**
     * Generates the link that can be shared.<p>
     * 
     * @return the share link
     */
    public String getLinkToShare() {

        String query = getSearchData().createQueryString().substring(1);
        String onlineLink = getContext().getOnlineUrl();
        String queryParams = CmsSolrQueryData.shortQuery(query);
        String link = onlineLink + "?" + queryParams;
        link = link.replace("/index.html", "");
        return link;
    }

    /**
     * Returns the searchData.<p>
     *
     * @return the searchData
     */
    public CmsSolrQueryData getSearchData() {

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
    public List<String> getSuggestions() {

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
    public void initTitles() {

        I_CmsSolrJsonCommand callback = new I_CmsSolrJsonCommand() {

            /**
             * @see com.alkacon.bootstrap.solr.client.I_CmsSolrJsonCommand#execute(com.google.gwt.json.client.JSONObject)
             */
            public void execute(JSONObject jsonObject) {

                getTitles().clear();
                // get the facets
                try {
                    JSONObject joFaceCounts = jsonObject.get(I_CmsSolrConstants.NODE_FACETS).isObject();
                    JSONObject joFacetFields = joFaceCounts.get(I_CmsSolrConstants.NODE_FACETFIELDS).isObject();
                    Map<String, List<CmsSolrFacet>> factes = toFacetBeans(joFacetFields);
                    List<CmsSolrFacet> beans = factes.get("Title_exact");
                    for (CmsSolrFacet facet : beans) {
                        getTitles().add(facet.getName());
                    }
                } catch (Throwable t) {
                    // no facets found, so do nothing here
                }
            }

        };

        sendRequest(m_config.getSolrUrl() + m_config.getTitleQuery(), callback);
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

        I_CmsSolrJsonCommand callback = new I_CmsSolrJsonCommand() {

            /**
             * @see com.alkacon.bootstrap.solr.client.I_CmsSolrJsonCommand#execute(com.google.gwt.json.client.JSONObject)
             */
            public void execute(JSONObject jsonObject) {

                processAutoComplete(widgetToUpdate, jsonObject);
            }
        };

        String url = m_config.getSolrUrl() + m_searchData.createAutocompleteString();
        sendRequest(url, callback);
    }

    /**
     * Executes the auto completion.<p>
     * 
     * @param request the suggestion request
     * @param callback the suggestion callback to execute
     */
    protected void executeAutoCompletion(final SuggestOracle.Request request, final SuggestOracle.Callback callback) {

        I_CmsSolrJsonCommand solrCallback = new I_CmsSolrJsonCommand() {

            /**
             * @see com.alkacon.bootstrap.solr.client.I_CmsSolrJsonCommand#execute(com.google.gwt.json.client.JSONObject)
             */
            public void execute(JSONObject jsonObject) {

                processAutoComplete(request, callback, jsonObject);
                CmsSolrDocumentList result = processSearch(jsonObject);
                for (I_CmsSearchWidget inputWidget : m_searchWidgets.values()) {
                    if (inputWidget.updateOnSearch()) {
                        inputWidget.update(result);
                    }
                }
                hideLoading();

            }
        };
        m_searchData.clearAll();
        String url = m_config.getSpellUrl() + m_searchData.createAutocompleteString();
        sendRequest(url, solrCallback);
    }

    //    /**
    //     * Returns the window location hash.<p>
    //     * 
    //     * @return the window location hash
    //     */
    //    protected native String getWindowLocationHash()/*-{
    //
    //        if ($wnd.location.hash) {
    //            return $wnd.location.hash.slice(1, $wnd.location.hash.length);
    //        }
    //        return null;
    //    }-*/;

    /**
     * @param autoCompleteWidget
     * @param object
     */
    protected void processAutoComplete(final String autoCompleteWidget, JSONObject object) {

        // process the search result to get search result objects
        CmsSolrDocumentList result = processSearch(object);

        for (String facetName : result.getFacetNames()) {
            // first get all values for the current facet
            List<CmsSolrFacet> facetValues = result.getFacet(facetName);
            // iterate over them to get the auto completion results
            for (CmsSolrFacet facetBean : facetValues) {
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

            m_suggestions = new LinkedList<String>();

            String q = m_searchData.getSearchQuery().replaceAll("\"", "");
            q = q.toLowerCase();

            HashMap<String, Double> map = new HashMap<String, Double>();
            TreeMap<String, Double> collationMap = new TreeMap<String, Double>(new ValueComparator(map));

            if (callback != null) {

                if (object.get("spellcheck") != null) {
                    // CmsSolrResult searchResult = new CmsSolrResult();
                    JSONObject spellcheck = object.get("spellcheck").isObject();
                    JSONArray suggestions = spellcheck.get("suggestions").isArray();

                    for (int i = 0; i < suggestions.size(); i++) {
                        JSONValue val = suggestions.get(i);
                        if (val.isString() != null) {
                            String sugg = val.isString().stringValue();
                            if (sugg.equals(q)) {
                                JSONObject collations = suggestions.get(i + 1).isObject();
                                JSONArray suggestion = collations.get("suggestion").isArray();
                                if (suggestion != null) {
                                    for (int j = 0; j < suggestion.size(); j++) {
                                        String collQ = suggestion.get(j).isString().stringValue();
                                        Double collC = new Double(j);
                                        map.put(collQ, collC);
                                    }
                                    break;
                                }
                            }
                        }
                    }
                    // sort the result by hits
                    collationMap.putAll(map);
                    m_suggestions.addAll(collationMap.keySet());
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

                for (final Map.Entry<String, Double> sug : collationMap.entrySet()) {
                    final String sugg = sug.getKey().replaceAll("\"", "");

                    res.add(new Suggestion() {

                        /**
                         * @see com.google.gwt.user.client.ui.SuggestOracle.Suggestion#getDisplayString()
                         */
                        public String getDisplayString() {

                            return sugg;
                        }

                        /**
                         * @see com.google.gwt.user.client.ui.SuggestOracle.Suggestion#getReplacementString()
                         */
                        public String getReplacementString() {

                            return sugg;
                        }
                    });
                }
                SuggestOracle.Response response = new SuggestOracle.Response();
                response.setSuggestions(res);
                callback.onSuggestionsReady(request, response);
            }

        } catch (Throwable t) {
            LOG.log(Level.WARNING, "Suggestion is not a String", t);
        }
    }

    /**
     * Processes the received JSON Object to create a list of result objects.<p>
     *
     * @param jsonSearchResult result received form Solr
     * @return CmsSolrResult with list of CmsSolrResultBean objects, containing the search result
     */
    protected CmsSolrDocumentList processSearch(JSONObject jsonSearchResult) {

        CmsSolrDocumentList searchResult = new CmsSolrDocumentList();
        JSONObject response = jsonSearchResult.get(I_CmsSolrConstants.NODE_RESPONSE).isObject();
        searchResult.setHits(new Integer(response.get(I_CmsSolrConstants.NODE_NUM_FOUND).isNumber().toString()).intValue());

        // get the found documents
        JSONArray docs = response.get(I_CmsSolrConstants.NODE_DOCS).isArray();
        List<JSONObject> documentObjects = new LinkedList<JSONObject>();

        if (docs != null) {
            for (int i = 0; i <= (docs.size() - 1); i++) {

                // iterate over the found documents
                JSONObject document = docs.get(i).isObject();
                documentObjects.add(document);
                // build the result object
                CmsSolrDocument result = new CmsSolrDocument();

                //---------------------------------------------------------------------------------------------------
                // get the direct result values
                //----------------------------------------------------------------------------------------------------

                // get the title           
                String title = UserMessages.undefined();
                try {
                    title = document.get(CmsSolrDocumentList.FL_TITLE_PROP).isString().stringValue();
                } catch (Throwable t) {
                    // nothing to do here, title was empty
                }
                result.setTitle(title);

                // get the resource path
                String path = UserMessages.undefined();
                try {
                    path = document.get(CmsSolrDocumentList.FL_PATH).isString().stringValue();
                } catch (Throwable t) {
                    // nothing to do here, path was empty
                }
                result.setPath(path);

                // get the "gg.version_exact" field
                String version = UserMessages.undefined();
                try {
                    if (document.get("version") != null) {
                        version = document.get("version").isString().stringValue();
                    }
                } catch (Throwable t) {
                    // nothing to do here, path was empty
                }
                result.setVersion(version);

                // get the "lastmodified" field
                String lastmodified = UserMessages.undefined();
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
                String suffix = UserMessages.undefined();
                try {
                    suffix = document.get("suffix").isString().stringValue();
                } catch (Throwable t) {
                    // nothing to do here, path was empty
                }
                result.setSuffix(suffix);

                // get the "size" field
                String size = UserMessages.undefined();
                try {
                    int bytes = new Integer(document.get("size").isNumber().toString()).intValue();
                    int kb = Math.round(bytes / 1000);
                    size = kb + " KB";
                } catch (Throwable t) {
                    // nothing to do here, path was empty
                }
                result.setSize(size);

                // get the resource path
                String link = UserMessages.undefined();
                try {
                    link = document.get(CmsSolrDocumentList.FL_LINK).isString().stringValue();
                } catch (Throwable t) {
                    // nothing to do here, path was empty
                }
                result.setLink(link);

                // get the resource type
                String type = "";
                try {
                    type = document.get(CmsSolrDocumentList.FL_TYPE).isString().stringValue();
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
                    id = document.get(CmsSolrDocumentList.FL_ID).isString().stringValue();
                } catch (Throwable t) {
                    // nothing to do here, id was empty
                }
                result.setId(id);

                // get the content locales
                List<String> locales = new ArrayList<String>();
                try {
                    JSONArray arr = document.get(CmsSolrDocumentList.FL_CON_LOCALES).isArray();
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

                String language = "";
                if (!locales.isEmpty() && (locales.size() == 1)) {
                    language = locales.get(0);
                } else {
                    try {
                        if (document.get(CmsSolrDocumentList.FL_LANGUGAE) != null) {
                            language = document.get(CmsSolrDocumentList.FL_LANGUGAE).isString().stringValue();
                        }
                    } catch (Throwable t) {
                        // nothing to do here, id was empty
                    }
                }
                result.setLanguage(language);

                //----------------------------------------------------------------------------------------------------
                // get the locale versions
                //----------------------------------------------------------------------------------------------------
                try {
                    if (document.get(CmsSolrDocumentList.FL_DEP_VAR) != null) {
                        // first of all, do not forget to add the search result itself
                        CmsSolrDocumentAttachment self = new CmsSolrDocumentAttachment(title, link, language);
                        result.addLocaleVerion(self);
                        JSONArray languages = document.get(CmsSolrDocumentList.FL_DEP_VAR).isArray();
                        for (int j = 0; j < languages.size(); j++) {
                            String js = languages.get(j).isString().stringValue();
                            JSONObject joLanguage = JSONParser.parseStrict(js).isObject();
                            String lvPath = null;
                            try {
                                lvPath = joLanguage.get(I_CmsSolrConstants.NODE_LINK).isString().stringValue();
                            } catch (Throwable t1) {
                                System.out.println(t1);
                            }
                            if (lvPath == null) {
                                lvPath = joLanguage.get(I_CmsSolrConstants.NODE_PATH).isString().stringValue();
                            }
                            String lvLocale = joLanguage.get(I_CmsSolrConstants.NODE_LOCALE).isString().stringValue();
                            String lvTitle = UserMessages.getMessage(lvLocale);
                            CmsSolrDocumentAttachment localeVersion = new CmsSolrDocumentAttachment(
                                lvTitle,
                                lvPath,
                                lvLocale);
                            result.addLocaleVerion(localeVersion);
                        }
                    }
                } catch (Throwable t1) {
                    System.out.println(t1);
                }

                //----------------------------------------------------------------------------------------------------
                // get the main document
                //----------------------------------------------------------------------------------------------------
                try {
                    if (document.get(CmsSolrDocumentList.FL_DEP_DOC) != null) {
                        JSONObject main = document.get(CmsSolrDocumentList.FL_DEP_DOC).isObject();
                        if (main != null) {
                            String maTitle = main.get(I_CmsSolrConstants.NODE_TITLE).isString().stringValue();
                            String maPath = null;
                            try {
                                maPath = main.get(I_CmsSolrConstants.NODE_LINK).isString().stringValue();
                            } catch (Throwable t1) {
                                System.out.println(t1);
                            }
                            if (maPath == null) {
                                maPath = main.get(I_CmsSolrConstants.NODE_PATH).isString().stringValue();
                            }
                            String maLocale = main.get(I_CmsSolrConstants.NODE_LOCALE).isString().stringValue();
                            CmsSolrDocumentAttachment mainDoc = new CmsSolrDocumentAttachment(maTitle, maPath, maLocale);
                            result.setMainDocuemnt(mainDoc);
                        }
                    }
                } catch (Throwable t1) {
                    // noop
                }

                //----------------------------------------------------------------------------------------------------
                // get the attachments
                //----------------------------------------------------------------------------------------------------
                try {
                    if (document.get(CmsSolrDocumentList.FL_DEP_ATT) != null) {
                        JSONArray attachments = document.get(CmsSolrDocumentList.FL_DEP_ATT).isArray();
                        for (int k = 0; k < attachments.size(); k++) {
                            String js = attachments.get(k).isString().stringValue();
                            JSONObject joAttachment = JSONParser.parseStrict(js).isObject();
                            String atTitle = joAttachment.get(I_CmsSolrConstants.NODE_TITLE).isString().stringValue();
                            String atPath = null;
                            try {
                                atPath = joAttachment.get(I_CmsSolrConstants.NODE_LINK).isString().stringValue();
                            } catch (Throwable t1) {
                                System.out.println(t1);
                            }
                            if (atPath == null) {
                                atPath = joAttachment.get(I_CmsSolrConstants.NODE_PATH).isString().stringValue();
                            }
                            String atLocale = joAttachment.get(I_CmsSolrConstants.NODE_LOCALE).isString().stringValue();
                            CmsSolrDocumentAttachment attachment = new CmsSolrDocumentAttachment(
                                atTitle,
                                atPath,
                                atLocale);
                            result.addAttachment(attachment);
                        }
                    }
                } catch (Throwable t1) {
                    // noop
                }

                //----------------------------------------------------------------------------------------------------
                // get the highlighting
                //----------------------------------------------------------------------------------------------------

                // check if there is some highlighting info for this entry
                if (jsonSearchResult.get(I_CmsSolrConstants.NODE_HIGHLIGHTING) != null) {
                    JSONObject highlighting = jsonSearchResult.get(I_CmsSolrConstants.NODE_HIGHLIGHTING).isObject();
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
                } else {
                    try {
                        if (!CmsSolrStringUtil.isEmpty(language) && (document.get(language + "_excerpt") != null)) {
                            String excerpt = document.get(language + "_excerpt").toString();
                            if (excerpt != null) {
                                excerpt = excerpt.substring(2, excerpt.length() - 2);
                                excerpt = excerpt.replaceAll("\\\\n", " ");
                                excerpt = excerpt.replaceAll("\\\\t", "");
                                result.setExcerpt(CmsSolrStringUtil.trimToSize(excerpt, 200, " ..."));
                            }
                        }
                    } catch (Throwable t) {
                        // noop
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
            JSONObject joFaceCounts = jsonSearchResult.get(I_CmsSolrConstants.NODE_FACETS).isObject();
            // collect the facets
            JSONObject joFacetFields = joFaceCounts.get(I_CmsSolrConstants.NODE_FACETFIELDS).isObject();
            // get all the facets
            Set<String> facetKeys = joFacetFields.keySet();

            for (String facetKey : facetKeys) {

                // for each facet found, extract the values and counts
                List<CmsSolrFacet> facetBeans = new ArrayList<CmsSolrFacet>();
                JSONArray jaSingleFacet = joFacetFields.get(facetKey).isArray();

                for (int j = 0; j <= (jaSingleFacet.size() - 1); j += 2) {
                    String name = jaSingleFacet.get(j).toString();
                    name = name.replaceAll("\"", "");
                    int count = new Double(jaSingleFacet.get(j + 1).isNumber().doubleValue()).intValue();
                    // add only those facet values to the result that have a count larger than 0
                    if (count > 0) {
                        CmsSolrFacet facetBean = new CmsSolrFacet(name, count);
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
    Map<String, List<CmsSolrFacet>> toFacetBeans(JSONObject joFacetFields) {

        long facetsStart = System.currentTimeMillis();
        Map<String, List<CmsSolrFacet>> facets = new HashMap<String, List<CmsSolrFacet>>();
        for (String facetKey : joFacetFields.keySet()) {
            // for each facet found, extract the values and counts
            List<CmsSolrFacet> facetBeans = new ArrayList<CmsSolrFacet>();
            JSONArray jaSingleFacet = joFacetFields.get(facetKey).isArray();
            for (int j = 0; j <= (jaSingleFacet.size() - 1); j += 2) {
                String name = jaSingleFacet.get(j).toString();
                name = name.replaceAll("\"", "");
                int count = new Double(jaSingleFacet.get(j + 1).isNumber().doubleValue()).intValue();
                // add only those facet values to the result that have a count larger than 0
                if (count > 0) {
                    CmsSolrFacet facetBean = new CmsSolrFacet(name, count);
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
                    case currentSelection:
                        new CmsSelectionWidget(panel, this, widgetConfig.getValue());
                        break;
                    case dateRanges:
                        new CmsDateFacetWidget(panel, this, widgetConfig.getValue());
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
    private void sendJsonpRequest(final String requestUrl, final I_CmsSolrJsonCommand callback) {

        // create a new JSONLoader and send the request
        CmsSolrJSONLoader loader = new CmsSolrJSONLoader();
        loader.load(requestUrl, new I_CmsSearchCallback() {

            /**
             * @see com.alkacon.bootstrap.solr.client.CmsSolrJSONLoader.I_CmsSearchCallback#onLoad(com.google.gwt.json.client.JSONObject)
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
    private void sendJsonRequest(final String requestUrl, final I_CmsSolrJsonCommand callback) {

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
    private void sendRequest(final String url, final I_CmsSolrJsonCommand callback) {

        if (m_config.isJsonp()) {
            sendJsonpRequest(url, callback);
        } else {
            sendJsonRequest(url, callback);
        }
    }
}
