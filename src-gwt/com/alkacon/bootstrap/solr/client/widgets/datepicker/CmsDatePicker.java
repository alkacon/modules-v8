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

import java.util.Date;

import com.google.gwt.core.client.GWT;
import com.google.gwt.event.logical.shared.ValueChangeEvent;
import com.google.gwt.i18n.client.DateTimeFormat;
import com.google.gwt.i18n.client.DateTimeFormat.PredefinedFormat;
import com.google.gwt.uibinder.client.UiBinder;
import com.google.gwt.uibinder.client.UiField;
import com.google.gwt.uibinder.client.UiHandler;
import com.google.gwt.user.client.ui.Composite;
import com.google.gwt.user.client.ui.Widget;
import com.google.gwt.user.datepicker.client.DateBox;

/**
 * Custom datebox widget based on ui binder.<p>
 */
public class CmsDatePicker extends Composite {

    /** The UI Binder interface for this class. */
    interface I_CmsSearchUiDatePickerWidgetUiBinder extends UiBinder<Widget, CmsDatePicker> {
        // noop
    }

    /** The UI binder. */
    private static I_CmsSearchUiDatePickerWidgetUiBinder uiBinder = GWT.create(I_CmsSearchUiDatePickerWidgetUiBinder.class);

    /** The search controller. */
    protected CmsSolrController m_controller;

    /**
     * The date box with date picker.<p>
     */
    @UiField
    protected DateBox m_datePicker;

    /**
     * Text behind the checkbox.
     */
    @UiField(provided = true)
    protected String m_text;

    /** Flag for start date. */
    boolean m_startdate;

    /**
     * Constructor, creates a new CmsSearchUIInputDatePicker.<p>
     * @param controller the search controller
     * @param label the label of the datepicker
     * @param startdate flag to indicate if the datepicker is corresponding to the startdate (true) or enddate(false)
     */
    public CmsDatePicker(CmsSolrController controller, String label, boolean startdate) {

        m_text = label;
        m_controller = controller;
        m_startdate = startdate;

        initWidget(uiBinder.createAndBindUi(this));

        DateTimeFormat dateFormat = DateTimeFormat.getFormat(PredefinedFormat.DATE_MEDIUM);
        m_datePicker.setFormat(new DateBox.DefaultFormat(dateFormat));
    }

    /**
     * Clears the selected date.<p>
     */
    public void clear() {

        m_datePicker.setValue(null);
    }

    /**
     * Click handler, stores selected date.<p>
     * 
     * @param e the click event
     */
    @UiHandler("m_datePicker")
    protected void onValueChange(ValueChangeEvent<Date> e) {

        Date date = e.getValue();

        if (m_startdate) {
            m_controller.getSearchData().setStartDate(date);
        } else {
            m_controller.getSearchData().setEndDate(date);
        }

        // set the pagination to first page
        m_controller.getSearchData().setPage(0);

        // do the search
        m_controller.doSearch(false);
    }
}
