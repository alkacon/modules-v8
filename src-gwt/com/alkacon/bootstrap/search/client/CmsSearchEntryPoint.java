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

package com.alkacon.bootstrap.search.client;

import com.google.gwt.core.client.EntryPoint;
import com.google.gwt.core.client.JavaScriptObject;
import com.google.gwt.json.client.JSONObject;

/**
 * Dialog entry class.<p>
 * 
 * @since 8.0.0
 */
public class CmsSearchEntryPoint implements EntryPoint {

    /** The Search configuration. */
    private CmsSearchConfig m_config;

    /** The Search context information. */
    private CmsSearchContext m_context;

    /**
     * @see org.opencms.gwt.client.A_CmsEntryPoint#onModuleLoad()
     */
    
    public void onModuleLoad() {

        createSearchConfig();
        createSearchContext();
        new CmsSearchController(m_config, m_context);
    }

    /**
     * Returns the Search configuration.<p>
     */
    private native void createSearchConfig() /*-{

        this.@com.alkacon.bootstrap.search.client.CmsSearchEntryPoint::createSearchConfig(Lcom/google/gwt/core/client/JavaScriptObject;)($wnd.GWTsearchUIConfiguration);
    }-*/;

    /**
     * Creates a Search configuration object.<p>
     * 
     * @param jsObject the JSON that holds the Search configuration
     */
    private void createSearchConfig(JavaScriptObject jsObject) {

        m_config = new CmsSearchConfig(new JSONObject(jsObject));
    }

    /**
     * Returns the Search context.<p>
     */
    private native void createSearchContext() /*-{

        this.@com.alkacon.bootstrap.search.client.CmsSearchEntryPoint::createSearchContext(Lcom/google/gwt/core/client/JavaScriptObject;)($wnd.GWTsearchContextInformation);
    }-*/;

    /**
     * Creates the Search context.<p>
     * 
     * @param jsObject the JSON that holds the Search context 
     */
    private void createSearchContext(JavaScriptObject jsObject) {

        m_context = new CmsSearchContext();
        if (jsObject != null) {
            m_context.init(new JSONObject(jsObject));
        }
    }
}
