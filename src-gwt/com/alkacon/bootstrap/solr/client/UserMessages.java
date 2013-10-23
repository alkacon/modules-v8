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

package com.alkacon.bootstrap.solr.client;

import com.google.gwt.i18n.client.Dictionary;

/**
 * GWT dictionary.<p>
 */
public final class UserMessages {

    /** A static reference for message bungle usage. */
    public static final UserMessages MESSAGES = new UserMessages();

    /** The dictionary for this class. */
    private static final Dictionary DICT = Dictionary.getDictionary("GWTsolrUIDictionary");

    /**
     * Empty default constructor.<p>
     */
    private UserMessages() {

        // empty
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String aToZ() {

        return DICT.get("aToZ");
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String attachmentOf() {

        return DICT.get("attachmentOf");
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String attachments() {

        return DICT.get("attachments");
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String back() {

        return DICT.get("back");
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String category() {

        return DICT.get("category");
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String currentSelection() {

        return DICT.get("currentSelection");
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String format() {

        return DICT.get("format");
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String from() {

        return DICT.get("from");
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

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String hits() {

        return DICT.get("hits");
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String language() {

        return DICT.get("language");
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String languages() {

        return DICT.get("languages");
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String lastChanges() {

        return DICT.get("lastChanges");
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String listDate() {

        return DICT.get("listDate");
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String listDoctype() {

        return DICT.get("listDoctype");
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String listLanguage() {

        return DICT.get("listLanguage");
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String listTitle() {

        return DICT.get("listTitle");
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String listType() {

        return DICT.get("listType");
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String listVersion() {

        return DICT.get("listVersion");
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String next() {

        return DICT.get("next");
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String nothingFoundForQuery() {

        return DICT.get("nothingFoundForQuery");
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String relevance() {

        return DICT.get("relevance");
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String resetSelection() {

        return DICT.get("resetSelection");
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String searchedFor() {

        return DICT.get("searchedFor");
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String show() {

        return DICT.get("show");
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String showLess() {

        return DICT.get("showLess");
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String showMore() {

        return DICT.get("showMore");
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String sortByDate() {

        return DICT.get("sortByDate");
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String suffix() {

        return DICT.get("suffix");
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String undefined() {

        return DICT.get("undefined");
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String until() {

        return DICT.get("until");
    }

    /**
     * Constant accessor for localized message.<p>
     * 
     * @return the localized message
     */
    public static String zToA() {

        return DICT.get("zToA");
    }
}
