<%@page buffer="none" session="false" taglibs="c,cms" import="java.util.*"%><%--
--%><% org.opencms.util.CmsRequestUtil.setNoCacheHeaders(response); %><%--
--%><c:set var="locale"><cms:info property="opencms.request.locale" /></c:set><%--
--%><% ResourceBundle bundle = org.opencms.i18n.CmsResourceBundleLoader.getBundle("com.alkacon.bootstrap.solr.messages", new Locale((String)pageContext.getAttribute("locale"))); %><%--
--%>var GWTsolrUIDictionary = {
<%
        org.opencms.relations.CmsCategoryService srv = org.opencms.relations.CmsCategoryService.getInstance();
        org.opencms.jsp.CmsJspActionElement jae = new org.opencms.jsp.CmsJspActionElement(pageContext, request, response);
        org.opencms.file.CmsObject cmsO = jae.getCmsObject();
        String siteRoot = cmsO.getRequestContext().getSiteRoot() + "/";
        java.util.List<String> reps = srv.getCategoryRepositories(cmsO, siteRoot + "/_categories/");
        java.util.List<org.opencms.relations.CmsCategory> cats = srv.readCategoriesForRepositories(cmsO, "/", true, reps);
        for (org.opencms.relations.CmsCategory cat : cats) {
            String val = "\"" + cat.getPath() + "\":'" + cat.getTitle() + "',";
            out.println(val);
        }
        java.util.List<org.opencms.workplace.explorer.CmsExplorerTypeSettings> settings = org.opencms.main.OpenCms.getWorkplaceManager().getExplorerTypeSettings();
        Locale locale = new Locale((String)pageContext.getAttribute("locale"));
        for (org.opencms.workplace.explorer.CmsExplorerTypeSettings setting : settings) {
            String title = org.opencms.workplace.CmsWorkplaceMessages.getResourceTypeName(locale, setting.getName());
            if (title == null) {
                title = setting.getName();
            }
            String val = "\"" + setting.getName() + "\":'" + title + "',";
            out.println(val);
        }
%>"locale"                            :'${locale}',
"label.email.link"                  :'<%= bundle.getString("label.email.link") %>',
"label.share.box"                   :'<%= bundle.getString("label.share.box") %>',

"showMore"                          :'<%= bundle.getString("label.showMore") %>',
"showLess"                          :'<%= bundle.getString("label.showLess") %>',
"category"                          :'<%= bundle.getString("label.category") %>',
"language"                          :'<%= bundle.getString("label.language") %>',
"languages"                         :'<%= bundle.getString("label.languages") %>',
"currentSelection"                  :'<%= bundle.getString("label.currentSelection") %>',
"lastChanges"                       :'<%= bundle.getString("label.lastChanges") %>',
"format"                            :'<%= bundle.getString("label.format") %>',
"relevance"                         :'<%= bundle.getString("label.relevance") %>',
"aToZ"                              :'<%= bundle.getString("label.aToZ") %>',
"zToA"                              :'<%= bundle.getString("label.zToA") %>',
"sortByDate"                        :'<%= bundle.getString("label.sortByDate") %>',
"undefined"                         :'<%= bundle.getString("label.undefined") %>',
"suffix"                            :'<%= bundle.getString("label.suffix") %>',
"resetSelection"                    :'<%= bundle.getString("label.resetSelection") %>',
"attachments"                       :'<%= bundle.getString("label.attachments") %>',
"from"                              :'<%= bundle.getString("label.from") %>',
"until"                             :'<%= bundle.getString("label.until") %>',
"hits"                              :'<%= bundle.getString("label.hits") %>',
"searchedFor"                       :'<%= bundle.getString("label.searchedFor") %>',
"back"                              :'<%= bundle.getString("label.back") %>',
"next"                              :'<%= bundle.getString("label.next") %>',
"show"                              :'<%= bundle.getString("label.show") %>',
"attachmentOf"                      :'<%= bundle.getString("label.attachmentOf") %>',
"nothingFoundForQuery"              :'<%= bundle.getString("label.nothingFoundForQuery") %>',

"searchedFor"                       :'<%= bundle.getString("label.searchedFor") %>',
"back"                              :'<%= bundle.getString("label.back") %>',
"next"                              :'<%= bundle.getString("label.next") %>',
"show"                              :'<%= bundle.getString("label.show") %>',
"attachmentOf"                      :'<%= bundle.getString("label.attachmentOf") %>',
"nothingFoundForQuery"              :'<%= bundle.getString("label.nothingFoundForQuery") %>',

"listTitle"                         :'<%= bundle.getString("label.list.title") %>',
"listDoctype"                       :'<%= bundle.getString("label.list.doctype") %>',
"listLanguage"                      :'<%= bundle.getString("label.list.language") %>',
"listDate"                          :'<%= bundle.getString("label.list.date") %>',
"listVersion"                       :'<%= bundle.getString("label.list.version") %>',
"listType"                          :'<%= bundle.getString("label.list.type") %>',

"de"                                :'<%= bundle.getString("label.lang.de") %>',
"en"                                :'<%= bundle.getString("label.lang.en") %>'
};