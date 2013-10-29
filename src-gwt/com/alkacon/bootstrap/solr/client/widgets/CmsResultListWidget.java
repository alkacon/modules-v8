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
import com.alkacon.bootstrap.solr.client.CmsSolrDocument;
import com.alkacon.bootstrap.solr.client.CmsSolrDocumentList;
import com.alkacon.bootstrap.solr.client.I_CmsSolrLayoutBundle;
import com.alkacon.bootstrap.solr.client.UserMessages;

import java.util.Map;

import com.google.gwt.event.dom.client.ClickEvent;
import com.google.gwt.event.dom.client.ClickHandler;
import com.google.gwt.event.dom.client.HasClickHandlers;
import com.google.gwt.event.shared.HandlerRegistration;
import com.google.gwt.user.client.Window;
import com.google.gwt.user.client.ui.HTMLPanel;
import com.google.gwt.user.client.ui.Image;
import com.google.gwt.user.client.ui.RootPanel;

/**
 * A widget that displays the returned documents.<p>
 */
public class CmsResultListWidget extends A_CmsSearchWidget {

    /**
     * The raw HTML for an entry.<p>
     */

    /**
     * A page entry.<p>
     */
    private class CmsEntry extends HTMLPanel implements ClickHandler, HasClickHandlers {

        /** The HTML for a single entry. */
        private static final String HTML = ""
            + "                    <a href=\"LINK\">\n"
            + "                        <h4 class=\"media-heading\">TITLE</h4>\n"
            + "                    </a>\n"
            + "                    <dt>\n"
            + "                        <a href=\"LINK\">\n"
            + "                        IMAGE\n"
            + "                    </dt>\n"
            + "                    <dd>\n"
            + "                        <a href=\"LINK\">\n"
            + "                            <p class=\"muted\"><small><i class=\"icon-calendar\"></i> DATE</small></p>\n"
            + "                            EXCERPT\n"
            + "                        </a>\n"
            + "                    </dd>\n";

        /** The page number. */
        protected String m_link;

        /**
         * Constructor, creates a new CmsSearchUiPaginationValue.<p>
         * 
         * @param title the headline/title for the entry 
         * @param link the detail link
         * @param date the to display
         * @param suffix the suffix
         * @param excerpt the excerpt
         */
        public CmsEntry(String title, String link, String date, String suffix, String excerpt) {

            super("div", "");

            m_link = link;

            Image img = new Image();
            img.setResource(I_CmsSolrLayoutBundle.INSTANCE.doc());
            if (suffix.equals("doc") || suffix.equals("docx")) {
                img.setResource(I_CmsSolrLayoutBundle.INSTANCE.doc());
            } else if (suffix.equals("gif")) {
                img.setResource(I_CmsSolrLayoutBundle.INSTANCE.gif());
            } else if (suffix.equals("html") || suffix.equals("htm")) {
                img.setResource(I_CmsSolrLayoutBundle.INSTANCE.html());
            } else if (suffix.equals("jpg") || suffix.equals("jpeg")) {
                img.setResource(I_CmsSolrLayoutBundle.INSTANCE.jpg());
            } else if (suffix.equals("pdf")) {
                img.setResource(I_CmsSolrLayoutBundle.INSTANCE.pdf());
            } else if (suffix.equals("ppt") || suffix.equals("pptx")) {
                img.setResource(I_CmsSolrLayoutBundle.INSTANCE.ppt());
            } else if (suffix.equals("xml") || suffix.equals("xsd")) {
                img.setResource(I_CmsSolrLayoutBundle.INSTANCE.xml());
            }

            String dl = HTML.replaceAll("LINK", link);
            dl = dl.replaceAll("IMAGE", img.toString());
            dl = dl.replaceAll("TITLE", title);
            dl = dl.replaceAll("DATE", date);
            dl = dl.replaceAll("EXCERPT", excerpt);

            HTMLPanel entry = new HTMLPanel("dl", dl);
            entry.addStyleName("entry dl-horizontal");
            this.add(entry);
            this.getElement().setAttribute("style", "cursor:pointer");
            addClickHandler(this);
        }

        /**
         * @see com.google.gwt.event.dom.client.HasClickHandlers#addClickHandler(com.google.gwt.event.dom.client.ClickHandler)
         */
        public HandlerRegistration addClickHandler(ClickHandler handler) {

            return addDomHandler(handler, ClickEvent.getType());
        }

        /**
         * @see com.google.gwt.event.dom.client.ClickHandler#onClick(com.google.gwt.event.dom.client.ClickEvent)
         */
        public void onClick(ClickEvent event) {

            String href = Window.Location.getHref();
            String newURL = href.replace(Window.Location.getPath(), m_link);
            Window.Location.assign(newURL);
        }
    }

    /**
     * Public constructor with parameters.<p>
     * 
     * @param panel the panel for this widget
     * @param controller the search controller
     * @param config the configuration for this width
     */
    public CmsResultListWidget(RootPanel panel, CmsSolrController controller, CmsWidgetConfig config) {

        super(panel, controller, config);
    }

    /**
     * @see com.alkacon.bootstrap.solr.client.widgets.I_CmsSearchWidget#update(com.alkacon.bootstrap.solr.client.CmsSolrDocumentList)
     */
    public void update(CmsSolrDocumentList result) {

        getPanel().clear();
        String q = getController().getSearchData().getSearchQuery();
        if ((q != null) && !q.trim().isEmpty()) {
            getPanel().add(
                new HTMLPanel("h3", "<div class=\"headline headline-md\"><h4>"
                    + UserMessages.searchedFor()
                    + " "
                    + q
                    + "</h4></div>"));
        }
        if (result.hasDocuments()) {
            HTMLPanel resultList = new HTMLPanel("div", "");
            resultList.addStyleName("posts blog-item lists margin-bottom-20");
            //fill the new results;                                      
            for (CmsSolrDocument oneResult : result.getDocuments()) {
                String title = oneResult.getTitle();
                String date = oneResult.getLastModification();
                String link = oneResult.getLink();
                String excerpt = oneResult.getExcerpt();
                String suffix = oneResult.getSuffix();
                if (excerpt == null) {
                    excerpt = "No search term for generating an excerpt.";
                }
                resultList.add(new CmsEntry(title, link, date, suffix, excerpt));
            }
            getPanel().add(resultList);
        } else {
            // only add the not found info, if there is a search query
            if (!getController().getSearchData().getSearchQuery().equals("")) {
                HTMLPanel noHit = new HTMLPanel("p", UserMessages.nothingFoundForQuery()
                    + ": '"
                    + getController().getSearchData().getSearchQuery()
                    + "'");

                if ((getController().getSuggestions() != null) && !getController().getSuggestions().isEmpty()) {
                    noHit.add(new HTMLPanel("h4", "Did you mean?"));
                    HTMLPanel suggs = new HTMLPanel("ul", "");
                    noHit.add(suggs);
                    for (Map.Entry<String, Integer> sugg : getController().getSuggestions().entrySet()) {
                        CmsSuggestEntry ent = new CmsSuggestEntry(sugg.getKey(), sugg.getValue());
                        suggs.add(ent);
                    }
                }
                getPanel().add(noHit);
            }
        }
    }

    /**
     * A page entry.<p>
     */
    private class CmsSuggestEntry extends HTMLPanel implements ClickHandler, HasClickHandlers {

        /** The text. */
        protected String m_text;

        /**
         * Constructor, creates a new CmsSearchUiPaginationValue.<p>
         * 
         * @param text the text value
         * @param count the count
         */
        public CmsSuggestEntry(String text, Integer count) {

            super("li", "<a href=\"javascript:void()\" >" + text + " (" + count + ")" + " </a>");
            m_text = text;
            addClickHandler(this);
        }

        /**
         * @see com.google.gwt.event.dom.client.ClickHandler#onClick(com.google.gwt.event.dom.client.ClickEvent)
         */
        public void onClick(ClickEvent event) {

            getController().doSearch(m_text, 0);
        }

        /**
         * @see com.google.gwt.event.dom.client.HasClickHandlers#addClickHandler(com.google.gwt.event.dom.client.ClickHandler)
         */
        public HandlerRegistration addClickHandler(ClickHandler handler) {

            return addDomHandler(handler, ClickEvent.getType());
        }
    }
}
