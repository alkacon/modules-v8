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

package com.alkacon.bootstrap.solr.client.widgets.datepicker;

import com.alkacon.bootstrap.solr.client.CmsSolrController;
import com.alkacon.bootstrap.solr.client.CmsSolrDocumentList;
import com.alkacon.bootstrap.solr.client.UserMessages;
import com.alkacon.bootstrap.solr.client.CmsSolrConfig.CmsWidgetConfig;
import com.alkacon.bootstrap.solr.client.widgets.A_CmsSearchWidget;

import com.google.gwt.user.client.ui.Label;
import com.google.gwt.user.client.ui.RootPanel;

/**
 * Facet widget, to be used to show a list of select-able facet values.<p>
 */
public class CmsDateFacetWidget extends A_CmsSearchWidget {

    /** DatePicker for end date. */
    private CmsDatePicker m_dpEndDate;

    /** DatePicker for start date. */
    private CmsDatePicker m_dpStartDate;

    /** The label for this widget. */
    private Label m_label;

    /**
     * Constructor, creates a new CmsSearchUiFacetDateWidget.<p>
     * 
     * @param panel the panel used for this widget
     * @param controller the search controller
     * @param config the configuration for this widget
       */
    public CmsDateFacetWidget(RootPanel panel, CmsSolrController controller, CmsWidgetConfig config) {

        super(panel, controller, config);

        m_label = new Label(config.getLabel());
        m_label.setVisible(false);
        getPanel().add(m_label);

        m_dpStartDate = new CmsDatePicker(getController(), UserMessages.from(), true);
        m_dpEndDate = new CmsDatePicker(getController(), UserMessages.until(), false);

        getPanel().add(m_dpStartDate);
        getPanel().add(m_dpEndDate);
    }

    /** 
     * Sets the title.<p>
     * 
     * @param titleValue the title;
     */
    public void setText(String titleValue) {

        m_label.setText(titleValue);
    }

    /**
     * @see com.alkacon.bootstrap.solr.client.widgets.I_CmsSearchWidget#update(com.alkacon.bootstrap.solr.client.CmsSolrDocumentList)
     */
    public void update(CmsSolrDocumentList result) {

        // show or hide the panel
        if (getController().getSearchData().hasFacetFilters() || (result.getHits() > 0)) {
            m_label.setVisible(true);
        } else {
            m_label.setVisible(false);
        }
        // clear the values if data was removed
        if (getController().getSearchData().getStartDate() == null) {
            m_dpStartDate.clear();
        }
        if (getController().getSearchData().getEndDate() == null) {
            m_dpEndDate.clear();
        }
    }
}
