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

package com.alkacon.bootstrap.search.client.widgets.facet;

import com.google.gwt.core.client.GWT;
import com.google.gwt.dom.client.Element;
import com.google.gwt.dom.client.LIElement;
import com.google.gwt.uibinder.client.UiBinder;
import com.google.gwt.uibinder.client.UiField;
import com.google.gwt.user.client.ui.UIObject;

/**
 * UI binder class, representing a more/less facet values switch.<p>
 */
public class CmsToggleSpan extends UIObject {

    /** 
     * The UI binder for this widget.<p>
     */
    interface I_CmsSearchUiMoreToggleUiBinder extends UiBinder<Element, CmsToggleSpan> {
        // nothing to add here
    }

    /** The UI binder. */
    private static I_CmsSearchUiMoreToggleUiBinder uiBinder = GWT.create(I_CmsSearchUiMoreToggleUiBinder.class);

    /**
     * The text.
     */
    @UiField
    protected LIElement m_li;

    /**
     * Constructor, creates new CmsSearchUiMoreToggle.<p>
     */
    public CmsToggleSpan() {

        setElement(uiBinder.createAndBindUi(this));
    }

    /** 
     * Sets the test.<p>
     * 
     * @param html the text;
     */
    public void setLi(String html) {

        m_li.setInnerHTML(html);
    }
}
