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

package com.alkacon.opencms.v8.dialogs.client.ui;

import com.alkacon.opencms.v8.dialogs.client.Messages;
import com.alkacon.opencms.v8.dialogs.shared.CmsDialogData;
import com.alkacon.opencms.v8.dialogs.shared.rpc.I_CmsDialogService;
import com.alkacon.opencms.v8.dialogs.shared.rpc.I_CmsDialogServiceAsync;

import org.opencms.gwt.client.CmsCoreProvider;
import org.opencms.gwt.client.rpc.CmsRpcPrefetcher;
import org.opencms.gwt.client.ui.CmsErrorDialog;
import org.opencms.gwt.client.ui.CmsPopup;
import org.opencms.gwt.client.ui.CmsPushButton;
import org.opencms.gwt.client.ui.I_CmsButton;

import com.google.gwt.core.client.GWT;
import com.google.gwt.event.dom.client.ClickEvent;
import com.google.gwt.event.dom.client.ClickHandler;
import com.google.gwt.event.logical.shared.CloseEvent;
import com.google.gwt.event.logical.shared.CloseHandler;
import com.google.gwt.event.shared.HandlerRegistration;
import com.google.gwt.user.client.Command;
import com.google.gwt.user.client.rpc.SerializationException;
import com.google.gwt.user.client.rpc.ServiceDefTarget;
import com.google.gwt.user.client.ui.FlowPanel;
import com.google.gwt.user.client.ui.PopupPanel;

/**
 * Provides an upload dialog.<p>
 * 
 * @since 8.0.0
 */
public abstract class A_CmsDialog extends CmsPopup {

    /** Maximum width for the file item widget list. */
    private static final int DIALOG_WIDTH = 600;

    /** The close handler. */
    private CloseHandler<PopupPanel> m_closeHandler;

    /** The dialog data. */
    private CmsDialogData m_data;

    /** The dialog service instance. */
    private I_CmsDialogServiceAsync m_dialogService;

    /** The close handler registration. */
    private HandlerRegistration m_handlerReg;

    /** The main panel. */
    private FlowPanel m_mainPanel;

    /**
     * Default constructor.<p>
     * 
     * @throws SerializationException if deserialization fails 
     */
    public A_CmsDialog()
    throws SerializationException {

        super(Messages.get().key(Messages.GUI_DIALOG_TITLE_0));
        m_data = (CmsDialogData)CmsRpcPrefetcher.getSerializedObjectFromDictionary(
            getDialogService(),
            CmsDialogData.DICT_NAME);
        m_data.getProperty();

        setModal(true);
        setGlassEnabled(true);
        catchNotifications();
        setWidth(DIALOG_WIDTH);

        // create the main panel
        m_mainPanel = new FlowPanel();

        // set the main panel as content of the popup
        setMainContent(m_mainPanel);

        addCloseHandler(new CloseHandler<PopupPanel>() {

            /**
             * @see com.google.gwt.event.logical.shared.CloseHandler#onClose(com.google.gwt.event.logical.shared.CloseEvent)
             */
            public void onClose(CloseEvent<PopupPanel> e) {

                // do something on close aciton
            }
        });

        // create and add the "OK" and "Cancel" buttons
        createButtons();
    }

    /**
     * @see org.opencms.gwt.client.ui.CmsPopup#addCloseHandler(com.google.gwt.event.logical.shared.CloseHandler)
     */
    @Override
    public HandlerRegistration addCloseHandler(CloseHandler<PopupPanel> handler) {

        m_closeHandler = handler;
        m_handlerReg = super.addCloseHandler(handler);
        return m_handlerReg;
    }

    /**
     * Returns the service instance.<p>
     * 
     * @return the service instance
     */
    protected I_CmsDialogServiceAsync getDialogService() {

        if (m_dialogService == null) {
            m_dialogService = GWT.create(I_CmsDialogService.class);
            String serviceUrl = CmsCoreProvider.get().link("com.alkcon.opencms.v8.dialogs.CmsDialogService.gwt");
            ((ServiceDefTarget)m_dialogService).setServiceEntryPoint(serviceUrl);
        }
        return m_dialogService;
    }

    /**
     * The action that is executed if the user clicks on the OK button.<p>
     */
    protected void onOkClick() {

        // perform some action on OK click
    }

    /**
     * Shows the error report.<p>
     * 
     * @param message the message to show
     * @param stacktrace the stacktrace to show
     */
    protected void showErrorReport(final String message, final String stacktrace) {

        CmsErrorDialog errDialog = new CmsErrorDialog(message, stacktrace);
        if (m_handlerReg != null) {
            m_handlerReg.removeHandler();
        }
        if (m_closeHandler != null) {
            errDialog.addCloseHandler(m_closeHandler);
        }
        hide();
        errDialog.center();
    }

    /**
     * Creates the "OK" and the "Cancel" button.<p>
     */
    private void createButtons() {

        addDialogClose(new Command() {

            public void execute() {

                // do something
            }
        });

        CmsPushButton cancelButton = new CmsPushButton();
        cancelButton.setTitle(org.opencms.gwt.client.Messages.get().key(org.opencms.gwt.client.Messages.GUI_CANCEL_0));
        cancelButton.setText(org.opencms.gwt.client.Messages.get().key(org.opencms.gwt.client.Messages.GUI_CANCEL_0));
        cancelButton.setSize(I_CmsButton.Size.medium);
        cancelButton.setUseMinWidth(true);
        cancelButton.addClickHandler(new ClickHandler() {

            /**
             * @see com.google.gwt.event.dom.client.ClickHandler#onClick(com.google.gwt.event.dom.client.ClickEvent)
             */
            public void onClick(ClickEvent event) {

                // do something
            }
        });
        addButton(cancelButton);

        CmsPushButton okButton = new CmsPushButton();
        okButton.setTitle(org.opencms.gwt.client.Messages.get().key(org.opencms.gwt.client.Messages.GUI_OK_0));
        okButton.setText(org.opencms.gwt.client.Messages.get().key(org.opencms.gwt.client.Messages.GUI_OK_0));
        okButton.setSize(I_CmsButton.Size.medium);
        okButton.setUseMinWidth(true);
        okButton.addClickHandler(new ClickHandler() {

            /**
             * @see com.google.gwt.event.dom.client.ClickHandler#onClick(com.google.gwt.event.dom.client.ClickEvent)
             */
            public void onClick(ClickEvent event) {

                onOkClick();
            }
        });
        addButton(okButton);
    }
}
