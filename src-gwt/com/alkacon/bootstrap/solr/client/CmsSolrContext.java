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
import java.util.List;

import com.google.gwt.json.client.JSONArray;
import com.google.gwt.json.client.JSONObject;
import com.google.gwt.user.client.Window;

/**
 * The search context.<p>
 */
public class CmsSolrContext {

    /** Node constant. */
    private static final String NODE_ADD_RETURN_FIELD = "addtionalFL";

    /** Node constant. */
    private static final String NODE_GLOBAL_PATH = "globalPath";

    /** Node constant. */
    private static final String NODE_INITIAL_QUERY = "initialQuery";

    /** Node constant. */
    private static final String NODE_ONLINE_URL = "onlineURL";

    /** Node constant. */
    private static final String NODE_ROOT_SITE = "rootSite";

    /** Node constant. */
    private static final String NODE_SEARCH_QUERY = "searchQuery";

    /** Node constant. */
    private static final String NODE_SUB_SITE_PATH = "subSitePath";

    /** Enables/Disables debug mode. */
    private boolean m_debug = true;

    /** The global path to search in. */
    private String m_globalPath;

    /** Signals if the initialization was successful. */
    private boolean m_initialized;

    /** The query to restore. */
    private String m_initialQuery;

    /** The current online URL for sharing results. */
    private String m_onlineUrl;

    /** Additional return fields. */
    private List<String> m_returnFields;

    /** The current site root. */
    private String m_rootSite;

    /** The current text search input. */
    private String m_searchQuery;

    /** The path of the current sub site. */
    private String m_subSitePath;

    /**
     * Default constructor.
     */
    public CmsSolrContext() {

        init(null);
    }

    /**
     * Returns the globalPath.<p>
     *
     * @return the globalPath
     */
    public String getGlobalPath() {

        return m_globalPath;
    }

    /**
     * Returns the initialQuery.<p>
     *
     * @return the initialQuery
     */
    public String getInitialQuery() {

        return m_initialQuery;
    }

    /**
     * Returns the onlineUrl.<p>
     *
     * @return the onlineUrl
     */
    public String getOnlineUrl() {

        return m_onlineUrl;
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
     * Returns the rootSite.<p>
     *
     * @return the rootSite
     */
    public String getRootSite() {

        return m_rootSite;
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
     * Returns the subSitePath.<p>
     *
     * @return the subSitePath
     */
    public String getSubSitePath() {

        return m_subSitePath;
    }

    /**
     * Parses the following JSON.<p>
     * 
     * "onlineURL"    : "<%= onlineLink %>",
     * "rootSite"     : "<%= con.getSiteRoot() %>",
     * "globalPath"   : "<%= glo %>",
     * "subSitePath"  : "<c:out value='${cms.subSitePath}' />",
     * "restoreQuery" : "<c:out value='${cms.element.settings.restoreQuery}' />",
     * "searchQuery"  : "<c:out escapeXml='true' value='${param.solrWidgetAutoCompleteHeader}' />",
     * "addtionalFL"  : ["f1","f2"]
     * 
     * @param jsonObject the JSON to parse
     */
    public void init(JSONObject jsonObject) {

        if (jsonObject != null) {
            String errorNode = null;

            Throwable throwable = null;

            try {
                m_globalPath = jsonObject.get(NODE_GLOBAL_PATH).isString().stringValue();
            } catch (Throwable t) {
                throwable = t;
                errorNode = NODE_GLOBAL_PATH;
            }
            try {
                m_onlineUrl = jsonObject.get(NODE_ONLINE_URL).isString().stringValue();
            } catch (Throwable t) {
                throwable = t;
                errorNode = NODE_ONLINE_URL;
            }
            try {
                m_initialQuery = jsonObject.get(NODE_INITIAL_QUERY).isString().stringValue();
            } catch (Throwable t) {
                throwable = t;
                errorNode = NODE_INITIAL_QUERY;
            }
            try {
                m_rootSite = jsonObject.get(NODE_ROOT_SITE).isString().stringValue();
            } catch (Throwable t) {
                throwable = t;
                errorNode = NODE_ROOT_SITE;
            }
            try {
                m_searchQuery = jsonObject.get(NODE_SEARCH_QUERY).isString().stringValue();
            } catch (Throwable t) {
                throwable = t;
                errorNode = NODE_SEARCH_QUERY;
            }
            try {
                m_subSitePath = jsonObject.get(NODE_SUB_SITE_PATH).isString().stringValue();
            } catch (Throwable t) {
                throwable = t;
                errorNode = NODE_SUB_SITE_PATH;
            }
            try {
                JSONArray jsonArr = jsonObject.get(NODE_ADD_RETURN_FIELD).isArray();
                m_returnFields = new ArrayList<String>();
                for (int i = 0; i < jsonArr.size(); i++) {
                    String fieldname = jsonArr.get(i).isString().stringValue();
                    if (!CmsSolrStringUtil.isEmpty(fieldname)) {
                        m_returnFields.add(fieldname);
                    }
                }
            } catch (Throwable t) {
                throwable = t;
                errorNode = NODE_ADD_RETURN_FIELD;
            }
            if ((errorNode != null) && (throwable != null)) {
                if (m_debug) {
                    Window.alert("The node: "
                        + errorNode
                        + "is not set correctly!"
                        + "\n\n"
                        + "Have a look at:"
                        + CmsSolrContext.class.getName()
                        + "\n\n"
                        + "Error message:\n"
                        + throwable.getLocalizedMessage());
                }
                throwable.printStackTrace();
            } else {
                m_initialized = true;
            }
        }
    }

    /**
     * Returns the initialized.<p>
     *
     * @return the initialized
     */
    public boolean isInitialized() {

        return m_initialized;
    }

    /**
     * Sets the initialized.<p>
     *
     * @param initialized the initialized to set
     */
    public void setInitialized(boolean initialized) {

        m_initialized = initialized;
    }
}
