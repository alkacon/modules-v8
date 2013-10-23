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
import com.alkacon.bootstrap.solr.client.UserMessages;

import com.google.gwt.user.client.ui.HTMLPanel;
import com.google.gwt.user.client.ui.RootPanel;

/**
 * A widget that displays the returned documents.<p>
 */
public class CmsResultListWidget extends A_CmsSearchWidget {

    /**
     * The raw HTML for an entry.<p>
     */
    private static final String HTML = "<dl class=\"dl-horizontal\">\n"
        + "                    <a href=\"LINK\">\n"
        + "                        <h4 class=\"media-heading\">TITLE</h4>\n"
        + "                    </a>\n"
        + "                    <dt>\n"
        + "                        <a href=\"$LINK\">\n"
        + "                        <img src=\"/opencms9/export/sites/default/.content/images/flowers/strawberries.jpg_1669202146.jpg\" width=\"50\" height=\"38\" alt=\"/.content/images/news/strawberries.jpg\"></a>\n"
        + "                    </dt><dd>\n"
        + "                        <a href=\"LINK\">\n"
        + "                            <p class=\"muted\"><small><i class=\"icon-calendar\"></i> DATE</small></p>\n"
        + "                            <p>EXCERPT</p>\n"
        + "                        </a>\n"
        + "                    </dd>\n"
        + "                </dl>\n";

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

        // add the headline
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
            resultList.addStyleName("posts blog-item margin-bottom-20");

            //fill the new results;                                      
            for (CmsSolrDocument oneResult : result.getDocuments()) {
                String title = oneResult.getTitle();
                String date = oneResult.getLastModification();
                String link = oneResult.getLink();
                String excerpt = oneResult.getExcerpt();
                if (excerpt == null) {
                    excerpt = "No search term for generating an excerpt.";
                }

                String dl = HTML.replaceAll("LINK", link);
                dl = dl.replaceAll("TITLE", title);
                dl = dl.replaceAll("DATE", date);
                dl = dl.replaceAll("EXCERPT", excerpt);

                HTMLPanel entry = new HTMLPanel("dl", dl);
                entry.addStyleName("dl-horizontal");

                resultList.add(entry);
            }
            getPanel().add(resultList);

        } else {
            // only add the not found info, if there is a search query
            if (!getController().getSearchData().getSearchQuery().equals("")) {
                HTMLPanel noHit = new HTMLPanel("p", UserMessages.nothingFoundForQuery()
                    + ": '"
                    + getController().getSearchData().getSearchQuery()
                    + "'");
                getPanel().add(noHit);
            }
        }
    }
}
