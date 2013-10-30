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

import com.google.gwt.core.client.GWT;
import com.google.gwt.resources.client.ClientBundle;
import com.google.gwt.resources.client.CssResource;
import com.google.gwt.resources.client.ImageResource;

/**
 * Resource bundle to access CSS and image resources.
 * 
 * @since 8.0.0
 */
public interface I_CmsSolrLayoutBundle extends ClientBundle {

    /** The dialog CSS classes. */
    public interface I_CmsSolrCss extends CssResource {

        // not yet used
    }

    /** The bundle instance. */
    I_CmsSolrLayoutBundle INSTANCE = GWT.create(I_CmsSolrLayoutBundle.class);

    /**
     * Image resource accessor.<p>
     *
     * @return an image resource
     */
    @Source("images/doc.png")
    ImageResource doc();

    /**
     * Image resource accessor.<p>
     *
     * @return an image resource
     */
    @Source("images/gif.png")
    ImageResource gif();

    /**
     * Image resource accessor.<p>
     *
     * @return an image resource
     */
    @Source("images/html.png")
    ImageResource html();

    /**
     * Image resource accessor.<p>
     *
     * @return an image resource
     */
    @Source("images/jpg.png")
    ImageResource jpg();

    /**
     * Image resource accessor.<p>
     *
     * @return an image resource
     */
    @Source("images/loading.gif")
    ImageResource loading();

    /**
     * Image resource accessor.<p>
     *
     * @return an image resource
     */
    @Source("images/pdf.png")
    ImageResource pdf();

    /**
     * Image resource accessor.<p>
     *
     * @return an image resource
     */
    @Source("images/ppt.png")
    ImageResource ppt();

    /**
     * Access method.<p>
     * 
     * @return the constants CSS
     */
    @Source("solr.css")
    I_CmsSolrCss solrCss();

    /**
     * Image resource accessor.<p>
     *
     * @return an image resource
     */
    @Source("images/xml.png")
    ImageResource xml();

}
