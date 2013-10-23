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

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.google.gwt.http.client.URL;
import com.google.gwt.i18n.client.DateTimeFormat;
import com.google.gwt.user.client.rpc.IsSerializable;

/**
 * Stores all information to create a Solr query.<p>
 * 
 * Use the {@link #toString()} to get the Solr Query.<p>
 */
public class CmsSolrQueryData implements IsSerializable {

    /** Date format used by Solr. */
    public static final String SOLR_DATEFORMAT = "yyyy-MM-dd'T'HH:mm:ss'Z'";

    /** The general search configuration. */
    private CmsSolrConfig m_config;

    /** Signals whether this is a document center search or not. */
    private boolean m_docSearch;

    /** The end date. */
    private Date m_endDate;

    /** Map of additional facet filter. */
    private Map<String, List<String>> m_facetFilters = new HashMap<String, List<String>>();

    /** Signals if the search request was initiated by the Window.Location. */
    private boolean m_fromLocation;

    /** Page to display. */
    private int m_page;

    /** TODO : make this value configure-able. */
    private int m_paginationWindow = 3;

    /** Preselected parent fodlers. */
    private List<String> m_parentFolders;

    /** Preselected resource types. */
    private List<String> m_resourceTypes;

    /** Signals if the search was restored. */
    private boolean m_restored;

    /** The current root site. */
    private String m_rootSite;

    /** The number of results to be returned. */
    private int m_rows;

    /** Map of additional search parameters. */
    private Map<String, String> m_searchParams = new HashMap<String, String>();

    /** The query string. */
    private String m_searchQuery;

    /** The sort parameter value. */
    private String m_sort = "";

    /** The start date. */
    private Date m_startDate;

    /** The pagination window. */

    /** The current sub-site path. */
    private String m_subSitePath;

    /**
     * Creates a search data object.<p>
     * 
     * @param config the configuration
     */
    public CmsSolrQueryData(CmsSolrConfig config) {

        m_config = config;
    }

    /**
     * Reconstructs the the query data object from the given parameter string.<p>
     * 
     * @param config the Solr search configuration
     * @param parameterString the parameter as string
     * 
     * @return the reconstructed search data object
     */
    public static CmsSolrQueryData fromParameterString(CmsSolrConfig config, String parameterString) {

        String parameters = URL.decode(parameterString);
        CmsSolrQueryData data = new CmsSolrQueryData(config);
        if (parameters != null) {
            int lastQ = parameters.lastIndexOf("?");
            if (lastQ > 0) {
                parameters = parameters.substring(lastQ + 1);
            }
        }

        Map<String, String[]> params = CmsSolrStringUtil.createParameterMap(parameters);
        if ((params != null) && !params.isEmpty()) {
            String[] q = params.get("q");
            if ((q != null) && (q.length > 0)) {
                int lastBraket = q[0].lastIndexOf("}");
                if ((lastBraket > 0) && (q[0].length() >= (lastBraket + 1))) {
                    String qValue = q[0].substring(lastBraket + 1);
                    data.m_searchQuery = qValue;
                }
            }
            String[] fqs = params.get("fq");
            for (String fqVal : fqs) {
                if (fqVal != null) {
                    int lastBraket = fqVal.lastIndexOf("}");
                    if ((lastBraket > 0) && (fqVal.length() >= (lastBraket + 1))) {
                        String qFieldName = fqVal.substring(lastBraket + 1);
                        int nextOpen = qFieldName.indexOf(":(\"");
                        if (nextOpen > 0) {
                            qFieldName = qFieldName.substring(0, nextOpen);
                            if (qFieldName.trim().length() > 0) {
                                int lastTerm = fqVal.lastIndexOf(":(\"");
                                if (lastTerm > 2) {
                                    String qValue = fqVal.substring(lastTerm + 3);
                                    if (qValue != null) {
                                        int lastClose = qValue.lastIndexOf("\")");
                                        if (lastClose > 0) {
                                            qValue = qValue.substring(0, lastClose);
                                            if (qValue.length() > 0) {
                                                data.addFacetFilter(qFieldName, qValue);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return data;
    }

    /**
     * Restores the shortened query.<p>
     * 
     * @param config the config
     * @param parameterString the params
     * 
     * @return the query
     */
    public static CmsSolrQueryData fromShortQuery(CmsSolrConfig config, String parameterString) {

        String parameters = URL.decode(parameterString);

        CmsSolrQueryData data = new CmsSolrQueryData(config);
        if (parameters != null) {
            int lastQ = parameters.lastIndexOf("?");
            if (lastQ > 0) {
                parameters = parameters.substring(lastQ + 1);
            }
        }

        Map<String, String[]> params = CmsSolrStringUtil.createParameterMap(parameters);
        if ((params.get("q") != null) && (params.get("q")[0] != null)) {
            data.m_searchQuery = params.get("q")[0];
        }

        if ((params.get("fq") != null) && (params.get("fq")[0] != null)) {
            for (String s : params.get("fq")) {
                String[] splited = s.split(":");
                if (splited.length == 2) {
                    // data.addFacetFilter(splited[0], splited[1]);
                    String decodedValue = URL.decode(splited[1]);
                    String[] ors = decodedValue.split("\\+OR\\+");
                    for (int l = 0; l < ors.length; l++) {
                        String value = ors[l].replaceAll("\\(", "");
                        value = value.replaceAll("\\)", "");
                        value = value.replaceAll("\\\"", "");
                        data.addFacetFilter(splited[0], value);
                    }
                }
            }
        }
        return data;
    }

    /**
     * Shortens the query.<p>
     * 
     * @param parameterString the query params to shorten
     * 
     * @return the shortened query
     */
    public static final String shortQuery(String parameterString) {

        String parameters = URL.decode(parameterString);

        if (parameters != null) {
            int lastQ = parameters.lastIndexOf("?");
            if (lastQ > 0) {
                parameters = parameters.substring(lastQ + 1);

            }
        }
        boolean first = true;
        String result = "";
        Map<String, String[]> params = CmsSolrStringUtil.createParameterMap(parameters);
        if ((params != null) && !params.isEmpty()) {
            String[] q = params.get("q");
            if ((q != null) && (q.length > 0)) {
                int lastBraket = q[0].lastIndexOf("}");
                if ((lastBraket > 0) && (q[0].length() >= (lastBraket + 1))) {
                    String qValue = q[0].substring(lastBraket + 1);
                    result += "q=" + qValue;
                    first = false;
                }
            }
            String[] fqs = params.get("fq");
            for (String fqVal : fqs) {
                if (fqVal != null) {
                    int lastBraket = fqVal.lastIndexOf("}");
                    if ((lastBraket > 0) && (fqVal.length() >= (lastBraket + 1))) {
                        String qFieldName = fqVal.substring(lastBraket + 1);
                        int nextOpen = qFieldName.indexOf(":(\"");
                        if (nextOpen > 0) {
                            qFieldName = qFieldName.substring(0, nextOpen);
                            if (qFieldName.trim().length() > 0) {
                                int lastTerm = fqVal.lastIndexOf(":(\"");
                                if (lastTerm > 2) {
                                    String qValue = fqVal.substring(lastTerm + 1);
                                    if (qValue != null) {
                                        int lastClose = qValue.lastIndexOf("\")");
                                        if (lastClose > 0) {
                                            qValue = qValue.substring(0, lastClose + 2);
                                            if (qValue.length() > 0) {
                                                if (first) {
                                                    result += "fq=" + qFieldName + ":" + qValue;
                                                    first = false;
                                                } else {
                                                    result += "&fq=" + qFieldName + ":" + qValue;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return result;
    }

    /**
     * Adds a facet filter to the search query.<p>
     * 
     * @param filter the facet filter name
     * @param value the facet filter value
     */
    public void addFacetFilter(String filter, String value) {

        // check if there are any values for this filter
        List<String> filterList = m_facetFilters.get(filter);
        if (filterList == null) {
            // no values there yet, create a new list
            filterList = new ArrayList<String>();
        }
        // only add this value if it is not there already
        if (!filterList.contains(value)) {
            filterList.add(value);
        }
        m_facetFilters.put(filter, filterList);
    }

    /**
     * Adds a parameter to the search query.<p>
     * 
     * @param param the parameter name
     * @param value the parameter value
     */
    public void addParameter(String param, String value) {

        m_searchParams.put(param, value);
    }

    /**
     * Clears all additional  facet filters, etc.<p>
     */
    public void clearAll() {

        clearFacetFilters();
        clearPagination();
        clearSortOrder();
    }

    /**
     * Clears all facet filters.<p>
     */
    public void clearFacetFilters() {

        for (String facetFieldName : m_config.getFacetFieldNames()) {
            deleteFacetFilter(facetFieldName);
        }
        // m_facetFilters = new HashMap<String, List<String>>();
        m_startDate = null;
        m_endDate = null;
    }

    /**
     * Clears pagination.<p>
     */
    public void clearPagination() {

        m_page = 0;

    }

    /**
     * Clears all parameters.<p>
     */
    public void clearParameters() {

        m_searchParams = new HashMap<String, String>();

    }

    /**
     * Clears the sort order.<p>
     */
    public void clearSortOrder() {

        m_sort = "";
    }

    /**
     * Creates the actual autocomplete query string send to the search engine.<p>
     * 
     * @return a generated query string based on the search data
     */
    public String createAutocompleteString() {

        StringBuffer buf = new StringBuffer();
        buf.append(createQueryString());
        buf.append("&spellcheck=on");
        buf.append(URL.encode("&spellcheck.q="));
        buf.append(URL.encode(m_searchQuery.toLowerCase()));
        buf.append(URL.encode("&spellcheck.extendedResults=false"));
        buf.append(URL.encode("&spellcheck.collateExtendedResults=true"));
        buf.append(URL.encode("&spellcheck.onlyMorePopular=true"));
        return buf.toString();
    }

    /**
     * Creates the actual query string send to the search engine.<p>
     * 
     * @return a generated query string based on the search data
     */
    public String createQueryString() {

        StringBuffer buf = new StringBuffer(20);
        StringBuffer queryBuf = new StringBuffer(20);

        buf.append(m_config.getDefaultQuery());
        boolean first = true;
        if ((m_searchQuery != null) && !m_searchQuery.trim().isEmpty()) {
            //add the query fields
            queryBuf.append("{!type=" + m_config.getQueryType() + " q.op=AND qf='");
            for (String qf : m_config.getAutoCompleteFields()) {
                if (first) {
                    first = false;
                } else {
                    queryBuf.append(" ");
                }
                queryBuf.append(qf);
            }
            queryBuf.append("'}");
            queryBuf.append(m_searchQuery);
            buf.append(queryBuf);
        } else {
            buf.append("*:*");
        }
        first = true;
        if ((m_config.getReturnFields() != null) && !m_config.getReturnFields().isEmpty()) {
            buf.append("&fl=");
            for (String fl : m_config.getReturnFields()) {
                if (first) {
                    first = false;
                } else {
                    buf.append(",");
                }
                buf.append(fl);
            }
        }

        // add the additional search parameters as field queries
        for (String key : m_searchParams.keySet()) {
            String value = m_searchParams.get(key);
            buf.append("&fq=");
            buf.append(key);
            buf.append(":");
            buf.append(value);
        }

        buf.append(cerateFilterQuery("parent-folders", m_parentFolders, true));
        buf.append(cerateFilterQuery("type", m_resourceTypes, true));

        //add the facets
        buf.append("&facet=" + m_config.isFacet());
        for (String facet : m_config.getFacetFieldNames()) {
            if (!facet.equals(CmsSolrConfig.SPECIAL_SPACER_FIELD)) {
                buf.append("&facet.field=");
                // add an exclude if required
                if (m_facetFilters.get(facet) != null) {
                    buf.append("{!ex=");
                    buf.append(facet);
                    buf.append("}");
                }
                buf.append(facet);
            }
        }

        //add the facet filters
        buf.append("&facet.mincount=" + m_config.getFacetMinCount());
        for (String key : m_facetFilters.keySet()) {
            List<String> values = m_facetFilters.get(key);
            if ((values != null) && (values.size() > 0)) {
                buf.append("&fq={!tag=");
                buf.append(key);
                buf.append("}");
                buf.append(key);
                buf.append(":(");
                boolean firstValue = true;
                for (String value : values) {
                    if (firstValue) {
                        firstValue = false;
                    } else {
                        buf.append("+OR+");
                    }
                    buf.append("\"" + value + "\"");
                }
                buf.append(")");
            }
        }

        // add the date filter
        // only add date filter if any date is set
        if ((m_startDate != null) || (m_endDate != null)) {
            String startDate = "*";
            String endDate = "NOW";

            if (m_startDate != null) {
                startDate = DateTimeFormat.getFormat(SOLR_DATEFORMAT).format(m_startDate);
            }
            if (m_endDate != null) {
                endDate = DateTimeFormat.getFormat(SOLR_DATEFORMAT).format(m_endDate);
            }
            buf.append("&fq=lastmodified:[");
            buf.append(startDate);
            buf.append(" TO ");
            buf.append(endDate);
            buf.append("]");

        }
        buf.append("&rows=");
        buf.append(getRows());

        // add the pagination if required
        if ((getRows() > 0) || (m_page > 0)) {
            buf.append("&start=");
            buf.append(m_page * getRows());
        }

        // add the sorting if required
        if (!m_sort.equals("")) {
            buf.append("&sort=");
            buf.append(m_sort);
        }

        //add code for highlighting
        if ((m_searchQuery != null) && !m_searchQuery.trim().isEmpty() && !isDocSearch()) {
            buf.append("&hl=");
            buf.append(m_config.isHl());
            buf.append("&hl.fragsize=");
            buf.append(m_config.getHlFragsize());
            buf.append("&hl.q=");
            buf.append(queryBuf);
            buf.append("&hl.useFastVectorHighlighter=");
            buf.append(m_config.isHlFastVector());
            buf.append("&hl.fl=");
            first = true;
            for (String hlfield : m_config.getHighlightFields()) {
                if (first) {
                    first = false;
                } else {
                    buf.append(",");
                }
                buf.append(hlfield);
            }
        }

        if ((m_subSitePath != null) && (m_rootSite != null)) {
            if (m_subSitePath.startsWith(m_rootSite)) {
                buf.append("&baseUri=" + m_subSitePath.substring(m_rootSite.length()));
            }
        }
        return URL.encode(buf.toString());
    }

    /**
     * Deletes a complete facet filter with all values.<p>
     * 
     * @param filter facet filter name
     */
    public void deleteFacetFilter(String filter) {

        m_facetFilters.remove(filter);
    }

    /**
     * Returns the endDate.<p>
     *
     * @return the endDate
     */
    public Date getEndDate() {

        return m_endDate;
    }

    /**
     * Returns the facetFilters.<p>
     *
     * @return the facetFilters
     */
    public Map<String, List<String>> getFacetFilters() {

        return m_facetFilters;
    }

    /**
     * Returns the page.<p>
     *
     * @return the page
     */
    public int getPage() {

        return m_page;
    }

    /**
     * Returns the paginationWindow.<p>
     *
     * @return the paginationWindow
     */
    public int getPaginationWindow() {

        return m_paginationWindow;
    }

    /**
     * Gets the value for a search parameter.<p>
     * 
     * @param parameter the parameter name
     * 
     * @return the parameter value or null
     */
    public String getParameterValue(String parameter) {

        return m_searchParams.get(parameter);
    }

    /**
     * Returns the parentFolders.<p>
     *
     * @return the parentFolders
     */
    public List<String> getParentFolders() {

        return m_parentFolders;
    }

    /**
     * Returns the resourceTypes.<p>
     *
     * @return the resourceTypes
     */
    public List<String> getResourceTypes() {

        return m_resourceTypes;
    }

    /**
     * Returns the rootSite.<p>
     *
     * @return the rootSite
     */
    public String getRootSite() {

        return m_rootSite;
    }

    /**
     * Returns the row count.<p>
     * 
     * @return the row count
     */
    public int getRows() {

        return m_rows;
    }

    /**
     * Returns the searchQuery.<p>
     *
     * @return the searchQuery
     */
    public String getSearchQuery() {

        return m_searchQuery;
    }

    /**
     * Returns the sort.<p>
     *
     * @return the sort
     */
    public String getSort() {

        return m_sort;
    }

    /**
     * Returns the startDate.<p>
     *
     * @return the startDate
     */
    public Date getStartDate() {

        return m_startDate;
    }

    /**
     * Returns the subSitePath.<p>
     *
     * @return the subSitePath
     */
    public String getSubSitePath() {

        return m_subSitePath;
    }

    /**
     * Tests if the facet filter contain a facet name/value combination.<p>
     * 
     * @param filter the  facet filter name
     * @param value the  facet filter value
     * 
     * @return true if the combination exists, false otherwise
     */
    public boolean hasFacetFilter(String filter, String value) {

        boolean hasValue = false;
        List<String> filterList = m_facetFilters.get(filter);
        if (filterList != null) {
            if (filterList.contains(value)) {
                hasValue = true;
            }
        }
        return hasValue;

    }

    /**
     * Tests if there are any facet filters defined.<p>
     * 
     * @return true if facet filters are defined
     */
    public boolean hasFacetFilters() {

        if (m_facetFilters.size() > 0) {
            return true;
        }
        return false;
    }

    /**
     * Returns the docSearch.<p>
     *
     * @return the docSearch
     */
    public boolean isDocSearch() {

        return m_docSearch;
    }

    /**
     * Returns <code>true</true> if this query was restored.<p>
     *
     * @return <code>true</true> if this query was restored
     */
    public boolean isFromLocation() {

        return m_fromLocation;
    }

    /**
     * Returns the restored.<p>
     *
     * @return the restored
     */
    public boolean isRestored() {

        return m_restored;
    }

    /**
     * Puts the given map to the search parameters.<p>
     * 
     * @param params the parameters to put 
     */
    public void putParameters(Map<String, String> params) {

        m_searchParams.putAll(params);
    }

    /** 
     * Removed a specific facet filter value from the search query.<p>
     * 
     * If no filter value is left, remove the complete filter.<p>
     * 
     * @param filter the  facet filter name
     * @param value the  facet filter value
     */
    public void removeFacetFilter(String filter, String value) {

        // check if there are any values for this filter
        List<String> filterList = m_facetFilters.get(filter);
        if (filterList != null) {
            // check if the value to delete is in the filter value list
            if (filterList.contains(value)) {
                filterList.remove(value);

            }
            // remove the complete list if no other value is left
            if (filterList.size() == 0) {
                deleteFacetFilter(filter);
            }
        }
    }

    /**
     * Removes a parameter from the search query.<p>
     * 
     * @param parameter the parameter name
     */
    public void removeParameter(String parameter) {

        m_searchParams.remove(parameter);
    }

    /**
     * Sets the docSearch.<p>
     *
     * @param docSearch the docSearch to set
     */
    public void setDocSearch(boolean docSearch) {

        m_docSearch = docSearch;
    }

    /**
     * Sets the endDate.<p>
     *
     * @param endDate the endDate to set
     */
    public void setEndDate(Date endDate) {

        m_endDate = endDate;
    }

    /**
     * Sets the window location flag.<p>
     *
     * @param fromLocation the flag to set
     */
    public void setFromLocation(boolean fromLocation) {

        m_fromLocation = fromLocation;
    }

    /**
     * Sets the page.<p>
     *
     * @param page the page to set
     */
    public void setPage(int page) {

        m_page = page;
    }

    /**
     * Sets the paginationWindow.<p>
     *
     * @param paginationWindow the paginationWindow to set
     */
    public void setPaginationWindow(int paginationWindow) {

        m_paginationWindow = paginationWindow;
    }

    /**
     * Sets the parent folders.<p>
     * 
     * @param folders the folders to set
     */
    public void setParentFolders(List<String> folders) {

        m_parentFolders = folders;
    }

    /**
     * Sets the resource types.<p>
     * 
     * @param types the resource types to set
     */
    public void setResourceTypes(List<String> types) {

        m_resourceTypes = types;

    }

    /**
     * Sets the restored.<p>
     *
     * @param restored the restored to set
     */
    public void setRestored(boolean restored) {

        m_restored = restored;
    }

    /**
     * Sets the rootSite.<p>
     *
     * @param rootSite the rootSite to set
     */
    public void setRootSite(String rootSite) {

        m_rootSite = rootSite;
    }

    /**
     * Sets the rows.<p>
     *
     * @param rows the rows to set
     */
    public void setRows(int rows) {

        m_rows = rows;
    }

    /**
     * Sets the searchQuery.<p>
     *
     * @param searchQuery the searchQuery to set
     */
    public void setSearchQuery(String searchQuery) {

        m_searchQuery = searchQuery;

    }

    /**
     * Sets the sort.<p>
     *
     * @param sort the sort to set
     */
    public void setSort(String sort) {

        m_sort = sort;
    }

    /**
     * Sets the startDate.<p>
     *
     * @param startDate the startDate to set
     */
    public void setStartDate(Date startDate) {

        m_startDate = startDate;
    }

    /**
     * Sets the current sub site path.<p>
     * 
     * @param q the value to set
     */
    public void setSubSitePath(String q) {

        m_subSitePath = q;
    }

    /**
     * @see java.lang.Object#toString()
     */
    @Override
    public String toString() {

        StringBuffer buf = new StringBuffer(20);
        buf.append("[query:'");
        buf.append(m_searchQuery);
        buf.append("', StartDate:'");
        buf.append(m_startDate);
        buf.append("', EndDate:'");
        buf.append(m_endDate);
        buf.append("', Page:'");
        buf.append(m_page);
        buf.append("', Rows:'");
        buf.append(getRows());
        buf.append("', Params:['");
        boolean firstParam = true;
        for (String key : m_searchParams.keySet()) {
            String value = m_searchParams.get(key);
            buf.append(key);
            buf.append("=");
            buf.append(value);
            if (!firstParam) {
                buf.append(" | ");
            } else {
                firstParam = false;
            }
        }

        buf.append(cerateFilterQuery("parent-folders", m_parentFolders, true));
        buf.append(cerateFilterQuery("type", m_resourceTypes, true));

        buf.append("]', Facets:['");
        boolean firstFacet = true;
        for (String key : m_facetFilters.keySet()) {
            List<String> values = m_facetFilters.get(key);
            buf.append(key);
            buf.append("=");
            buf.append(values);
            if (!firstFacet) {
                buf.append(" | ");
            } else {
                firstFacet = false;
            }
        }

        buf.append("]', sort:[");
        buf.append(m_sort);

        buf.append("]', SOLR-Query:'");
        buf.append(createQueryString());
        buf.append("', Autocomplete-Query:'");
        buf.append(createAutocompleteString());
        buf.append("']");
        return buf.toString();
    }

    /**
     * Returns <code>true</code> if any selection has been made, <code>false</code> otherwise.<p>
     * 
     * @return <code>true</code> if any selection has been made, <code>false</code> otherwise
     */
    boolean hasSelection() {

        if (((m_searchQuery != null) && !m_searchQuery.trim().isEmpty()) || !getFacetFilters().isEmpty()) {
            return true;
        }
        return false;
    }

    /**
     * Creates a filter query.<p>
     * 
     * @param fieldName the field name
     * @param values the values
     * @param or the logical TERM
     * 
     * @return the fq string
     */
    private String cerateFilterQuery(String fieldName, List<String> values, boolean or) {

        StringBuffer result = new StringBuffer();
        if ((values != null) && !values.isEmpty()) {
            result.append("&fq=" + fieldName + ":(");
            Iterator<String> it = values.iterator();
            while (it.hasNext()) {
                String value = it.next();
                result.append(value);
                if (it.hasNext()) {
                    if (or) {
                        result.append(" OR ");
                    } else {
                        result.append(" AND ");
                    }
                } else {
                    result.append(")");
                }
            }
        }
        return result.toString();
    }
}
