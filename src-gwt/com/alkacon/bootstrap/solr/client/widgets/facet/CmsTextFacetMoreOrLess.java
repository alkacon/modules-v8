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

package com.alkacon.bootstrap.solr.client.widgets.facet;

import com.google.gwt.event.dom.client.ClickEvent;
import com.google.gwt.event.dom.client.ClickHandler;
import com.google.gwt.user.client.ui.FocusWidget;

/**
 * More-Toggle widget, to be used to toggle the list of facet values.<p>
 */
public class CmsTextFacetMoreOrLess extends FocusWidget {

    /** The facet widget where this more switch is used. */
    private CmsTextFacetWidget m_facetWidget;

    /** The toggle UI. */
    private CmsToggleSpan m_moreToggleUi;

    /**
     * Constructor, creates a new CmsSearchUiCheckboxWidget.<p>
     * 
     * @param facetWidget the facet widget this toggle switch belongs to
     * @param label the label to be shown on the switch
     */
    public CmsTextFacetMoreOrLess(CmsTextFacetWidget facetWidget, String label) {

        this(new CmsToggleSpan());

        m_facetWidget = facetWidget;
        boolean showAll = m_facetWidget.isShowAll();

        // modify the css
        if (!showAll) {
            m_moreToggleUi.setLi("<i class=\"icon-long-arrow-down\"></i> " + label);
        } else {
            m_moreToggleUi.setLi("<i class=\"icon-long-arrow-up\"></i> " + label);
        }

        addClickHandler(new ClickHandler() {

            public void onClick(ClickEvent event) {

                handleClick(event);
            }
        });
    }

    /**
     * Internal constructor to create the widget wrapper.<p>
     * @param moreToggleUi reference to the corresponding UI object
     */
    private CmsTextFacetMoreOrLess(CmsToggleSpan moreToggleUi) {

        super(moreToggleUi.getElement());
        m_moreToggleUi = moreToggleUi;
    }

    /**
     * Click handler, if the checkbox is selected, use its value for a new search.<p>
     * @param e the click event
     */
    void handleClick(ClickEvent e) {

        m_facetWidget.setShowAll(!m_facetWidget.isShowAll());
        m_facetWidget.update(null);
    }
}
