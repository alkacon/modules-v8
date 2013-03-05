/*
 * This library is part of OpenCms -
 * the Open Source Content Management System
 *
 * Copyright (C) Alkacon Software (http://www.alkacon.com)
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

package org.opencms.dev.demo.customwidget;

import org.opencms.file.CmsObject;
import org.opencms.main.OpenCms;
import org.opencms.widgets.A_CmsNativeComplexWidget;

import java.util.ArrayList;
import java.util.List;

/**
 * Example for a widget to edit a complete nested content.<p>
 */
public class CmsExampleComplexWidget extends A_CmsNativeComplexWidget {

    /** 
     * Default constructor.<p>
     * 
     */
    public CmsExampleComplexWidget() {

        // do nothing 
    }

    /**
     * Creates a new configured widget instance.<p>
     *  
     * @param config the configuration string 
     */
    public CmsExampleComplexWidget(String config) {

        initConfiguration(config);
    }

    /**
     * @see org.opencms.widgets.I_CmsComplexWidget#configure(java.lang.String)
     */
    @Override
    public CmsExampleComplexWidget configure(String configuration) {

        return new CmsExampleComplexWidget(configuration);
    }

    /**
     * @see org.opencms.widgets.A_CmsNativeComplexWidget#getName()
     */
    @Override
    public String getName() {

        return "examplewidget";
    }

    /**
     * @see org.opencms.widgets.A_CmsNativeComplexWidget#getScripts(org.opencms.file.CmsObject)
     */
    @Override
    public List<String> getScripts(CmsObject cms) {

        String jquery = link(cms, "/system/modules/org.opencms.jquery/packed/jquery.js");
        String js = link(cms, "/system/modules/org.opencms.dev.demo.customwidget/resources/examplewidget.js");
        List<String> scripts = new ArrayList<String>();
        scripts.add(jquery);
        scripts.add(js);
        return scripts;
    }

    /**
     * @see org.opencms.widgets.A_CmsNativeComplexWidget#getStyleSheets(org.opencms.file.CmsObject)
     */
    @Override
    public List<String> getStyleSheets(CmsObject cms) {

        List<String> styles = new ArrayList<String>();
        styles.add(link(cms, "/system/modules/org.opencms.dev.demo.customwidget/resources/examplewidget.css"));
        return styles;
    }

    /** 
     * Creates a link for a given resource path.<p>
     * 
     * @param cms the current CMS context 
     * @param path the resource path 
     * 
     * @return a link to the resource 
     */
    private String link(CmsObject cms, String path) {

        return OpenCms.getLinkManager().substituteLink(cms, path);
    }

}
