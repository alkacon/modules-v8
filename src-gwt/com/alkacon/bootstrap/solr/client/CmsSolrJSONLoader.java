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

import com.google.gwt.core.client.JavaScriptObject;
import com.google.gwt.json.client.JSONObject;
import com.google.gwt.user.client.DOM;
import com.google.gwt.user.client.Element;
import com.google.gwt.user.client.ui.RootPanel;

/**
 * CResates a JSONP call to the search engine.<p>
 */
public class CmsSolrJSONLoader {

    /**
     * Callback interface.<p>
     */
    public interface I_CmsSearchCallback {

        @SuppressWarnings("javadoc")
        void onLoad(JSONObject object);
    }

    /** Callback. */
    private I_CmsSearchCallback m_callback;

    /**
     * Loads the json result form the search engine into a <script> node.<p>
     * @param jsonUrl the url to call the search
     * @param callback the callback interface
     */
    public void load(String jsonUrl, I_CmsSearchCallback callback) {

        m_callback = callback;
        // create the callback string
        String callbackString = "jsonLoad_" + DOM.createUniqueId().replace("-", "_") + "_callback";
        String url = jsonUrl + (jsonUrl.contains("?") ? "&" : "?") + "_callback=" + callbackString;

        // important: the json.wrf paremater must be send to solr        
        url += "&json.wrf=" + callbackString;

        // add the <script> node
        publishCallbackMethod(callbackString);
        Element script = DOM.createElement("script");
        script.setAttribute("src", url);
        RootPanel.get().getElement().appendChild(script);

    }

    /**
     * Loads remote data.<p>
     * 
     * @param callback the callback
     * @param javaScribtJSON the resulting JSON object
     */
    private void loadremotedata(String callback, JavaScriptObject javaScribtJSON) {

        m_callback.onLoad(new JSONObject(javaScribtJSON));
    }

    /**
     * Inserts the callback code.<p>
     * 
     * @param callback the callback parameter
     */
    private native void publishCallbackMethod(String callback) /*-{
        var ptr = this;
        $wnd[callback] = function(obj) {
            ptr.@com.alkacon.bootstrap.solr.client.CmsSolrJSONLoader::loadremotedata(Ljava/lang/String;Lcom/google/gwt/core/client/JavaScriptObject;)(callback, obj);
        };
    }-*/;

}
