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

package com.alkacon.bootstrap.search.client;

import com.google.gwt.i18n.client.Dictionary;

/**
 * GWT dictionary.<p>
 */
public final class UserMessages {

    /** A static reference for message bungle usage. */
    public static final UserMessages MESSAGES = new UserMessages();

    /** The dictionary for this class. */
    private static final Dictionary DICT = Dictionary.getDictionary("GWTsearchUIDictionary");

    /**
     * Empty default constructor.<p>
     */
    private UserMessages() {

        // empty
    }

    /**
     * Returns the message for the given key.<p>
     * 
     * @param key the key to get the message for
     * 
     * @return the message for the given key
     */
    public static String getMessage(String key) {

        try {
            String msg = DICT.get(key);
            if ((msg != null) && msg.startsWith("???") && msg.endsWith("???")) {
                msg = null;
            }
            return msg;
        } catch (Throwable e) {
            // noop
        }
        return null;
    }
}
