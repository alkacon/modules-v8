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

package org.opencms.dev.demo;

import org.opencms.file.CmsDataAccessException;
import org.opencms.file.CmsObject;
import org.opencms.file.CmsResource;
import org.opencms.file.CmsResourceFilter;
import org.opencms.file.I_CmsResource;
import org.opencms.file.collectors.A_CmsResourceCollector;
import org.opencms.file.collectors.CmsCollectorData;
import org.opencms.file.collectors.Messages;
import org.opencms.main.CmsException;
import org.opencms.main.CmsIllegalArgumentException;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/**
 * A simple collector example to collect resources in one folder.<p>
 * 
 * The collector extends the A_CmsResourceCollector. It has to implement following methods:
 * 
 * @see org.opencms.file.collectors.I_CmsResourceCollector#getCollectorNames()
 * @see org.opencms.file.collectors.I_CmsResourceCollector#getCreateLink(org.opencms.file.CmsObject, java.lang.String, java.lang.String)
 * @see org.opencms.file.collectors.I_CmsResourceCollector#getCreateParam(org.opencms.file.CmsObject, java.lang.String, java.lang.String)
 * @see org.opencms.file.collectors.I_CmsResourceCollector#getResults(org.opencms.file.CmsObject, java.lang.String, java.lang.String)
 * 
 */
public class CmsSimpleResourceCollector extends A_CmsResourceCollector {

    /** Static array of the collectors implemented by this class. */
    private static final String[] COLLECTORS = {"myCollector"};

    /** Array list for fast collector name lookup. */
    private static final List<String> COLLECTORS_LIST = Collections.unmodifiableList(Arrays.asList(COLLECTORS));

    /**
     * @see org.opencms.file.collectors.I_CmsResourceCollector#getCollectorNames()
     */
    public List<String> getCollectorNames() {

        return COLLECTORS_LIST;
    }

    /**
     * Returns the link that must be executed when a user clicks on the direct edit
     * "new" button on a list created by the named collector.<p> 
     * 
     * If this method returns <code>null</code>, 
     * it indicated that the selected collector implementation does not support a "create link",
     * and so no "new" button will should shown on lists generated with this collector.<p>
     *  
     * @param cms the current CmsObject 
     * @param collectorName the name of the collector to use
     * @param param an optional collector parameter
     * 
     * @return the link to execute after a "new" button was clicked
     * 
     * @throws CmsException if something goes wrong
     * @throws CmsDataAccessException if the parameter attribute of the corresponding collector tag is invalid
     * @see #getCreateParam(CmsObject, String, String)
     * 
     *
     * @see org.opencms.file.collectors.I_CmsResourceCollector#getCreateLink(org.opencms.file.CmsObject, java.lang.String, java.lang.String)
     */
    public String getCreateLink(CmsObject cms, String collectorName, String param)
    throws CmsException, CmsDataAccessException {

        // if action is not set, use default action
        if (collectorName == null) {
            collectorName = COLLECTORS[0];
        }

        switch (COLLECTORS_LIST.indexOf(collectorName)) {
            case 0:
                // simple
                return getCreateInFolder(cms, param);
            default:
                throw new CmsDataAccessException(Messages.get().container(
                    Messages.ERR_COLLECTOR_NAME_INVALID_1,
                    collectorName));
        }
    }

    /**
     * Returns the parameter that must be passed to the 
     * {@link #getCreateLink(CmsObject, String, String)} method.<p> 
     * 
     * If this method returns <code>null</code>, 
     * it indicates that the selected collector implementation does not support a "create link",
     * and so no "new" button will should shown on lists generated with this collector.<p>
     * 
     * @param cms the current CmsObject 
     * @param collectorName the name of the collector to use
     * @param param an optional collector parameter from the current page context
     * 
     * @return the parameter that will be passed to the {@link #getCreateLink(CmsObject, String, String)} method, or null
     * 
     * @throws CmsDataAccessException if the parameter attribute of the corresponding collector tag is invalid
     * 
     * @see #getCreateLink(CmsObject, String, String)
     *
     * @see org.opencms.file.collectors.I_CmsResourceCollector#getCreateParam(org.opencms.file.CmsObject, java.lang.String, java.lang.String)
     */
    public String getCreateParam(CmsObject cms, String collectorName, String param) throws CmsDataAccessException {

        // if action is not set, use default action
        if (collectorName == null) {
            collectorName = COLLECTORS[0];
        }

        switch (COLLECTORS_LIST.indexOf(collectorName)) {
            case 0:
                // simple
                return param;
            default:
                throw new CmsDataAccessException(Messages.get().container(
                    Messages.ERR_COLLECTOR_NAME_INVALID_1,
                    collectorName));
        }
    }

    /** 
     * Returns a list of {@link org.opencms.file.CmsResource} Objects that are 
     * gathered in the VFS using the named collector.<p>
     * 
     * @param cms the current CmsObject 
     * @param collectorName the name of the collector to use
     * @param param an optional collector parameter
     * 
     * @return a list of CmsXmlContent objects
     * 
     * @throws CmsException if something goes wrong
     * @throws CmsDataAccessException if the parameter attribute of the corresponding collector tag is invalid
     *
     * @see org.opencms.file.collectors.I_CmsResourceCollector#getResults(org.opencms.file.CmsObject, java.lang.String, java.lang.String)
     */
    public List<CmsResource> getResults(CmsObject cms, String collectorName, String param)
    throws CmsDataAccessException, CmsException {

        // if action is not set, use default action
        if (collectorName == null) {
            collectorName = COLLECTORS[0];
        }

        switch (COLLECTORS_LIST.indexOf(collectorName)) {
            case 0:
                // simple
                return getAllInFolder(cms, param);
            default:
                throw new CmsDataAccessException(Messages.get().container(
                    Messages.ERR_COLLECTOR_NAME_INVALID_1,
                    collectorName));
        }
    }

    /**
     * Returns all resources in the folder pointed to by the parameter.<p>
     * 
     * @param cms the current OpenCms user context
     * @param param the folder name to use
     * 
     * @return all resources in the folder matching the given criteria
     * 
     * @throws CmsException if something goes wrong
     * @throws CmsIllegalArgumentException if the given param argument is not a link to a single file
     * 
     */
    protected List<CmsResource> getAllInFolder(CmsObject cms, String param)
    throws CmsException, CmsIllegalArgumentException {

        // use the CmsCollectData to parse the parameter
        // to use other parameters either use @see CmsExtendedCollectorData collector or extend @see A_CmsResourceCollector
        CmsCollectorData data = new CmsCollectorData(param);
        String foldername = CmsResource.getFolderPath(data.getFileName());

        CmsResourceFilter filter = CmsResourceFilter.DEFAULT_FILES.addRequireType(data.getType()).addExcludeFlags(
            CmsResource.FLAG_TEMPFILE);
        List<CmsResource> result = cms.readResources(foldername, filter, false);

        Collections.sort(result, I_CmsResource.COMPARE_ROOT_PATH);
        //Collections.reverse(result);

        return shrinkToFit(result, data.getCount());
    }

}
