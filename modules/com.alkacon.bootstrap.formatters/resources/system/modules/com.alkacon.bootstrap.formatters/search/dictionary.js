<%@page buffer="none" session="false" taglibs="c,cms"%><%--
--%><% org.opencms.util.CmsRequestUtil.setNoCacheHeaders(response); %><%--
--%><c:set var="locale"><cms:info property="opencms.request.locale" /></c:set><%--
--%>var GWTsearchUIDictionary = {
<%  java.util.Locale locale = new java.util.Locale((String)pageContext.getAttribute("locale"));

    org.opencms.relations.CmsCategoryService srv = org.opencms.relations.CmsCategoryService.getInstance();
    org.opencms.jsp.CmsJspActionElement jae = new org.opencms.jsp.CmsJspActionElement(pageContext, request, response);
    org.opencms.file.CmsObject cmsO = jae.getCmsObject();
    String siteRoot = cmsO.getRequestContext().getSiteRoot() + "/";
    java.util.List<String> reps = srv.getCategoryRepositories(cmsO, siteRoot + "/_categories/");
    java.util.List<org.opencms.relations.CmsCategory> cats = srv.readCategoriesForRepositories(cmsO, "/", true, reps);
    for (org.opencms.relations.CmsCategory cat : cats) {
        String val = "\"" + cat.getPath() + "\":'" + cat.getTitle() + "',";
        out.println("\t" + val);
    }
    
    java.util.List<org.opencms.workplace.explorer.CmsExplorerTypeSettings> settings = org.opencms.main.OpenCms.getWorkplaceManager().getExplorerTypeSettings();
    for (org.opencms.workplace.explorer.CmsExplorerTypeSettings setting : settings) {
        String title = org.opencms.workplace.CmsWorkplaceMessages.getResourceTypeName(locale, setting.getName());
        if (title == null) {
            title = setting.getName();
        }
        String val = "\"" + setting.getName() + "\":'" + title + "',";
        out.println("\t" + val);
    }
    
    java.util.ResourceBundle bundle = org.opencms.i18n.CmsResourceBundleLoader.getBundle("com.alkacon.bootstrap.formatters.messages", locale);
    for (String key : bundle.keySet()) {
        String value = bundle.getString(key);
        String val = "\"" + key + "\":'" + value + "',";
        out.println("\t" + val);
    }
    out.print("\t\"locale\":'" + locale.toString() + "'"); %> 
};