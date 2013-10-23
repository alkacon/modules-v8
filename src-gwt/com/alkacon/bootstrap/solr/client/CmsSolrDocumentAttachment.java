/*
 * File   : $Source$
 * Date   : $Date$
 * Version: $Revision$
 *
 * This library is part of OpenCms -
 * the Open Source Content Management System
 *
 * Copyright (C) 2002 - 2009 Alkacon Software (http://www.alkacon.com)
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

import com.google.gwt.user.client.rpc.IsSerializable;

/**
 * Represents an attachment or locale version of a search result document.<p>
 */
public class CmsSolrDocumentAttachment implements IsSerializable, Comparable<Object> {

    /** The locale. */
    private String m_locale;

    /** The path. */
    private String m_path;

    /** The title. */
    private String m_title;

    /**
     * Empty constructor, creates a new, empty CmsSolrResultAttachment.<p>
     */
    public CmsSolrDocumentAttachment() {

        m_path = "";
        m_title = "";
        m_locale = "";
    }

    /**
     * Constructor, creates a CmsSolrResultAttachment.<p>
     * @param path the path to the attachment
     * @param title the title of the attachment
     * @param locale the locale of the attachment
     */
    public CmsSolrDocumentAttachment(String title, String path, String locale) {

        m_path = path;
        m_title = title;
        m_locale = locale;
    }

    /**
     * @see java.lang.Comparable#compareTo(java.lang.Object)
     */
    public int compareTo(Object o) {

        if (o instanceof CmsSolrDocumentAttachment) {
            return getLocale().compareTo(((CmsSolrDocumentAttachment)o).getLocale());
        }
        return 0;
    }

    /**
     * @see java.lang.Object#equals(java.lang.Object)
     */
    @Override
    public boolean equals(Object o) {

        if (o instanceof CmsSolrDocumentAttachment) {
            return getPath().equals(((CmsSolrDocumentAttachment)o).getPath());
        }
        return false;
    }

    /**
     * Returns the locale.<p>
     *
     * @return the locale
     */
    public String getLocale() {

        return m_locale;

    }

    /**
     * Returns the path.<p>
     *
     * @return the path
     */
    public String getPath() {

        return m_path;
    }

    /**
     * Returns the title.<p>
     *
     * @return the title
     */
    public String getTitle() {

        return m_title;
    }

    /**
     * @see java.lang.Object#hashCode()
     */
    @Override
    public int hashCode() {

        return super.hashCode();
    }

    /**
     * Sets the locale.<p>
     *
     * @param locale the locale to set
     */
    public void setLocale(String locale) {

        m_locale = locale;
    }

    /**
     * Sets the path.<p>
     *
     * @param path the path to set
     */
    public void setPath(String path) {

        m_path = path;
    }

    /**
     * Sets the title.<p>
     *
     * @param title the title to set
     */
    public void setTitle(String title) {

        m_title = title;
    }
}
