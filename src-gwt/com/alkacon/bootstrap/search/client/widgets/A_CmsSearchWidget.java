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

import com.alkacon.bootstrap.search.client.CmsSearchController;
import com.alkacon.bootstrap.search.client.CmsSearchConfig.CmsWidgetConfig;

import com.google.gwt.user.client.ui.RootPanel;

/**
 * Abstract search widget implementation.<p>
 */
public abstract class A_CmsSearchWidget implements I_CmsSearchWidget {

    /** The configuration for this widget. */
    private CmsWidgetConfig m_config;

    /** The controller that manages all widgets. */
    private CmsSearchController m_controller;

    /** The widget panel. */
    private RootPanel m_panel;

    /**
     * Public constructor.<p>
     * 
     * @param panel the panel used for this widget
     * @param controller the controller
     * @param config the configuration
     */
    public A_CmsSearchWidget(RootPanel panel, final CmsSearchController controller, final CmsWidgetConfig config) {

        this(panel, controller, config, null);
    }

    /**
     * Public constructor.<p>
     * 
     * @param panel the panel used for this widget
     * @param controller the controller
     * @param config the configuration
     * @param id the id used for registration
     */
    public A_CmsSearchWidget(
        RootPanel panel,
        final CmsSearchController controller,
        final CmsWidgetConfig config,
        final String id) {

        m_config = config;
        m_controller = controller;
        m_panel = panel;

        String regId = id;
        if (regId == null) {
            regId = config.getId();
        }
        m_controller.registerSearchWidget(regId, this);
    }

    /**
     * Returns the config.<p>
     *
     * @return the config
     */
    public CmsWidgetConfig getConfig() {

        return m_config;
    }

    /**
     * Returns the controller.<p>
     *
     * @return the controller
     */
    public CmsSearchController getController() {

        return m_controller;
    }

    /**
     * Returns the panel for this widget.<p>
     * 
     * @return the panel for this widget
     */
    public RootPanel getPanel() {

        return m_panel;
    }

    /**
     * @see com.alkacon.bootstrap.search.client.widgets.I_CmsSearchWidget#updateOnSearch()
     */
    public boolean updateOnSearch() {

        return true;
    }
}
