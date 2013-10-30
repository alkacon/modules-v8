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

package com.alkacon.bootstrap.search.client.widgets;

import com.alkacon.bootstrap.search.client.CmsSearchController;
import com.alkacon.bootstrap.search.client.CmsSearchDocumentList;
import com.alkacon.bootstrap.search.client.CmsSearchConfig.CmsWidgetConfig;

import com.google.gwt.event.dom.client.ClickEvent;
import com.google.gwt.event.dom.client.ClickHandler;
import com.google.gwt.user.client.ui.RootPanel;

/**
 * Shares the search result.<p>  
 */
public class CmsResultAdvisorWidget extends A_CmsSearchWidget {

    /** The label used by this widget. */
    private CmsLabelWidget m_advice;

    /**
     * The public constructor.<p>
     * 
     * @param panel the panel
     * @param controller the controller
     * @param config the configuration
     */
    public CmsResultAdvisorWidget(RootPanel panel, CmsSearchController controller, CmsWidgetConfig config) {

        super(panel, controller, config);
        m_advice = new CmsLabelWidget(config.getLabel(), "icon-bullhorn");
        m_advice.addClickHandler(new ClickHandler() {

            /**
             * @see com.google.gwt.event.dom.client.ClickHandler#onClick(com.google.gwt.event.dom.client.ClickEvent)
             */
            public void onClick(ClickEvent event) {

                if (getController().getShareWidget() != null) {
                    getController().getShareWidget().show();
                }
            }
        });
    }

    /**
     * @see com.alkacon.bootstrap.search.client.widgets.I_CmsSearchWidget#update(com.alkacon.bootstrap.search.client.CmsSearchDocumentList)
     */
    public void update(CmsSearchDocumentList result) {

        getPanel().clear();
        if ((getController().getSearchData().hasFacetFilters())
            || ((getController().getSearchData().getSearchQuery() != null) && !(getController().getSearchData().getSearchQuery().trim().equals("")))
            || (getController().getSearchData().getStartDate() != null)
            || (getController().getSearchData().getEndDate() != null)) {
            getPanel().add(m_advice);
        }
    }
}
