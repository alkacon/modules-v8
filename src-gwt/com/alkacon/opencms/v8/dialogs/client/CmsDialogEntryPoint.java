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

package com.alkacon.opencms.v8.dialogs.client;

import com.alkacon.opencms.v8.dialogs.client.ui.A_CmsDialog;
import com.alkacon.opencms.v8.dialogs.client.ui.CmsDialog;

import org.opencms.gwt.client.A_CmsEntryPoint;
import org.opencms.gwt.client.ui.CmsErrorDialog;

import com.google.gwt.core.client.GWT;
import com.google.gwt.event.logical.shared.CloseEvent;
import com.google.gwt.event.logical.shared.CloseHandler;
import com.google.gwt.user.client.Window;
import com.google.gwt.user.client.ui.PopupPanel;

/**
 * Dialog entry class.<p>
 * 
 * @since 8.0.0
 */
public class CmsDialogEntryPoint extends A_CmsEntryPoint {

    /** Name of exported dialog close function. */
    private static final String FUNCTION_OPEN_DIALOG = "cms_ade_openDialog";

    /**
     * Exports the open dialog method.<p>
     */
    public static native void exportOpenDialog() /*-{

		$wnd[@com.alkacon.opencms.v8.dialogs.client.CmsDialogEntryPoint::FUNCTION_OPEN_DIALOG] = function() {
			@com.alkacon.opencms.v8.dialogs.client.CmsDialogEntryPoint::openDialog();
		};

    }-*/;

    /**
     * Opens an empty dialog.<p>
     */
    private static void openDialog() {

        try {
            A_CmsDialog dialog = GWT.create(CmsDialog.class);
            dialog.addCloseHandler(new CloseHandler<PopupPanel>() {

                /**
                 * The on close action.<p>
                 * 
                 * @param event the event
                 */
                public void onClose(CloseEvent<PopupPanel> event) {

                    Window.Location.reload();
                }
            });
        } catch (Exception e) {
            CmsErrorDialog.handleException(new Exception(
                "Deserialization of dialog data failed. This may be caused by expired java-script resources, please clear your browser cache and try again.",
                e));
        }
    }

    /**
     * @see org.opencms.gwt.client.A_CmsEntryPoint#onModuleLoad()
     */
    @Override
    public void onModuleLoad() {

        super.onModuleLoad();
        if ((getDialogMode() != null) && getDialogMode().equals("button")) {
            exportOpenDialog();
        } else {
            try {
                A_CmsDialog dialog = GWT.create(CmsDialog.class);
                dialog.center();
            } catch (Exception e) {
                CmsErrorDialog.handleException(new Exception(
                    "Deserialization of dialog data failed. This may be caused by expired java-script resources, please clear your browser cache and try again.",
                    e));
            }
        }
    }

    /**
     * Retrieves the close link global variable as a string.<p>
     * 
     * @return the close link
     */
    protected native String getCloseLink() /*-{

		return $wnd[@com.alkacon.opencms.v8.dialogs.shared.I_CmsDialogConstants::ATTR_CLOSE_LINK];

    }-*/;

    /**
     * Retrieves the dialog mode global variable as a string.<p>
     * 
     * @return the dialog mode
     */
    protected native String getDialogMode() /*-{

		return $wnd[@com.alkacon.opencms.v8.dialogs.shared.I_CmsDialogConstants::ATTR_DIALOG_MODE];

    }-*/;
}
