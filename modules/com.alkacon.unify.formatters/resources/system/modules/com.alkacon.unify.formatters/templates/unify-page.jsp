<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %><%--
--%><%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %><%--
--%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%--
--%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%--
--%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%--
--%><fmt:setLocale value="${cms.locale}" /><!DOCTYPE html>
<html lang="en">
<head>
	<title>OpenCms | ${cms.title}</title>
	
	<meta charset="${cms.requestContext.encoding}">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<meta name="description" content="<cms:property name="Description" file="search" default="" />">
	<meta name="keywords" content="<cms:property name="Keywords" file="search" default="" />">
	<meta name="robots" content="index, follow">
	<meta name="revisit-after" content="7 days">

	<link rel="apple-touch-icon" sizes="120x120" href="<cms:link>%(link.weak:/system/modules/com.alkacon.unify.basics/resources/img/favicon_120.png:0c514573-5159-11e5-abeb-0242ac11002b)</cms:link>"/>
	<link rel="shortcut icon" href="<cms:link>%(link.weak:/system/modules/com.alkacon.unify.basics/resources/img/favicon_16.png:0c536856-5159-11e5-abeb-0242ac11002b)</cms:link>" type="image/png"/>

	<cms:enable-ade/>
	
	<cms:headincludes type="css" closetags="false" defaults="%(link.weak:/system/modules/com.alkacon.unify.basics/resources/css/styles-main.min.css:0fa43d45-5155-11e5-abeb-0242ac11002b)" />

	<c:set var="colortheme"><cms:property name="unify.theme" file="search" default="red" /></c:set>
	<link rel="stylesheet" href="<cms:link>/system/modules/com.alkacon.unify.basics/resources/css/style-${colortheme}.min.css</cms:link>">

	
</head><body>
<div class="wrapper">
<c:if test="${cms.isEditMode}">
	<!--=== Placeholder for OpenCms toolbar in edit mode ===-->
	<div style="background: lightgray; height: 50px;">&nbsp;</div>
</c:if>

<cms:container name="page-complete" type="page" width="1200" maxElements="15" editableby="ROLE.DEVELOPER">
    <cms:bundle basename="com.alkacon.unify.formatters.messages">
        <div class="oc-container-jsp"> 
            <h1>
				<fmt:message key="unify.page.headline.emptycontainer"/>
				<div class="oc-label-developer">DEVELOPER</div>
			</h1>
            <p><fmt:message key="unify.page.text.emptycontainer"/></p>           
        </div>
    </cms:bundle>
</cms:container>

</div><!--/wrapper-->

<%-- JavaScript files placed at the end of the document so the pages load faster --%>
<cms:headincludes type="javascript" defaults="%(link.weak:/system/modules/com.alkacon.unify.basics/resources/js/scripts-all.min.js:0fc90357-5155-11e5-abeb-0242ac11002b)" />
<script type="text/javascript">
    jQuery(document).ready(function() {
      	App.init();
      	try {
      		createBanner();
      	} catch(e) {}
    });
</script>
<!--[if lt IE 9]>
    <script src="<cms:link>%(link.weak:/system/modules/com.alkacon.unify.basics/resources/compatibility/respond.js:164f5662-515b-11e5-abeb-0242ac11002b)</cms:link>"></script>
    <script src="<cms:link>%(link.weak:/system/modules/com.alkacon.unify.basics/resources/compatibility/html5shiv.js:163824de-515b-11e5-abeb-0242ac11002b)</cms:link>"></script>
    <script src="<cms:link>%(link.weak:/system/modules/com.alkacon.unify.basics/resources/compatibility/placeholder-IE-fixes.js:16423700-515b-11e5-abeb-0242ac11002b)</cms:link>"></script>
<![endif]-->
</body>
</html>