<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<cms:include file="%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/search/context.js:be6d941f-46f9-11e3-9436-000c29d28104)"/>
<script type="text/javascript" src="<cms:link>%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/search/dictionary.js:d2f20f93-1370-11e2-b821-2b1b08a6835d)</cms:link>"></script>
<script type="text/javascript" src="<cms:link>%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/search/configuration.js:e3fb6d55-0e64-11e2-8968-2b1b08a6835d)</cms:link>"></script>
<%= org.opencms.gwt.CmsGwtActionElement.createNoCacheScript("search", "9.0.0") %>
