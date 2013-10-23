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

import com.google.gwt.dom.client.Style.Display;
import com.google.gwt.http.client.URL;
import com.google.gwt.user.client.ui.HTMLPanel;
import com.google.gwt.user.client.ui.Label;
import com.google.gwt.user.client.ui.RootPanel;

/**
 * The share widget.<p>
 */
public class CmsResultShareWidget extends A_CmsSearchWidget {

    /** Placeholder for the Email link. */
    private static final String EMAIL_LINK = "$EMAIL_LINK$";

    /** Placeholder for the href link. */
    private static final String HREF_LINK = "$HREF_LINK";

    /** HTML template for share results. */
    private static final String TEMPLATE = "<div class=\"tag-box tag-box-v2\"><h2>Share result!</h2><p>"
        + UserMessages.getMessage("label.share.box")
        + "</p>"
        + "<p><b>"
        + HREF_LINK
        + "</b></p></div>";

    /** The HTML panel used by this widget. */
    private HTMLPanel m_htmlPanel;

    /** The label used by this widget. */
    private Label m_label = new Label();

    /**
     * The public constructor.<p>
     * 
     * @param panel the panel
     * @param controller the controller
     * @param config the configuration
     */
    public CmsResultShareWidget(RootPanel panel, CmsSolrController controller, CmsWidgetConfig config) {

        super(panel, controller, config);

        if (config.getLabel() != null) {
            m_label.setText(config.getLabel());
            m_label.setStyleName("shareLabel");
        }
    }

    /**
     * Hides this widget.<p>
     */
    public void hide() {

        m_htmlPanel.getElement().getStyle().setDisplay(Display.NONE);
    }

    /**
     * Shows this widget.<p>
     */
    public void show() {

        m_htmlPanel.getElement().getStyle().setDisplay(Display.BLOCK);
    }

    /**
     * @see com.alkacon.bootstrap.solr.client.widgets.I_CmsSearchWidget#update(com.alkacon.bootstrap.solr.client.CmsSolrDocumentList)
     */
    public void update(CmsSolrDocumentList result) {

        getPanel().clear();
        m_htmlPanel = createHtml(getController().getLinkToShare());
        getPanel().add(m_htmlPanel);
        hide();
    }

    /**
     * Creates the HTML.<p>
     * 
     * @param link the link to share
     * 
     * @return the HTML
     */
    private HTMLPanel createHtml(String link) {

        return new HTMLPanel("div", TEMPLATE.replace(EMAIL_LINK, URL.encodeQueryString(link)).replace(HREF_LINK, link));
    }
}
