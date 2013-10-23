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

import java.util.Comparator;

/**
 * Bean to representing a single facet.<p>
 */
public class CmsSolrFacet implements Comparable<Object> {

    /**
     * An enumeration for possible facet sort orders.<p>
     */
    public enum FACET_SORT {

        /** Facet count ascending. */
        facetCountASC,

        /** Facet count descending. */
        facetCountDESC,

        /** Facet label ascending. */
        facetLabelASC,

        /** Facet label descending. */
        facetLabelDESC,

        /** Facet value ascending. */
        facetValueASC,

        /** Facet value descending. */
        facetValueDESC,
    }

    /**
     * A label comparator.<p>
     */
    public static class LabelComparator implements Comparator<CmsSolrFacet> {

        /** Signals if to sort ascending or descending. */
        private boolean m_asc;

        /**
         * Constructor.<p>
         * 
         * @param asc <code>true</code> if to sort ascending
         */
        public LabelComparator(boolean asc) {

            m_asc = asc;
        }

        /**
         * @see java.util.Comparator#compare(java.lang.Object, java.lang.Object)
         */
        public int compare(CmsSolrFacet o1, CmsSolrFacet o2) {

            if (m_asc) {
                return o1.getLabelText().compareTo(o2.getLabelText());
            } else {
                return o2.getLabelText().compareTo(o1.getLabelText());
            }
        }
    }

    /** A comparator for this class that sorts the facets by label ascending. */
    public static final LabelComparator LABEL_ASC_COMP = new LabelComparator(true);

    /** A comparator for this class that sorts the facets by label descending. */
    public static final LabelComparator LABEL_DESC_COMP = new LabelComparator(false);

    /** The facet count. */
    private int m_count;

    /** The label for this facet. */
    private String m_labelText;

    /** The facet field name. */
    private String m_name;

    /**
     * Default constructor.<p>
     */
    public CmsSolrFacet() {

        // noop
    }

    /**
     * Public constructor with all member values as parameters.<p>
     * 
     * @param name the facet name
     * @param count the facet count
     */
    public CmsSolrFacet(String name, int count) {

        m_name = name;

        m_labelText = UserMessages.getMessage(name);
        if (m_labelText == null) {
            m_labelText = name;
        }

        m_count = count;
    }

    /**
     * @see java.lang.Comparable#compareTo(java.lang.Object)
     */
    public int compareTo(Object o) {

        if (o instanceof CmsSolrFacet) {
            return m_name.compareTo(((CmsSolrFacet)o).getName());
        }
        return 0;
    }

    /**
     * Returns the count.<p>
     *
     * @return the count
     */
    public int getCount() {

        return m_count;
    }

    /**
     * Returns the labelText.<p>
     *
     * @return the labelText
     */
    public String getLabelText() {

        return m_labelText;
    }

    /**
     * Returns the name.<p>
     *
     * @return the name
     */
    public String getName() {

        return m_name;
    }

    /**
     * Sets the count.<p>
     *
     * @param count the count to set
     */
    public void setCount(int count) {

        m_count = count;
    }

    /**
     * Sets the labelText.<p>
     *
     * @param labelText the labelText to set
     */
    public void setLabelText(String labelText) {

        m_labelText = labelText;
    }

    /**
     * Sets the name.<p>
     *
     * @param name the name to set
     */
    public void setName(String name) {

        m_name = name;
    }
}
