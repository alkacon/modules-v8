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

package com.alkacon.opencms.v8.customwidget;

import org.opencms.file.CmsObject;
import org.opencms.file.CmsResource;
import org.opencms.i18n.CmsMessages;
import org.opencms.main.OpenCms;
import org.opencms.widgets.CmsInputWidget;
import org.opencms.widgets.I_CmsWidget;
import org.opencms.xml.types.A_CmsXmlContentValue;

import java.util.Collections;
import java.util.List;
import java.util.Locale;

/**
 * A custom widget. Extending the core string widget to avoid boilerplate code.<p>
 */
public class CustomWidget extends CmsInputWidget {

    /**
     * @see org.opencms.widgets.CmsInputWidget#getConfiguration(org.opencms.file.CmsObject, org.opencms.xml.types.A_CmsXmlContentValue, org.opencms.i18n.CmsMessages, org.opencms.file.CmsResource, java.util.Locale)
     */
    @Override
    public String getConfiguration(
        CmsObject cms,
        A_CmsXmlContentValue schemaType,
        CmsMessages messages,
        CmsResource resource,
        Locale contentLocale) {

        // the returned string will be passed on to the client side widget
        return "";
    }

    /**
     * @see org.opencms.widgets.CmsInputWidget#getCssResourceLinks(org.opencms.file.CmsObject)
     */
    @Override
    public List<String> getCssResourceLinks(CmsObject cms) {

        // return css resource links if required by the widget
        return null;
    }

    /**
     * @see org.opencms.widgets.CmsInputWidget#getInitCall()
     */
    @Override
    public String getInitCall() {

        // return the javascript function name that initializes the widget
        return "myWidgetInitializationCall";
    }

    /**
     * @see org.opencms.widgets.CmsInputWidget#getJavaScriptResourceLinks(org.opencms.file.CmsObject)
     */
    @Override
    public List<String> getJavaScriptResourceLinks(CmsObject cms) {

        // return the required javascript resource links
        return Collections.singletonList(OpenCms.getLinkManager().substituteLink(
            cms,
            "/system/modules/com.alkacon.customwidget/resources/mywidget.js"));
    }

    /**
     * @see org.opencms.widgets.CmsInputWidget#getWidgetName()
     */
    @Override
    public String getWidgetName() {

        // the widget name and identifier, also used in client side javascript
        return "mywidgetname";
    }

    /**
     * @see org.opencms.widgets.CmsInputWidget#isInternal()
     */
    @Override
    public boolean isInternal() {

        // this is no internal core widget, so return false
        return false;
    }

    /**
     * @see org.opencms.widgets.CmsInputWidget#newInstance()
     */
    @Override
    public I_CmsWidget newInstance() {

        return new CustomWidget();
    }
}
