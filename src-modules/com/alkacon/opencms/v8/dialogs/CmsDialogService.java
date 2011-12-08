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

package com.alkacon.opencms.v8.dialogs;

import com.alkacon.opencms.v8.dialogs.shared.CmsDialogData;
import com.alkacon.opencms.v8.dialogs.shared.rpc.I_CmsDialogService;

import org.opencms.flex.CmsFlexController;
import org.opencms.gwt.CmsGwtService;

import javax.servlet.http.HttpServletRequest;


/**
 * Handles all RPC services related to the dialog.<p>
 * 
 * @see com.alkacon.opencms.v8.dialogs.CmsDialogService
 * @see com.alkacon.opencms.v8.dialogs.shared.rpc.I_CmsDialogService
 * @see com.alkacon.opencms.v8.dialogs.shared.rpc.I_CmsDialogServiceAsync
 */
public class CmsDialogService extends CmsGwtService implements I_CmsDialogService {

    /** The serial version UID. */
    private static final long serialVersionUID = -2235662141861687012L;

    /**
     * Returns a new configured service instance.<p>
     * 
     * @param request the current request
     * 
     * @return a new service instance
     */
    public static CmsDialogService newInstance(HttpServletRequest request) {

        CmsDialogService srv = new CmsDialogService();
        srv.setCms(CmsFlexController.getCmsObject(request));
        srv.setRequest(request);
        return srv;
    }

    /**
     * @see com.alkacon.opencms.v8.dialogs.shared.rpc.I_CmsDialogService#prefetch()
     */
    public CmsDialogData prefetch() {

        String property = "property";
        CmsDialogData data = new CmsDialogData(property);
        return data;
    }
}
