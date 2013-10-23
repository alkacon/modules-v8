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

import com.google.gwt.core.client.EntryPoint;
import com.google.gwt.core.client.JavaScriptObject;
import com.google.gwt.json.client.JSONObject;

/**
 * Dialog entry class.<p>
 * 
 * @since 8.0.0
 */
public class CmsSolrEntryPoint implements EntryPoint {

    /** The Solr configuration. */
    private CmsSolrConfig m_config;

    /** The Solr context information. */
    private CmsSolrContext m_context;

    /**
     * @see org.opencms.gwt.client.A_CmsEntryPoint#onModuleLoad()
     */
    public void onModuleLoad() {

        I_CmsSolrLayoutBundle.INSTANCE.solrCss().ensureInjected();
        createSolrConfig();
        createSolrContext();
        new CmsSolrController(m_config, m_context);
    }

    /**
     * Returns the Solr configuration.<p>
     */
    private native void createSolrConfig() /*-{

        this.@com.alkacon.bootstrap.solr.client.CmsSolrEntryPoint::createSolrConfig(Lcom/google/gwt/core/client/JavaScriptObject;)($wnd.GWTsolrUIConfiguration);
    }-*/;

    /**
     * Creates a Solr configuration object.<p>
     * 
     * @param jsObject the JSON that holds the Solr configuration
     */
    private void createSolrConfig(JavaScriptObject jsObject) {

        m_config = new CmsSolrConfig(new JSONObject(jsObject));
    }

    /**
     * Returns the Solr context.<p>
     */
    private native void createSolrContext() /*-{

        if ($wnd.GWTsolrContextInformation) {
            this.@com.alkacon.bootstrap.solr.client.CmsSolrEntryPoint::createSolrContext(Lcom/google/gwt/core/client/JavaScriptObject;)($wnd.GWTsolrContextInformation);
        }
    }-*/;

    /**
     * Creates the Solr context.<p>
     * 
     * @param jsObject the JSON that holds the Solr context 
     */
    private void createSolrContext(JavaScriptObject jsObject) {

        m_context = new CmsSolrContext();
        if (jsObject != null) {
            m_context.init(new JSONObject(jsObject));
        }
    }
}
