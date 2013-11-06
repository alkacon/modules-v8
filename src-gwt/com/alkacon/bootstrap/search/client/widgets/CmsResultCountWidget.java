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

import com.alkacon.bootstrap.search.client.CmsSearchConfig.CmsWidgetConfig;
import com.alkacon.bootstrap.search.client.CmsSearchController;
import com.alkacon.bootstrap.search.client.CmsSearchDocumentList;
import com.alkacon.bootstrap.search.client.UserMessages;

import com.google.gwt.user.client.ui.HTMLPanel;
import com.google.gwt.user.client.ui.RootPanel;

/**
 * Shows the result counts.<p>
 */
public class CmsResultCountWidget extends A_CmsSearchWidget {

    /**
     * The public constructor.<p>
     * 
     * @param panel the panel
     * @param controller the controller
     * @param config the configuration
     */
    public CmsResultCountWidget(RootPanel panel, final CmsSearchController controller, CmsWidgetConfig config) {

        super(panel, controller, config);
    }

    /**
     * @see com.alkacon.bootstrap.search.client.widgets.I_CmsSearchWidget#update(com.alkacon.bootstrap.search.client.CmsSearchDocumentList)
     */
    public void update(CmsSearchDocumentList result) {

        getPanel().clear();
        if (result.getHits() > 0) {
            // add the summary
            StringBuffer buf = new StringBuffer();
            int start = (getController().getSearchData().getPage() * getController().getConfig().getRows()) + 1;
            int end = (start + getController().getConfig().getRows()) - 1;
            if (end > result.getHits()) {
                end = result.getHits();
            }
            if (getConfig().getLabel() != null) {
                buf.append(getConfig().getLabel() + " ");
            }
            buf.append(start);
            buf.append("-");
            buf.append(end);
            buf.append(" " + UserMessages.getMessage("label.from") + " ");
            buf.append(result.getHits());
            buf.append(" " + UserMessages.getMessage("label.hits"));
            HTMLPanel count = new HTMLPanel(
                "div",
                "<input class=\"form-control\" id=\"disabledInput\" type=\"text\" placeholder=\" "
                    + buf.toString()
                    + " \" disabled=\"\">");
            getPanel().add(count);
        }
    }
}
