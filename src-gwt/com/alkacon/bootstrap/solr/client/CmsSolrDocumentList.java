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

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.google.gwt.user.client.rpc.IsSerializable;

/**
 * Bean to transport search results to the client.<p>
 */
public class CmsSolrDocumentList implements IsSerializable {

    /** Return field name constant. */
    public static final String FL_CON_LOCALES = "con_locales";

    /** Return field name constant. */
    public static final String FL_DEP_ATT = "dep_attachment";

    /** Return field name constant. */
    public static final String FL_DEP_DOC = "dep_document";

    /** Return field name constant. */
    public static final String FL_DEP_VAR = "dep_variant";

    /** Return field name constant. */
    public static final String FL_ID = "id";

    /** Return field name constant. */
    public static final String FL_LANGUGAE = "language";

    /** The link for this doc. */
    public static final String FL_LINK = "link";

    /** Return field name constant. */
    public static final String FL_PATH = "path";

    /** Return field name constant. */
    public static final String FL_SUFFIX = "suffix";

    /** Return field name constant. */
    public static final String FL_TITLE_PROP = "Title_prop";

    /** Return field name constant. */
    public static final String FL_TYPE = "type";

    /** List of auto completion results. */
    private List<String> m_autocompletion;

    /** List of search results. */
    private List<CmsSolrDocument> m_documents;

    /** Map of facet lists. */
    private Map<String, List<CmsSolrFacet>> m_facets;

    /** Number of hits. */
    private int m_hits;

    /**
     * Constructor, creates a new, empty CmsSolrResult.<p>
     */
    public CmsSolrDocumentList() {

        m_documents = new ArrayList<CmsSolrDocument>();
        m_autocompletion = new ArrayList<String>();
        m_facets = new HashMap<String, List<CmsSolrFacet>>();
        m_hits = 0;
    }

    /**
     * Adds a value to the autocompletion list.<p>
     * 
     * @param autocompletion the value to be added to the autocompletion
     */
    public void addAutoCompletion(String autocompletion) {

        m_autocompletion.add(autocompletion);
    }

    /**
     * Adds a new facet to the facet map.<p>
     * 
     * @param name name of the facet
     * @param facet a list of CmsSolrFacetBean objects
     */
    public void addFacet(String name, List<CmsSolrFacet> facet) {

        m_facets.put(name, facet);
    }

    /**
     * Adds a single searchresult to the list of search results.<p>
     * 
     * @param searchResult the search result to add
     */
    public void addDocument(CmsSolrDocument searchResult) {

        m_documents.add(searchResult);

    }

    /**
     * Gets the list of current autocompletions.<p>
     * 
     * @return list of autocompletions, sorted alphabetically
     */
    public List<String> getAutocompletion() {

        Collections.sort(m_autocompletion);
        return m_autocompletion;
    }

    /**
     * Returns the searchResults.<p>
     *
     * @return the searchResults
     */
    public List<CmsSolrDocument> getDocuments() {

        return m_documents;
    }

    /**
     * Gets a list of CmsSolrFacetBean objects.<p>
     * 
     * @param name the name of the facet
     * @return a list of CmsSolrFacetBean objects or null
     */
    public List<CmsSolrFacet> getFacet(String name) {

        List<CmsSolrFacet> facet = m_facets.get(name);
        return facet;
    }

    /**
     * Gets a set of all facet names.<p>
     * 
     * @return set of facet names
     */
    public Set<String> getFacetNames() {

        return m_facets.keySet();
    }

    /**
     * Returns the hits.<p>
     *
     * @return the hits
     */
    public int getHits() {

        return m_hits;
    }

    /**
     * Checks if there are any search results at all.<p>
     * @return true if any results are found, false otherwise
     */
    public boolean hasDocuments() {

        if (m_documents.size() == 0) {
            return false;
        }
        return true;
    }

    /**
     * Sets the searchResults.<p>
     *
     * @param searchResults the searchResults to set
     */
    public void setDocuments(List<CmsSolrDocument> searchResults) {

        m_documents = searchResults;
    }

    /**
     * Sets the hits.<p>
     *
     * @param hits the hits to set
     */
    public void setHits(int hits) {

        m_hits = hits;
    }
}
