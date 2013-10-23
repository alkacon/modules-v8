/*
 * This library is part of OpenCms -
 * the Open Source Content Management System
 *
 * Copyright (c) Alkacon Software GmbH (http://www.alkacon.com)
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
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.google.gwt.json.client.JSONArray;
import com.google.gwt.json.client.JSONObject;
import com.google.gwt.json.client.JSONString;
import com.google.gwt.json.client.JSONValue;

/**
 * Implements a Java object representation for the following JSON.<p>
 * 
 * <pre>
 * {
 *     "general" : {
 *         "solrUrl" : "http://localhost:8080/opencms/opencms/handleSolrSelect",
 *         "rows" : 10,
 *         "defaultQuery" : "*:*",
 *         "fl" : [ "id", "path", "type", "suffix", "language", "Title_prop", "dep_attachment", "dep_document", "dep_variant" ],
 *         "hl" : true,
 *         "hl.fl" : [ "content_en", "content_de", "Title_prop" ],
 *         "jsonp" : false,
 *         "facet.mincount" : 1,
 *         "facet.limit" : 15
 *     },
 *     "currentSelection" : {
 *         "id" : "solrWidgetCurrentSelection",
 *         "label" : "Your selection",
 *     },
 *     "autocomplete" : {
 *         "id" : "solrWidgetAutoComplete",
 *         "labels" : [ "Search" ],
 *         "fields" : [ "content_en", "content_de", "Title_prop" ]
 *     },
 *     "autocompleteHeader" : {
 *         "id" : "solrWidgetAutoCompleteHeader",
 *         "labels" : [ "Search" ],
 *         "fields" : [ "content_en", "content_de", "Title_prop" ]
 *     },
 *     "dateRanges" : {
 *         "id" : "solrWidgetDateRange",
 *         "labels" : [ "Last changes" ],
 *         "fields" : [ "lastmodified" ]
 *     },
 *     "textFacets" : {
 *         "id" : 'solrWidgetTextFacet',
 *         "labels" : [ 'Category', 'Language', 'Suffix' ],
 *         "fields" : [ 'category', 'language', 'suffix' ]
 *     },
 *     "sortBar" : {
 *         "id" : solrWidgetSortBar,
 *         "fields" : [ "lastmodified, "Title_prop" ],
 *         "labels" : [ "Date asc, Date desc", "Title asc, Title desc" ]
 * 
 *     },
 *     "resultList" : {
 *         "id" : "solrWidgetResultList",
 *     },
 *     "resultPagination" : {
 *         "id" : "solrWidgetResultPagination",
 *     }
 * }
 * </pre>
 */
public class CmsSolrConfig {

    /**
     * Stores the configuration for a facet widget.<p>
     */
    public class CmsFacetConfig {

        /** The CSS class used for this widget. */
        private String m_cssClass;

        /** The default count of facets to show. */
        private int m_defaultCount;

        /** The field name. */
        private String m_field;

        /** The label. */
        private String m_label;

        /** The show all flag. */
        private boolean m_showAll;

        /** The sort flag. */
        private CmsSolrFacet.FACET_SORT m_sort;

        /**
         * Default constructor.<p>
         */
        public CmsFacetConfig() {

            // noop
        }

        /**
         * Constructor with parameters.<p>
         * 
         * @param field the field
         * @param label the label
         * @param sort the sort variant
         * @param showAll the show all flag
         * @param defaultCount the default count of facets to show
         * @param cssClass the display class
         */
        public CmsFacetConfig(
            String field,
            String label,
            CmsSolrFacet.FACET_SORT sort,
            boolean showAll,
            int defaultCount,
            String cssClass) {

            m_field = field;
            m_label = label;
            m_sort = sort;
            m_showAll = showAll;
            m_defaultCount = defaultCount;
            m_cssClass = cssClass;
        }

        /**
         * Returns the cssClass.<p>
         *
         * @return the cssClass
         */
        public String getCssClass() {

            return m_cssClass;
        }

        /**
         * Returns the defaultCount.<p>
         *
         * @return the defaultCount
         */
        public int getDefaultCount() {

            return m_defaultCount;
        }

        /**
         * Returns the field.<p>
         *
         * @return the field
         */
        public String getField() {

            return m_field;
        }

        /**
         * Returns the label.<p>
         *
         * @return the label
         */
        public String getLabel() {

            return m_label;
        }

        /**
         * Returns the sort.<p>
         *
         * @return the sort
         */
        public CmsSolrFacet.FACET_SORT getSort() {

            return m_sort;
        }

        /**
         * Returns <code>true</code> if this facet should not be visible.<p>
         * 
         * @return <code>true</code> if this facet should not be visible
         */
        public boolean isHidden() {

            return HIDDEN.equals(m_cssClass.toLowerCase());
        }

        /**
         * Returns the showAll.<p>
         *
         * @return the showAll
         */
        public boolean isShowAll() {

            return m_showAll;
        }

        /**
         * Sets the cssClass.<p>
         *
         * @param cssClass the cssClass to set
         */
        public void setCssClass(String cssClass) {

            m_cssClass = cssClass;
        }

        /**
         * Sets the defaultCount.<p>
         *
         * @param defaultCount the defaultCount to set
         */
        public void setDefaultCount(int defaultCount) {

            m_defaultCount = defaultCount;
        }

        /**
         * Sets the field.<p>
         *
         * @param field the field to set
         */
        public void setField(String field) {

            m_field = field;
        }

        /**
         * Sets the label.<p>
         *
         * @param label the label to set
         */
        public void setLabel(String label) {

            m_label = label;
        }

        /**
         * Sets the showAll.<p>
         *
         * @param showAll the showAll to set
         */
        public void setShowAll(boolean showAll) {

            m_showAll = showAll;
        }

        /**
         * Sets the sort.<p>
         *
         * @param sort the sort to set
         */
        public void setSort(CmsSolrFacet.FACET_SORT sort) {

            m_sort = sort;
        }
    }

    /**
     * Bean that stores a single widget configuration.<p>
     */
    public class CmsWidgetConfig {

        /** The facet field names. */
        private List<String> m_facetFieldNames;

        /** The configured widgets. */
        private Map<String, CmsFacetConfig> m_facets = new LinkedHashMap<String, CmsFacetConfig>();

        /** The fields used for this widget. */
        private TreeMap<String, String> m_fields;

        /** The id for this config. */
        private String m_id;

        /** The label for this widget. */
        private String m_label;

        /** The type of this widget. */
        private WIDGET_TYPES m_type;

        /**
         * Default constructor.<p>
         */
        public CmsWidgetConfig() {

            // noop
        }

        /**
         * Returns the facet fields for this configuration.<p>
         * 
         * @return the facet fields for this configuration
         */
        public List<String> getFacetFieldNames() {

            if ((m_facets != null) && (m_facetFieldNames == null)) {
                m_facetFieldNames = new ArrayList<String>();
                for (CmsFacetConfig conf : m_facets.values()) {
                    m_facetFieldNames.add(conf.getField());
                }
            }
            return m_facetFieldNames;
        }

        /**
         * Returns the facets.<p>
         *
         * @return the facets
         */
        public Map<String, CmsFacetConfig> getFacets() {

            return m_facets;
        }

        /**
         * Returns the fields.<p>
         *
         * @return the fields
         */
        public TreeMap<String, String> getFields() {

            return m_fields;
        }

        /**
         * Returns the id.<p>
         *
         * @return the id
         */
        public String getId() {

            return m_id;
        }

        /**
         * Returns the label.<p>
         *
         * @return the label
         */
        public String getLabel() {

            return m_label;
        }

        /**
         * Returns the type.<p>
         *
         * @return the type
         */
        public WIDGET_TYPES getType() {

            return m_type;
        }

        /**
         * Sets the facet configurations.<p>
         * 
         * @param facets the configs to set
         */
        public void setFacets(List<CmsFacetConfig> facets) {

            for (CmsFacetConfig con : facets) {
                m_facets.put(con.getField(), con);
            }
        }

        /**
         * Sets the fields.<p>
         *
         * @param fields the fields to set
         */
        public void setFields(TreeMap<String, String> fields) {

            m_fields = fields;
        }

        /**
         * Sets the id.<p>
         *
         * @param id the id to set
         */
        public void setId(String id) {

            m_id = id;
        }

        /**
         * Sets the label.<p>
         *
         * @param label the label to set
         */
        public void setLabel(String label) {

            m_label = label;
        }

        /**
         * Sets the type.<p>
         *
         * @param type the type to set
         */
        public void setType(WIDGET_TYPES type) {

            m_type = type;
        }
    }

    /** Possible widget types. */
    public enum WIDGET_TYPES {

        /** Widget type. */
        advisorButton,

        /** Widget type. */
        autocomplete,

        /** Widget type. */
        autocompleteHeader,

        /** Widget type. */
        currentSelection,

        /** Widget type. */
        dateRanges,

        /** Widget type. */
        resetFacets,

        /** Widget type. */
        resultCount,

        /** Widget type. */
        resultList,

        /** Widget type. */
        resultPagination,

        /** Widget type. */
        resultTable,

        /** Widget type. */
        shareResult,

        /** Widget type. */
        sortBar,

        /** Widget type. */
        textFacets
    }

    /** The hidden text. */
    public static final String HIDDEN = "hidden";

    /** This is a dummy field constant for adding a text spacer between factes. */
    public static final String SPECIAL_SPACER_FIELD = "SPACER";

    /** JSON node constant. */
    protected static final String NODE_AUTO_COMPLETE_DELAY = "auto.complete.delay";

    /** JSON node constant. */
    protected static final String NODE_DEFAULT_QUERY = "defaultQuery";

    /** JSON node constant. */
    protected static final String NODE_FACET = "facet";

    /** JSON node constant. */
    protected static final String NODE_FACET_LIMIT = "facet.limit";

    /** JSON node constant. */
    protected static final String NODE_FACET_MIN_COUNT = "facet.mincount";

    /** JSON node constant. */
    protected static final String NODE_FL = "fl";

    /** JSON node constant. */
    protected static final String NODE_GENERAL = "general";

    /** JSON node constant. */
    protected static final String NODE_HL = "hl";

    /** JSON node constant. */
    protected static final String NODE_HL_FAST = "hl.useFastVectorHighlighter";

    /** JSON node constant. */
    protected static final String NODE_HL_FL = "hl.fl";

    /** JSON node constant. */
    protected static final String NODE_HL_FRAGSIZE = "hl.fragsize";

    /** JSON node constant. */
    protected static final String NODE_JSONP = "jsonp";

    /** JSON node constant. */
    protected static final String NODE_QUERY_TYPE = "qt";

    /** JSON node constant. */
    protected static final String NODE_ROWS = "rows";

    /** JSON node constant. */
    protected static final String NODE_SOLR_URL = "solrUrl";

    /** JSON node constant. */
    protected static final String NODE_SPELL_URL = "spellUrl";

    /** JSON node constant. */
    protected static final String NODE_TITLE_QUERY = "titleQuery";

    /** Widget config name. */
    protected static final String WIDGET_AUTO_COMPLETE = "autocomplete";

    /** Widget config name. */
    protected static final String WIDGET_AUTO_COMPLETE_HEADER = "autocompleteHeader";

    /** JSON node constant. */
    protected static final String WIDGET_CONFIG_CSS_CLASS = "cssClass";

    /** JSON node constant. */
    protected static final String WIDGET_CONFIG_FACETS = "facets";

    /** JSON node constant. */
    protected static final String WIDGET_CONFIG_FIELD = "field";

    /** Widget config name. */
    protected static final String WIDGET_CONFIG_FILEDS = "fields";

    /** Widget config name. */
    protected static final String WIDGET_CONFIG_ID = "id";

    /** Widget config name. */
    protected static final String WIDGET_CONFIG_LABEL = "label";

    /** Widget config name. */
    protected static final String WIDGET_CONFIG_LABELS = "labels";

    /** JSON node constant. */
    protected static final String WIDGET_CONFIG_SHOW_ALL = "showAll";

    /** JSON node constant. */
    protected static final String WIDGET_CONFIG_SORT = "alphasort";

    /** Widget config name. */
    protected static final String WIDGET_DATE_RANGES = "dateRanges";

    /** JSON node constant. */
    protected static final String WIDGET_DEFAULT_COUNT = "defaultCount";

    /** Widget config name. */
    protected static final String WIDGET_RESULT_LIST = "resultList";

    /** Widget config name. */
    protected static final String WIDGET_RESULT_PAGINATION = "resultPagination";

    /** Widget config name. */
    protected static final String WIDGET_SELECTION = "currentSelection";

    /** Widget config name. */
    protected static final String WIDGET_SORT_BAR = "sortBar";

    /** Widget config name. */
    protected static final String WIDGET_TEXT_FACETS = "textFacets";

    /** The default facet value count to show before showing less/more. */
    private static final int DEFAULT_FACET_VALUE_COUNT = 5;

    /** The delay used for the auto completion. */
    private int m_autoCompleteDelay;

    /** Returns the time in ms for auto completion delay. */
    private List<String> m_autoCompleteFields;

    /** The default query. */
    private String m_defaultQuery;

    /** The facet flag. */
    private boolean m_facet;

    /** The facet limit count. */
    private int m_facetLimit;

    /** The facet min count. */
    private int m_facetMinCount;

    /** The list of field names to use for highlighting. */
    private List<String> m_highlightFields = new ArrayList<String>();

    /** The highlight flag. */
    private boolean m_hl;

    /** Signals whether to use fast vector highlighting or not. */
    private boolean m_hlFastVector;

    /** The fragment size for highlighting. */
    private int m_hlFragsize;

    /** The JSONP flag. */
    private boolean m_jsonp;

    /** The query type. */
    private String m_queryType = "edismax";

    /** The list of field names returned by a Solr query. */
    private List<String> m_returnFields = new ArrayList<String>();

    /** The count of results per page. */
    private int m_rows;

    /** The Solr server URL. */
    private String m_solrUrl;

    /** The Spell server URL. */
    private String m_spellUrl;

    /** The title query. */
    private String m_titleQuery;

    /** The configured widgets. */
    private Map<String, CmsWidgetConfig> m_widgets = new HashMap<String, CmsWidgetConfig>();

    /**
     * Public constructor.<p>
     * 
     * @param jsonConfig the JSON object that holds the configuration values.<p>
     */
    public CmsSolrConfig(JSONObject jsonConfig) {

        JSONObject generalObject = jsonConfig.get(NODE_GENERAL).isObject();
        m_defaultQuery = generalObject.get(NODE_DEFAULT_QUERY).isString().stringValue();
        m_queryType = generalObject.get(NODE_QUERY_TYPE).isString().stringValue();
        m_facet = generalObject.get(NODE_FACET).isBoolean().booleanValue();
        m_facetLimit = new Double(generalObject.get(NODE_FACET_LIMIT).isNumber().doubleValue()).intValue();
        m_facetMinCount = new Double(generalObject.get(NODE_FACET_MIN_COUNT).isNumber().doubleValue()).intValue();
        JSONArray fls = generalObject.get(NODE_FL).isArray();
        for (int k = 0; k < fls.size(); k++) {
            m_returnFields.add(fls.get(k).isString().stringValue());
        }
        m_hl = generalObject.get(NODE_HL).isBoolean().booleanValue();
        m_hlFragsize = new Double(generalObject.get(NODE_HL_FRAGSIZE).isNumber().doubleValue()).intValue();
        m_hlFastVector = generalObject.get(NODE_HL_FAST).isBoolean().booleanValue();
        if (m_hl) {
            JSONArray hlfls = generalObject.get(NODE_HL_FL).isArray();
            for (int k = 0; k < hlfls.size(); k++) {
                m_highlightFields.add(hlfls.get(k).isString().stringValue());
            }
        }
        m_jsonp = generalObject.get(NODE_JSONP).isBoolean().booleanValue();
        m_rows = new Double(generalObject.get(NODE_ROWS).isNumber().doubleValue()).intValue();
        m_solrUrl = generalObject.get(NODE_SOLR_URL).isString().stringValue();
        m_titleQuery = generalObject.get(NODE_TITLE_QUERY).isString().stringValue();
        m_spellUrl = generalObject.get(NODE_SPELL_URL).isString().stringValue();
        for (WIDGET_TYPES type : WIDGET_TYPES.values()) {
            if (type == WIDGET_TYPES.textFacets) {
                addFacetWidget(type, jsonConfig.get(type.toString()));
            } else {
                addWidget(type, jsonConfig.get(type.toString()));
            }
        }
        m_autoCompleteDelay = new Double(generalObject.get(NODE_AUTO_COMPLETE_DELAY).isNumber().doubleValue()).intValue();

    }

    /**
     * Returns the delay in ms for auto completion.<p>
     * 
     * @return the delay in ms for auto completion
     */
    public int getAutocompletedelay() {

        return m_autoCompleteDelay;
    }

    /**
     * Returns the list of field names used for auto-completion.<p>
     * 
     * @return the list of field names used for auto-completion
     */
    public List<String> getAutoCompleteFields() {

        CmsWidgetConfig auto = m_widgets.get(WIDGET_TYPES.autocomplete.toString());
        if ((auto != null) && (auto.getFields() != null) && (m_autoCompleteFields == null)) {
            m_autoCompleteFields = new ArrayList<String>();
            for (String fieldname : auto.getFields().keySet()) {
                m_autoCompleteFields.add(fieldname);
            }
        }
        return m_autoCompleteFields;
    }

    /**
     * Returns the defaultQuery.<p>
     *
     * @return the defaultQuery
     */
    public String getDefaultQuery() {

        return m_defaultQuery;
    }

    /**
     * Returns the facet field names.<p>
     * 
     * @return the facet field names
     */
    public List<String> getFacetFieldNames() {

        CmsWidgetConfig c = m_widgets.get(WIDGET_TYPES.textFacets.toString());
        if (c != null) {
            return c.getFacetFieldNames();
        }
        return Collections.emptyList();
    }

    /**
     * Returns the facetLimit.<p>
     *
     * @return the facetLimit
     */
    public int getFacetLimit() {

        return m_facetLimit;
    }

    /**
     * Returns the facetMinCount.<p>
     *
     * @return the facetMinCount
     */
    public int getFacetMinCount() {

        return m_facetMinCount;
    }

    /**
     * Returns the highlightFields.<p>
     *
     * @return the highlightFields
     */
    public List<String> getHighlightFields() {

        return m_highlightFields;
    }

    /**
     * Returns the hlFragsize.<p>
     *
     * @return the hlFragsize
     */
    public int getHlFragsize() {

        return m_hlFragsize;
    }

    /**
     * Returns the queryType.<p>
     *
     * @return the queryType
     */
    public String getQueryType() {

        return m_queryType;
    }

    /**
     * Returns the returnFields.<p>
     *
     * @return the returnFields
     */
    public List<String> getReturnFields() {

        return m_returnFields;
    }

    /**
     * Returns the rows.<p>
     *
     * @return the rows
     */
    public int getRows() {

        return m_rows;
    }

    /**
     * Returns the solrUrl.<p>
     *
     * @return the solrUrl
     */
    public String getSolrUrl() {

        return m_solrUrl;
    }

    /**
     * Retuens the spellURL.<p>
     * 
     * @return the spellURL
     */
    public String getSpellUrl() {

        return m_spellUrl;
    }

    /**
     * Returns the titleQuery.<p>
     *
     * @return the titleQuery
     */
    public String getTitleQuery() {

        return m_titleQuery;
    }

    /**
     * Returns the widgets.<p>
     *
     * @return the widgets
     */
    public Map<String, CmsWidgetConfig> getWidgets() {

        return m_widgets;
    }

    /**
     * Returns the facet.<p>
     *
     * @return the facet
     */
    public boolean isFacet() {

        return m_facet;
    }

    /**
     * Returns the hl.<p>
     *
     * @return the hl
     */
    public boolean isHl() {

        return m_hl;
    }

    /**
     * Returns the hlFastVector.<p>
     *
     * @return the hlFastVector
     */
    public boolean isHlFastVector() {

        return m_hlFastVector;
    }

    /**
     * Returns the jsonp.<p>
     *
     * @return the jsonp
     */
    public boolean isJsonp() {

        return m_jsonp;
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
     * Adds a facet widget configuration.<p>
     * 
     * @param type the widget type
     * @param jsonValue the configuration as JSON
     */
    private void addFacetWidget(WIDGET_TYPES type, JSONValue jsonValue) {

        if (jsonValue != null) {
            CmsWidgetConfig config = new CmsWidgetConfig();
            config.setType(type);
            JSONObject object = jsonValue.isObject();
            String id = object.get(WIDGET_CONFIG_ID).isString().stringValue();
            config.setId(id);
            JSONArray facets = object.get(WIDGET_CONFIG_FACETS).isArray();
            if (facets != null) {
                List<CmsFacetConfig> facetCs = new ArrayList<CmsFacetConfig>();
                for (int k = 0; k < facets.size(); k++) {
                    JSONObject fConfig = facets.get(k).isObject();
                    if (fConfig != null) {
                        String field = fConfig.get(WIDGET_CONFIG_FIELD).isString().stringValue();
                        String label = fConfig.get(WIDGET_CONFIG_LABEL).isString().stringValue();
                        String cssClass = "";
                        try {
                            if (fConfig.get(WIDGET_CONFIG_CSS_CLASS) != null) {
                                cssClass = fConfig.get(WIDGET_CONFIG_CSS_CLASS).isString().stringValue();
                            }
                        } catch (NullPointerException t) {
                            // noop -> optinal setting
                        }
                        if ((field != null) && field.equals(SPECIAL_SPACER_FIELD)) {
                            facetCs.add(new CmsFacetConfig(
                                field,
                                label,
                                CmsSolrFacet.FACET_SORT.facetCountDESC,
                                false,
                                0,
                                cssClass));
                        } else {
                            CmsSolrFacet.FACET_SORT sort = CmsSolrFacet.FACET_SORT.valueOf(fConfig.get(
                                WIDGET_CONFIG_SORT).isString().stringValue());
                            boolean showAll = fConfig.get(WIDGET_CONFIG_SHOW_ALL).isBoolean().booleanValue();
                            int defaultCount = DEFAULT_FACET_VALUE_COUNT;
                            try {
                                defaultCount = new Double(fConfig.get(WIDGET_DEFAULT_COUNT).isNumber().doubleValue()).intValue();
                            } catch (Throwable t) {
                                // noop -> default already set
                            }
                            facetCs.add(new CmsFacetConfig(field, label, sort, showAll, defaultCount, cssClass));
                        }
                    }
                }
                config.setFacets(facetCs);
            }
            m_widgets.put(type.toString(), config);
        }
    }

    /**
     * Adds a widget configuration.<p>
     * 
     * @param type the type of this widget
     * @param value the JSON value that contains the widget configuration
     */
    private void addWidget(WIDGET_TYPES type, JSONValue value) {

        if (value != null) {
            CmsWidgetConfig config = new CmsWidgetConfig();
            config.setType(type);
            JSONObject object = value.isObject();
            String id = object.get(WIDGET_CONFIG_ID).isString().stringValue();
            config.setId(id);
            List<String> fieldNames = new LinkedList<String>();
            if (object.get(WIDGET_CONFIG_FILEDS) != null) {
                JSONArray fields = object.get(WIDGET_CONFIG_FILEDS).isArray();
                if (fields != null) {
                    for (int k = 0; k < fields.size(); k++) {
                        fieldNames.add(fields.get(k).isString().stringValue());
                    }
                }
            }
            String label = null;
            if (object.get(WIDGET_CONFIG_LABEL) != null) {
                JSONString labelJson = object.get(WIDGET_CONFIG_LABEL).isString();
                if (labelJson != null) {
                    label = labelJson.stringValue();
                    config.setLabel(label);
                }
            }
            List<String> fieldLabels = new LinkedList<String>();
            if (object.get(WIDGET_CONFIG_LABELS) != null) {
                JSONArray labels = object.get(WIDGET_CONFIG_LABELS).isArray();
                if (labels != null) {
                    for (int k = 0; k < labels.size(); k++) {
                        fieldLabels.add(labels.get(k).isString().stringValue());
                    }
                }
            }
            int fieldSize = fieldNames.size();
            int labelSize = fieldLabels.size();
            TreeMap<String, String> fieldConfig = new TreeMap<String, String>();
            if (fieldSize == labelSize) {
                for (int i = 0; i < fieldSize; i++) {
                    String fieldName = fieldNames.get(i);
                    String fieldLabel = fieldLabels.get(i);
                    fieldConfig.put(fieldName, fieldLabel);
                }
            } else if (label != null) {
                for (int i = 0; i < fieldSize; i++) {
                    String fieldName = fieldNames.get(i);
                    fieldConfig.put(fieldName, label);
                }
            }
            config.setFields(fieldConfig);
            m_widgets.put(type.toString(), config);
        }
    }
}
