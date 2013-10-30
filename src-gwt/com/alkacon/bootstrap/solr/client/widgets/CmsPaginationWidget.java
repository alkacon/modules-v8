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

import com.alkacon.bootstrap.solr.client.CmsSolrConfig.CmsWidgetConfig;
import com.alkacon.bootstrap.solr.client.CmsSolrController;
import com.alkacon.bootstrap.solr.client.CmsSolrDocumentList;
import com.alkacon.bootstrap.solr.client.UserMessages;

import com.google.gwt.event.dom.client.ClickEvent;
import com.google.gwt.event.dom.client.ClickHandler;
import com.google.gwt.event.dom.client.HasClickHandlers;
import com.google.gwt.event.shared.HandlerRegistration;
import com.google.gwt.user.client.ui.HTMLPanel;
import com.google.gwt.user.client.ui.RootPanel;

/**
 * A simple pager, providing previous and next buttons.<p>
 */
public class CmsPaginationWidget extends A_CmsSearchWidget {

    /**
     * A page entry.<p>
     */
    private class CmsPaginationEntry extends HTMLPanel implements ClickHandler, HasClickHandlers {

        /** The page number. */
        protected int m_page;

        /**
         * Constructor, creates a new CmsSearchUiPaginationValue.<p>
         * 
         * @param text the text value for this pagination page
         * @param page the page number 
         */
        public CmsPaginationEntry(String text, int page) {

            super("li", "<a href=\"javascript:void()\" >" + text + " </a>");
            m_page = page;

            if (page >= 0) {
                addClickHandler(this);
            }
        }

        /**
         * @see com.google.gwt.event.dom.client.ClickHandler#onClick(com.google.gwt.event.dom.client.ClickEvent)
         */
        public void onClick(ClickEvent event) {

            getController().getSearchData().setPage(m_page);
            getController().doSearch(false);
        }

        /**
         * @see com.google.gwt.event.dom.client.HasClickHandlers#addClickHandler(com.google.gwt.event.dom.client.ClickHandler)
         */
        public HandlerRegistration addClickHandler(ClickHandler handler) {

            return addDomHandler(handler, ClickEvent.getType());
        }
    }

    /**
     * Public constructor with parameters.<p>
     * 
     * @param panel the panel
     * @param controller the controller
     * @param config the configuration
     */
    public CmsPaginationWidget(RootPanel panel, CmsSolrController controller, CmsWidgetConfig config) {

        super(panel, controller, config);
    }

    /**
     * @see com.alkacon.bootstrap.solr.client.widgets.I_CmsSearchWidget#update(com.alkacon.bootstrap.solr.client.CmsSolrDocumentList)
     */
    public void update(CmsSolrDocumentList result) {

        getPanel().clear();
        HTMLPanel pagination = new HTMLPanel("ul", "");
        pagination.setStyleName("pager");

        // only show pagination if there are more than one page of results
        if ((result.hasDocuments()) && (result.getHits() > getController().getConfig().getRows())) {
            getPanel().setVisible(true);
        } else {
            getPanel().setVisible(false);
        }

        final int previousPage = getController().getSearchData().getPage() - 1;
        CmsPaginationEntry previous = null;
        if (previousPage < 0) {
            // no prev page
            previous = new CmsPaginationEntry("← " + UserMessages.getMessage("label.back"), -1);
            previous.addStyleName("previous disabled");
        } else {
            // prev page
            previous = new CmsPaginationEntry("← " + UserMessages.getMessage("label.back"), previousPage);
            previous.addStyleName("previous");
        }
        pagination.add(previous);

        final int hits = result.getHits();
        int lastPage = hits / getController().getConfig().getRows();
        if (hits > (lastPage * getController().getConfig().getRows())) {
            lastPage++;
        }
        final int nextPage = getController().getSearchData().getPage() + 1;
        CmsPaginationEntry next = null;
        if (nextPage >= lastPage) {
            next = new CmsPaginationEntry(UserMessages.getMessage("label.next") + " →", -1);
            next.addStyleName("next disabled");
        } else {
            next = new CmsPaginationEntry(UserMessages.getMessage("label.next") + " →", nextPage);
            next.addStyleName("next");
        }
        pagination.add(next);

        getPanel().add(pagination);
    }
}
