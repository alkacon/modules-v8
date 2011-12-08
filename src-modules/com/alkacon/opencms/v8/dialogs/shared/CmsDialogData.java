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

package com.alkacon.opencms.v8.dialogs.shared;

import com.google.gwt.user.client.rpc.IsSerializable;

/**
 * Runtime data bean for prefetching.<p>
 * 
 * @since 8.0.0
 */
public class CmsDialogData implements IsSerializable {

    /** Name of the used js variable. */
    public static final String DICT_NAME = "com_alkacon_opencms_v8_dialogs";

    /** The property. */
    private String m_property;

    /**
     * Returns the property.<p>
     *
     * @return the property
     */
    public String getProperty() {

        return m_property;
    }

    /**
     * Default constructor.<p>
     */
    public CmsDialogData() {

        // noop
    }

    /**
     * Constructor.<p>
     * 
     * @param property the property
     */
    public CmsDialogData(String property) {

        m_property = property;
    }

    /**
     * Clone constructor.<p>
     * 
     * @param clone the instance to clone 
     */
    public CmsDialogData(CmsDialogData clone) {

        this(clone.getProperty());
    }

}
