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

package com.alkacon.bootstrap.solr.client.widgets;

import com.alkacon.bootstrap.solr.client.CmsSolrController;
import com.alkacon.bootstrap.solr.client.CmsSolrDocumentList;
import com.alkacon.bootstrap.solr.client.CmsSolrConfig.CmsWidgetConfig;
import com.alkacon.bootstrap.solr.client.CmsSolrConfig.WIDGET_TYPES;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import com.google.gwt.event.dom.client.ClickEvent;
import com.google.gwt.event.dom.client.ClickHandler;
import com.google.gwt.event.dom.client.HasClickHandlers;
import com.google.gwt.event.shared.HandlerRegistration;
import com.google.gwt.i18n.client.DateTimeFormat;
import com.google.gwt.i18n.client.DateTimeFormat.PredefinedFormat;
import com.google.gwt.user.client.ui.HTMLPanel;
import com.google.gwt.user.client.ui.Label;
import com.google.gwt.user.client.ui.RootPanel;

/**
 * Selection widget, to be used to display the selected facets and their values.<p>
 */
public class CmsSelectionWidget extends A_CmsSearchWidget {

    /**
     * Selection value widget, to be used to display a selected facet value.<p>
     */
    private class CmsFacetValue extends HTMLPanel implements HasClickHandlers {

        /** Flag if this facet values shows a date. */
        boolean m_isDate;

        /** The name of the facet value belongs to. */
        private String m_facetName;

        /** The facet value. */
        private String m_facetValue;

        /**
         * Constructor, creates a new CmsSearchUiSelectionWidget.<p>
         * 
         * @param label the text for this facet Value
         * @param facetName the name of the facet
         * @param facetValue  the facet value
         * @param isDate flag to indicate that this widget represents a data selection
         */
        public CmsFacetValue(String label, String facetName, String facetValue, boolean isDate) {

            super("li", "");

            m_facetName = facetName;
            m_facetValue = facetValue;
            m_isDate = isDate;

            add(new HTMLPanel("strong", "(x) "));
            add(new Label(label));

            addClickHandler(new ClickHandler() {

                /**
                 * @see com.google.gwt.event.dom.client.ClickHandler#onClick(com.google.gwt.event.dom.client.ClickEvent)
                 */
                public void onClick(ClickEvent event) {

                    handleClick(event);
                }
            });
        }

        /**
         * @see com.google.gwt.event.dom.client.HasClickHandlers#addClickHandler(com.google.gwt.event.dom.client.ClickHandler)
         */
        public HandlerRegistration addClickHandler(ClickHandler handler) {

            return addDomHandler(handler, ClickEvent.getType());
        }

        /**
         * Click handler, if the facet selection, this selection will be removed.<p>
         * @param e the click event
         */
        void handleClick(ClickEvent e) {

            // if this facet value selection displays a date, clear it
            if (m_isDate) {
                getController().getSearchData().setStartDate(null);
                getController().getSearchData().setEndDate(null);
            } else {
                // otherwise clear the facet value
                // test if this facet value exits
                boolean isSelected = getController().getSearchData().hasFacetFilter(m_facetName, m_facetValue);
                if ((isSelected)) {
                    getController().getSearchData().removeFacetFilter(m_facetName, m_facetValue);
                }
            }
            getController().doSearch(false);
        }
    }

    /**
     * Constructor, creates a new CmsSearchUiSelectionWidget.<p>
     * 
     * @param panel the panel used for this widget
     * @param controller the search controller
     * @param config the configuration for this widget
     */
    public CmsSelectionWidget(RootPanel panel, CmsSolrController controller, final CmsWidgetConfig config) {

        super(panel, controller, config);
    }

    /**
     * @see com.alkacon.bootstrap.solr.client.widgets.I_CmsSearchWidget#update(com.alkacon.bootstrap.solr.client.CmsSolrDocumentList)
     */
    public void update(CmsSolrDocumentList result) {

        getPanel().clear();

        // check if some facets are selected
        if ((getController().getSearchData().hasFacetFilters())
            || (getController().getSearchData().getStartDate() != null)
            || (getController().getSearchData().getEndDate() != null)) {

            // add the label for this widget
            getPanel().add(new HTMLPanel("h4", getConfig().getLabel()));

            // create the facet selection
            Map<String, List<String>> facetSelections = getController().getSearchData().getFacetFilters();
            ArrayList<String> facetSelectionKeys = new ArrayList<String>();
            facetSelectionKeys.addAll(facetSelections.keySet());
            Collections.sort(facetSelectionKeys);
            for (String facetField : facetSelectionKeys) {
                // iterate over the selected facets
                CmsWidgetConfig config = getController().getWidgetConfig(WIDGET_TYPES.textFacets);
                String facetLabel = config.getFacets().get(facetField).getLabel();
                getPanel().add(new HTMLPanel("h5", facetLabel + ": "));
                //now iterate over the values for this facet
                List<String> facetValues = facetSelections.get(facetField);
                Collections.sort(facetValues);
                HTMLPanel ul = new HTMLPanel("ul", "");
                boolean one = false;
                for (String facetValue : facetValues) {
                    one = true;
                    ul.add(new CmsFacetValue(facetValue, facetField, facetValue, false));
                }
                if (one) {
                    getPanel().add(ul);
                }
            }

            //show the date selection if set
            if ((getController().getSearchData().getStartDate() != null)
                || (getController().getSearchData().getEndDate() != null)) {

                CmsWidgetConfig config = getController().getWidgetConfig(WIDGET_TYPES.dateRanges);
                getPanel().add(new HTMLPanel("h5", config.getLabel() + ": "));
                StringBuffer buf = new StringBuffer();
                if (getController().getSearchData().getStartDate() != null) {
                    buf.append(DateTimeFormat.getFormat(PredefinedFormat.DATE_MEDIUM).format(
                        getController().getSearchData().getStartDate()));
                }
                buf.append(" - ");
                if (getController().getSearchData().getEndDate() != null) {
                    buf.append(DateTimeFormat.getFormat(PredefinedFormat.DATE_MEDIUM).format(
                        getController().getSearchData().getEndDate()));
                }
                getPanel().add(new CmsFacetValue(buf.toString(), null, null, true));
            }
        }
    }
}
