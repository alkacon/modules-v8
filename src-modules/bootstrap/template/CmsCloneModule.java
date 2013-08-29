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

package bootstrap.template;

import org.opencms.configuration.CmsConfigurationCopyResource;
import org.opencms.configuration.Messages;
import org.opencms.db.CmsExportPoint;
import org.opencms.file.CmsFile;
import org.opencms.file.CmsProperty;
import org.opencms.file.CmsResource;
import org.opencms.file.CmsResourceFilter;
import org.opencms.file.types.A_CmsResourceType;
import org.opencms.file.types.CmsResourceTypeFolder;
import org.opencms.file.types.CmsResourceTypeUnknown;
import org.opencms.file.types.I_CmsResourceType;
import org.opencms.jsp.CmsJspActionElement;
import org.opencms.loader.CmsLoaderException;
import org.opencms.main.CmsException;
import org.opencms.main.CmsIllegalArgumentException;
import org.opencms.main.CmsLog;
import org.opencms.main.OpenCms;
import org.opencms.module.CmsModule;
import org.opencms.util.CmsStringUtil;
import org.opencms.workplace.CmsWorkplace;
import org.opencms.workplace.explorer.CmsExplorerTypeSettings;
import org.opencms.workplace.tools.searchindex.sourcesearch.CmsSourceSearchSettings;
import org.opencms.workplace.tools.searchindex.sourcesearch.CmsSourceSearchThread;

import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;

import org.apache.commons.logging.Log;

/**
 * Clones a module.<p>
 */
public class CmsCloneModule extends CmsJspActionElement {

    /** The icon path. */
    public static final String ICON_PATH = CmsWorkplace.VFS_PATH_RESOURCES + CmsWorkplace.RES_PATH_FILETYPES;

    /** Classes folder within the module. */
    public static final String PATH_CLASSES = "classes/";

    /** The log object for this class. */
    private static final Log LOG = CmsLog.getLog(CmsCloneModule.class);

    private String m_actionClass = "";

    private String m_authorEmail = "r.kurz@alkacon.com";

    private String m_authorName = "Ruediger Kurz";

    private String m_description = "My individual module description ...";

    private String m_group = "newgroup";

    private String m_niceName = "My individual module nice name";

    private String m_packageName = "de.my.company";

    private String m_sourceModuleName = "bootstrap.schemas";

    private String m_sourceNamePrefix = "v9";

    private String m_targetNamePrefix = "my";

    /**
     * Constructor, with parameters.<p>
     * 
     * @param context the JSP page context object
     * @param req the JSP request 
     * @param res the JSP response 
     */
    public CmsCloneModule(PageContext context, HttpServletRequest req, HttpServletResponse res) {

        super(context, req, res);
    }

    /**
     * Executes the module clone and returns the new module.<p>
     * 
     * @return the new module or <code>null</code> in case of any errors
     */
    public CmsModule executeModuleClone() {

        CmsModule sourceModule = OpenCms.getModuleManager().getModule(m_sourceModuleName);
        String errMessage = null;
        if (sourceModule != null) {

            // clone the module object
            CmsModule targetModule = (CmsModule)sourceModule.clone();
            targetModule.setName(m_packageName);
            targetModule.setNiceName(m_niceName);
            targetModule.setDescription(m_description);
            targetModule.setAuthorEmail(m_authorEmail);
            targetModule.setAuthorName(m_authorName);
            targetModule.setGroup(m_group);
            targetModule.setActionClass(m_actionClass);

            try {

                // store the module paths
                String sourceModulePath = CmsWorkplace.VFS_PATH_MODULES + sourceModule.getName() + "/";
                String targetModulePath = CmsWorkplace.VFS_PATH_MODULES + targetModule.getName() + "/";

                // store the package name as path part
                String sourcePathPart = sourceModule.getName().replaceAll("\\.", "/");
                String targetPathPart = targetModule.getName().replaceAll("\\.", "/");

                // store the classes folder paths
                String sourceClassesPath = targetModulePath + PATH_CLASSES + sourcePathPart + "/";
                String targetClassesPath = targetModulePath + PATH_CLASSES + targetPathPart + "/";

                // copy the resources
                getCmsObject().copyResource(sourceModulePath, targetModulePath);

                // check if we have to create the classes folder
                if (getCmsObject().existsResource(sourceClassesPath)) {
                    // in the source module a classes folder was defined,
                    // now create all sub-folders for the package structure in the new module folder
                    createTargetClassesFolder(targetModule, sourceClassesPath, targetModulePath + PATH_CLASSES);
                    // delete the origin classes folder
                    deleteSourceClassesFolder(targetModulePath, sourcePathPart);
                }

                // TODO: clone module dependencies
                cloneDeps();

                // adjust the export points
                cloneExportPoints(sourceModule, targetModule, sourcePathPart, targetPathPart);

                // adjust the resource type names and IDs
                Map<String, String> descKeys = new HashMap<String, String>();
                cloneResourceTypes(sourceModule, targetModule, sourcePathPart, targetPathPart, descKeys);

                // adjust the explorer type names and store referred icons and message keys
                Map<String, String> iconPaths = new HashMap<String, String>();
                cloneExplorerTypes(targetModule, iconPaths, descKeys);

                // rename the icon file names
                cloneExplorerTypeIcons(iconPaths);

                // adjust the module resources
                adjustModuleResources(sourceModule, targetModule, sourcePathPart, targetPathPart, iconPaths);

                // search and replace the localization keys
                replaceMessageKeys(targetClassesPath, descKeys);

                // search and replace paths
                CmsSourceSearchThread t = initializePathThread();
                t.start();
                t.join();

                // search and replace module name
                t = initializeNameThread();
                t.start();
                t.join();

                // TODO: delete the old module ??
                deleteModule();

                // publish the new module
                for (String res : targetModule.getResources()) {
                    OpenCms.getPublishManager().publishResource(getCmsObject(), res);
                    OpenCms.getPublishManager().waitWhileRunning();
                }

                // add the module
                OpenCms.getModuleManager().addModule(getCmsObject(), targetModule);

            } catch (CmsIllegalArgumentException e) {
                LOG.error(e.getMessage(), e);
            } catch (CmsException e) {
                LOG.error(e.getMessage(), e);
            } catch (Exception e) {
                LOG.error(e.getMessage(), e);
            }
        } else {
            errMessage = "Source module does not exist.";
        }
        if (errMessage != null) {
            LOG.error(errMessage);
        }
        return null;
    }

    /**
     * Initializes a thread to find and replace all occurrence of the module's package name.<p>
     * 
     * @return the thread
     */
    private CmsSourceSearchThread initializeNameThread() {

        CmsSourceSearchSettings settings = new CmsSourceSearchSettings();
        settings.setPaths(new ArrayList<String>(Arrays.asList(new String[] {"/system/modules/" + m_packageName + "/"})));
        settings.setProject(getCmsObject().getRequestContext().getCurrentProject().getName());
        settings.setSearchpattern(m_sourceModuleName);
        settings.setReplacepattern(m_packageName);
        settings.setResources("/system/modules/" + m_packageName + "/");
        HttpSession session = getRequest().getSession();
        session.removeAttribute(CmsSourceSearchSettings.ATTRIBUTE_NAME_SOURCESEARCH_RESULT_LIST);
        return new CmsSourceSearchThread(session, getCmsObject(), settings);
    }

    /**
     * Initializes a thread to find and replace all occurrence of the module's path.<p>
     * 
     * @return the thread
     */
    private CmsSourceSearchThread initializePathThread() {

        CmsSourceSearchSettings settings = new CmsSourceSearchSettings();
        settings.setPaths(new ArrayList<String>(Arrays.asList(new String[] {CmsWorkplace.VFS_PATH_MODULES
            + m_packageName
            + "/"})));
        settings.setProject(getCmsObject().getRequestContext().getCurrentProject().getName());
        settings.setSearchpattern(m_sourceModuleName);
        settings.setReplacepattern(m_packageName);
        settings.setResources(CmsWorkplace.VFS_PATH_MODULES + m_packageName + "/");
        HttpSession session = getRequest().getSession();
        session.removeAttribute(CmsSourceSearchSettings.ATTRIBUTE_NAME_SOURCESEARCH_RESULT_LIST);
        return new CmsSourceSearchThread(session, getCmsObject(), settings);
    }

    private void adjustModuleResources(
        CmsModule sourceModule,
        CmsModule targetModule,
        String sourcePathPart,
        String targetPathPart,
        Map<String, String> iconPaths) {

        List<String> newTargetResources = new ArrayList<String>();
        List<String> targetResources = targetModule.getResources();
        for (String modRes : targetResources) {
            String nIcon = iconPaths.get(modRes.substring(modRes.lastIndexOf('/') + 1));
            if (nIcon != null) {
                // the referenced resource is an resource type icon, add the new icon path
                newTargetResources.add(ICON_PATH + nIcon);
            } else if (modRes.contains(sourceModule.getName())) {
                // there is the name in it
                newTargetResources.add(modRes.replaceAll(sourceModule.getName(), targetModule.getName()));
            } else if (modRes.contains(sourcePathPart)) {
                // there is a path in it
                newTargetResources.add(modRes.replaceAll(sourcePathPart, targetPathPart));
            } else {
                // there is whether the path nor the name in it
                newTargetResources.add(modRes);
            }
        }
        targetModule.setResources(newTargetResources);
    }

    private void cloneDeps() {

        // TODO: Auto-generated method stub

    }

    private void cloneExplorerTypeIcons(Map<String, String> iconPaths) throws CmsException {

        for (Map.Entry<String, String> entry : iconPaths.entrySet()) {
            String source = ICON_PATH + entry.getKey();
            String target = ICON_PATH + entry.getValue();
            getCmsObject().copyResource(source, target);
        }
    }

    private void cloneExplorerTypes(CmsModule targetModule, Map<String, String> iconPaths, Map<String, String> descKeys) {

        List<CmsExplorerTypeSettings> targetExplorerTypes = targetModule.getExplorerTypes();
        for (CmsExplorerTypeSettings expSetting : targetExplorerTypes) {
            descKeys.put(expSetting.getKey(), expSetting.getKey().replaceAll(m_sourceNamePrefix, m_targetNamePrefix));
            String newIcon = expSetting.getIcon().replaceAll(m_sourceNamePrefix, m_targetNamePrefix);
            String newBigIcon = expSetting.getBigIconIfAvailable().replaceAll(m_sourceNamePrefix, m_targetNamePrefix);
            iconPaths.put(expSetting.getIcon(), newIcon);
            iconPaths.put(expSetting.getBigIconIfAvailable(), newBigIcon);
            expSetting.setName(expSetting.getName().replaceAll(m_sourceNamePrefix, m_targetNamePrefix));
            expSetting.setKey(expSetting.getKey().replaceAll(m_sourceNamePrefix, m_targetNamePrefix));
            expSetting.setIcon(expSetting.getIcon().replaceAll(m_sourceNamePrefix, m_targetNamePrefix));
            expSetting.setBigIcon(expSetting.getBigIconIfAvailable().replaceAll(m_sourceNamePrefix, m_targetNamePrefix));
            expSetting.setNewResourceUri(expSetting.getNewResourceUri().replaceAll(
                m_sourceNamePrefix,
                m_targetNamePrefix));
            expSetting.setInfo(expSetting.getInfo().replaceAll(m_sourceNamePrefix, m_targetNamePrefix));
        }
    }

    private void cloneExportPoints(
        CmsModule sourceModule,
        CmsModule targetModule,
        String sourcePathPart,
        String targetPathPart) {

        for (CmsExportPoint exp : targetModule.getExportPoints()) {
            if (exp.getUri().contains(sourceModule.getName())) {
                exp.setUri(exp.getUri().replaceAll(sourceModule.getName(), targetModule.getName()));
            }
            if (exp.getUri().contains(sourcePathPart)) {
                exp.setUri(exp.getUri().replaceAll(sourcePathPart, targetPathPart));
            }
        }
    }

    private void cloneResourceTypes(
        CmsModule sourceModule,
        CmsModule targetModule,
        String sourcePathPart,
        String targetPathPart,
        Map<String, String> keys) {

        List<I_CmsResourceType> targetResourceTypes = new ArrayList<I_CmsResourceType>();
        for (I_CmsResourceType sourceResType : targetModule.getResourceTypes()) {

            // get the class name attribute
            String className = sourceResType.getClassName();
            // create the class instance
            I_CmsResourceType targetResType;
            try {
                if (className != null) {
                    className = className.trim();
                }

                int newId = -1;
                boolean exists = true;
                do {
                    newId = new Random().nextInt((99999)) + 10000;
                    try {
                        OpenCms.getResourceManager().getResourceType(newId);
                    } catch (CmsLoaderException e) {
                        exists = false;
                    }
                } while (exists);

                targetResType = (I_CmsResourceType)Class.forName(className).newInstance();

                for (String mapping : sourceResType.getConfiguredMappings()) {
                    targetResType.addMappingType(mapping);
                }

                targetResType.setAdjustLinksFolder(sourceResType.getAdjustLinksFolder());

                if (targetResType instanceof A_CmsResourceType) {
                    A_CmsResourceType concreteTargetResType = (A_CmsResourceType)targetResType;
                    for (CmsProperty prop : sourceResType.getConfiguredDefaultProperties()) {
                        if (CmsStringUtil.isNotEmptyOrWhitespaceOnly(prop.getValue())) {
                            prop.setStructureValue(prop.getStructureValue().replaceAll(
                                sourceModule.getName(),
                                targetModule.getName()).replaceAll(sourcePathPart, targetPathPart));
                            prop.setResourceValue(prop.getResourceValue().replaceAll(
                                sourceModule.getName(),
                                targetModule.getName()).replaceAll(sourcePathPart, targetPathPart));
                        }
                        concreteTargetResType.addDefaultProperty(prop);
                    }
                    for (CmsConfigurationCopyResource conres : sourceResType.getConfiguredCopyResources()) {
                        concreteTargetResType.addCopyResource(
                            conres.getSource(),
                            conres.getTarget(),
                            conres.getTypeString());
                    }
                }

                for (Map.Entry<String, String> entry : sourceResType.getConfiguration().entrySet()) {
                    targetResType.addConfigurationParameter(
                        entry.getKey(),
                        entry.getValue().replaceAll(sourceModule.getName(), targetModule.getName()));
                }

                targetResType.setAdditionalModuleResourceType(true);
                targetResType.initConfiguration(
                    sourceResType.getTypeName().replaceFirst(m_sourceNamePrefix, m_targetNamePrefix),
                    newId + "",
                    sourceResType.getClassName());

                keys.put(sourceResType.getTypeName(), targetResType.getTypeName());
                targetResourceTypes.add(targetResType);

            } catch (Exception e) {
                // resource type is unknown, use dummy class to import the module resources
                targetResType = new CmsResourceTypeUnknown();
                // write an error to the log
                LOG.error(
                    Messages.get().getBundle().key(
                        Messages.ERR_UNKNOWN_RESTYPE_CLASS_2,
                        className,
                        targetResType.getClass().getName()),
                    e);
            }
        }
        targetModule.setResourceTypes(targetResourceTypes);
    }

    private void createTargetClassesFolder(
        CmsModule targetModule,
        String sourceClassesPath,
        String targetBaseClassesPath) throws CmsException {

        StringTokenizer tok = new StringTokenizer(targetModule.getName(), ".");
        int folderId = CmsResourceTypeFolder.getStaticTypeId();
        String targetClassesPath = targetBaseClassesPath;

        while (tok.hasMoreTokens()) {
            String folder = tok.nextToken();
            targetClassesPath += folder + "/";
            getCmsObject().createResource(targetClassesPath, folderId);
        }
        // move exiting content into new classes sub-folder

        List<CmsResource> propertyFiles = getCmsObject().readResources(sourceClassesPath, CmsResourceFilter.ALL);
        for (CmsResource res : propertyFiles) {
            getCmsObject().copyResource(res.getRootPath(), targetClassesPath + res.getName());
        }
    }

    private void deleteModule() {

        // TODO: Auto-generated method stub

    }

    private void deleteSourceClassesFolder(String targetModulePath, String sourcePathPart) throws CmsException {

        String topSourceClassesPath = targetModulePath
            + PATH_CLASSES
            + sourcePathPart.substring(0, sourcePathPart.indexOf('/'))
            + "/";
        getCmsObject().deleteResource(topSourceClassesPath, CmsResource.DELETE_PRESERVE_SIBLINGS);
    }

    private void replaceMessageKeys(String targetClassesPath, Map<String, String> descKeys) throws CmsException {

        List<CmsResource> propFiles = getCmsObject().readResources(targetClassesPath, CmsResourceFilter.DEFAULT_FILES);
        Charset charset = Charset.forName(OpenCms.getSystemInfo().getDefaultEncoding());
        for (CmsResource propFile : propFiles) {
            CmsFile file = getCmsObject().readFile(propFile);
            String content = new String(file.getContents(), charset);
            for (Map.Entry<String, String> entry : descKeys.entrySet()) {
                content = content.replaceAll(entry.getKey(), entry.getValue());
            }
            file.setContents(content.getBytes(charset));
            getCmsObject().writeFile(file);
        }
    }

}
