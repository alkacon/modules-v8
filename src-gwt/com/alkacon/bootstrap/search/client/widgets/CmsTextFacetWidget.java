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
import com.alkacon.bootstrap.search.client.CmsSearchFacet;
import com.alkacon.bootstrap.search.client.CmsSearchStringUtil;
import com.alkacon.bootstrap.search.client.UserMessages;

import java.util.Collections;
import java.util.List;

import com.google.common.collect.Lists;
import com.google.gwt.event.dom.client.ClickEvent;
import com.google.gwt.event.dom.client.ClickHandler;
import com.google.gwt.event.dom.client.HasClickHandlers;
import com.google.gwt.event.shared.HandlerRegistration;
import com.google.gwt.user.client.ui.FlowPanel;
import com.google.gwt.user.client.ui.FocusPanel;
import com.google.gwt.user.client.ui.HTMLPanel;
import com.google.gwt.user.client.ui.RootPanel;

/**
 * Facet widget, to be used to show a list of select-able facet values.<p>
 */
public class CmsTextFacetWidget extends A_CmsSearchWidget {

    /** Mor or less panel. */
    private class MoreOrLess extends HTMLPanel implements HasClickHandlers, ClickHandler {

        /**
         * Public constructor.<p>
         * 
         * @param html the html
         */
        public MoreOrLess(String html) {

            super("ul", html);
            addClickHandler(this);
            setStyleName("list-unstyled");
        }

        /**
         * @see com.google.gwt.event.dom.client.HasClickHandlers#addClickHandler(com.google.gwt.event.dom.client.ClickHandler)
         */
        public HandlerRegistration addClickHandler(ClickHandler handler) {

            return addDomHandler(handler, ClickEvent.getType());
        }

        /**
         * @see com.google.gwt.event.dom.client.ClickHandler#onClick
         */
        @Override
        public void onClick(ClickEvent event) {

            setShowAll(!isShowAll());
            update(null);
        }
    }

    /** The css class. */
    private String m_cssClass;

    /** The default facet value count. */
    private int m_defaultCount;

    /** The label for this facet. */
    private HTMLPanel m_facetLabel;

    /** The facet panel. */
    private FlowPanel m_facetPanel;

    /** The facets to display. */
    private List<CmsSearchFacet> m_facets;

    /** The field name for this facet. */
    private String m_field;

    /** Flag for sorting the facet result by name. */
    private boolean m_showAll;

    /** Sort order. */
    private CmsSearchFacet.FACET_SORT m_sort;

    /**
     * Constructor, creates a new CmsSearchUiCheckboxWidget.<p>
     * 
     * @param panel the panel used for this widget
     * @param controller the search controller
     * @param config the configuration for this widget
     * @param field the name of this facet
     * @param label the title of this facet panel
     * @param sort signals whether the facet should be sorted alphabetically or not
     * @param showAll signals whether to show all facets or not
     * @param defaultCount the default facet value count
     * @param cssClass the css class
     */
    public CmsTextFacetWidget(
        RootPanel panel,
        CmsSearchController controller,
        CmsWidgetConfig config,
        String field,
        String label,
        CmsSearchFacet.FACET_SORT sort,
        boolean showAll,
        int defaultCount,
        String cssClass) {

        super(panel, controller, config, field + "_" + config.getId());

        m_field = field;
        m_sort = sort;
        m_showAll = showAll;
        m_defaultCount = defaultCount;
        m_cssClass = cssClass;

        // create the panel
        m_facetPanel = new FlowPanel();
        m_facetPanel.setStyleName("panel panel-search margin-bottom-20 " + cssClass);

        // add the label
        m_facetLabel = new HTMLPanel("div", "<h3 class=\"panel-title\"><i class=\"icon-tasks\"></i> " + label + "</h3>");
        m_facetLabel.setStyleName("panel-heading " + cssClass);

        // add the panel to the given root panel
        getPanel().add(m_facetPanel);
    }

    /**
     * Returns the show all flag.<p>
     * 
     * @return the show all flag
     */
    public boolean isShowAll() {

        return m_showAll;
    }

    /**
     * Sets the show all flag.<p>
     * 
     * @param showAll the flag to set
     */
    public void setShowAll(boolean showAll) {

        m_showAll = showAll;
    }

    /**
     * Updates the facet widget with new search results.<p>
     * 
     * @param result the current search results
     */
    public void update(CmsSearchDocumentList result) {

        if (((result != null) && (result.getDocuments().size() > 0)) && (m_field != null) && m_field.equals("SPACER")) {
            m_facetPanel.add(m_facetLabel);
        } else {
            m_facetPanel.clear();
            if (result != null) {
                m_facets = result.getFacet(m_field);
            }

            if ((m_facets == null) || m_facets.isEmpty()) {
                // hide the panel if the facets are empty
                m_facetPanel.setVisible(false);
            } else {
                m_facetPanel.add(m_facetLabel);
                // sort the facet values if required

                switch (m_sort) {
                    case facetCountASC:
                        m_facets = Lists.reverse(m_facets);
                        break;
                    case facetCountDESC:
                        break;
                    case facetLabelASC:
                        Collections.sort(m_facets, CmsSearchFacet.LABEL_ASC_COMP);
                        break;
                    case facetLabelDESC:
                        Collections.sort(m_facets, CmsSearchFacet.LABEL_DESC_COMP);
                        break;
                    case facetValueASC:
                        Collections.sort(m_facets);
                        break;
                    case facetValueDESC:
                        Collections.sort(m_facets);
                        m_facets = Lists.reverse(m_facets);
                        break;
                    default:
                        break;
                }

                if (m_facets.size() == 0) {
                    m_facetPanel.setVisible(false);
                } else {
                    m_facetPanel.setVisible(true);
                }

                int count = m_defaultCount + 1;
                // loop over all entries of the facet list and create the check boxes
                FlowPanel body = new FlowPanel();
                body.setStyleName("panel-body");

                for (final CmsSearchFacet facet : m_facets) {
                    if (!m_showAll) {
                        count--;
                    }

                    final boolean isChecked = getController().getSearchData().hasFacetFilter(m_field, facet.getName());

                    if ((count > 0) || isChecked) {

                        String checked = "";
                        if (isChecked) {
                            checked = " checked";
                        }
                        String c = "<input type=\"checkbox\" "
                            + checked
                            + "> "
                            + facet.getLabelText()
                            + " ("
                            + facet.getCount()
                            + ")";
                        final HTMLPanel check = new HTMLPanel("label", c);
                        if (!CmsSearchStringUtil.isEmpty(m_cssClass)) {
                            check.addStyleName(m_cssClass);
                        }

                        FocusPanel p = new FocusPanel();
                        p.setStyleName("checkbox");
                        p.add(check);
                        p.addClickHandler(new ClickHandler() {

                            /**
                             * @see com.google.gwt.event.dom.client.ClickHandler#onClick(com.google.gwt.event.dom.client.ClickEvent)
                             */
                            public void onClick(ClickEvent event) {

                                handleClick(event, isChecked, facet.getName());
                            }
                        });
                        body.add(p);
                    }
                }

                if ((m_facets.size() > m_defaultCount)) {
                    // show the "more" label if required
                    if (!m_showAll) {
                        String html = "<li><i class=\"icon-long-arrow-down\"></i> "
                            + UserMessages.getMessage("label.showMore")
                            + "</li>";
                        body.add(new MoreOrLess(html));
                    }
                    // show the "less" label if required
                    if (m_showAll) {
                        String html = "<li><i class=\"icon-long-arrow-up\"></i> "
                            + UserMessages.getMessage("label.showLess")
                            + "</li>";
                        body.add(new MoreOrLess(html));
                    }
                }
                m_facetPanel.add(body);
            }
        }
    }

    /**
     * Click handler, if the check box is selected, use its value for a new search.<p>
     * 
     * @param e the click event
     * @param isChecked signals whether the check box was checked or unchecked
     * @param facetValue the value of that facet field
     */
    protected void handleClick(ClickEvent e, boolean isChecked, String facetValue) {

        // test if this check box is already set
        if ((isChecked)) {
            getController().getSearchData().removeFacetFilter(m_field, facetValue);
        } else {
            getController().getSearchData().addFacetFilter(m_field, facetValue);
        }
        // set the pagination to firest page
        getController().getSearchData().setPage(0);

        // do the search
        getController().doSearch(false);
    }
}
