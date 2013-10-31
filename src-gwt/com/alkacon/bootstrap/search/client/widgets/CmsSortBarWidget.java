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

package com.alkacon.bootstrap.search.client.widgets;

import com.alkacon.bootstrap.search.client.CmsSearchConfig.CmsWidgetConfig;
import com.alkacon.bootstrap.search.client.CmsSearchController;
import com.alkacon.bootstrap.search.client.CmsSearchDocumentList;

import java.util.Collections;
import java.util.Map;
import java.util.TreeMap;

import com.google.gwt.event.dom.client.ChangeEvent;
import com.google.gwt.event.dom.client.ChangeHandler;
import com.google.gwt.user.client.ui.ListBox;
import com.google.gwt.user.client.ui.RootPanel;

/**
 * Summary widget, to be used to show a summary (number of hits, current page) the search results.<p>
 */
public class CmsSortBarWidget extends A_CmsSearchWidget {

    /** The select box used by this widget. */
    protected ListBox m_order;

    /**
     * Constructor, creates a new CmsSearchUiOutputSummayWidget.<p>
     * 
     * @param panel the panel for this widget
     * @param controller the search controller
     * @param config the widget configuration
     */
    public CmsSortBarWidget(RootPanel panel, final CmsSearchController controller, CmsWidgetConfig config) {

        super(panel, controller, config);

        Map<String, String> reverseOrderedMap = new TreeMap<String, String>(Collections.reverseOrder());
        reverseOrderedMap.putAll(config.getFields());

        m_order = new ListBox();
        m_order.setStyleName("form-control");

        for (Map.Entry<String, String> sortFieldConfig : reverseOrderedMap.entrySet()) {
            String fieldLabel = sortFieldConfig.getValue();
            if (fieldLabel != null) {
                String[] ascDesc = fieldLabel.split(",");
                String fieldName = sortFieldConfig.getKey();
                if ((ascDesc != null) && (ascDesc.length == 2)) {
                    String fieldAsc = fieldName + "+asc";
                    String fieldDesc = fieldName + "+desc";
                    String labelAsc = sortFieldConfig.getValue().split(",")[0];
                    String labelDesc = sortFieldConfig.getValue().split(",")[1];
                    m_order.addItem(config.getLabel() + " " + labelAsc, fieldAsc);
                    m_order.addItem(config.getLabel() + " " + labelDesc, fieldDesc);
                } else {
                    m_order.addItem(config.getLabel() + " " + fieldLabel, fieldName + "+desc");
                }
            }
        }

        select();

        // a on change handler to run a new search after a new sort order is selected
        m_order.addChangeHandler(new ChangeHandler() {

            public void onChange(ChangeEvent event) {

                int selectedIndex = m_order.getSelectedIndex();
                if (selectedIndex > -1) {
                    // set the new sort order
                    String sortOption = m_order.getValue(selectedIndex);
                    controller.getSearchData().setSort(sortOption);

                    // set pagination to first page
                    controller.getSearchData().setPage(0);

                    // do the search
                    controller.doSearch(false);

                }
            }
        });
        panel.add(m_order);
    }

    /**
     * Selects the default value.<p>
     */
    private void select() {

        // find the selected value and mark it
        int defaultIndex = -1;
        boolean found = false;
        for (int i = 0; i < m_order.getItemCount(); i++) {
            String curr = m_order.getValue(i);
            if (getController().getConfig().getDefaultSort().equals(curr)) {
                defaultIndex = i;
            }
            if (m_order.getValue(i).equals(getController().getSearchData().getSort())) {
                m_order.setSelectedIndex(i);
                found = true;
                break;
            }
        }
        if ((defaultIndex != -1) && !found) {
            m_order.setSelectedIndex(defaultIndex);
        }
    }

    /**
     * @see com.alkacon.bootstrap.search.client.widgets.I_CmsSearchWidget#update(com.alkacon.bootstrap.search.client.CmsSearchDocumentList)
     */
    public void update(CmsSearchDocumentList result) {

        select();
    }

}
