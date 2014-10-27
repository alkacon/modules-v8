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

	<link rel="apple-touch-icon" sizes="120x120" href="<cms:link>%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/img/favicon_120.png:fb0905ef-4ae7-11e3-bd62-000c29d28104)</cms:link>"/>
	<link rel="shortcut icon" href="<cms:link>%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/img/favicon_16.png:4b48e349-4ae9-11e3-bd62-000c29d28104)</cms:link>" type="image/png"/>

	<cms:enable-ade/>
	
	<c:if test="${not cms.isOnlineProject}">
		<cms:headincludes type="css" closetags="false" defaults="%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/bootstrap/css/bootstrap.css:a37af2b8-8833-11e3-8675-3b52e9337fb8)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/css/style.css:0f8fcb02-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/css/app.css:0f3834e2-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/plugins/bxslider/jquery.bxslider.css:1264956e-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/plugins/line-icons/line-icons.css:7761aa06-283e-11e4-96d6-005056b61161)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/plugins/font-awesome/css/font-awesome.css:127bc6fe-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/css/search.css:2e634695-0cb8-11e2-b19e-2b1b08a6835d)" />
	</c:if>
	<c:if test="${cms.isOnlineProject}">
		<cms:headincludes type="css" closetags="false" defaults="%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/bootstrap/css/bootstrap.min.css:a383301a-8833-11e3-8675-3b52e9337fb8)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/css/style.css:0f8fcb02-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/css/app.css:0f3834e2-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/plugins/bxslider/jquery.bxslider.css:1264956e-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/plugins/line-icons/line-icons.css:7761aa06-283e-11e4-96d6-005056b61161)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/plugins/font-awesome/css/font-awesome.css:127bc6fe-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/css/search.css:2e634695-0cb8-11e2-b19e-2b1b08a6835d)" />
	</c:if>
		
	<c:set var="colortheme"><cms:property name="bs.page.color" file="search" default="red" /></c:set>
	<c:set var="pagelayout"><cms:property name="bs.page.layout" file="search" default="9" /></c:set>
	<link rel="stylesheet" href="<cms:link>/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/css/themes/${colortheme}.css</cms:link>">
	<link rel="stylesheet" href="<cms:link>%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/css/page.css:52f716c6-20f8-11e3-b4d8-000c297c001d)</cms:link>">

	<c:if test="${not cms.isOnlineProject}">
		<cms:headincludes type="javascript" defaults="%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/jquery/jquery-1.11.1.js:2c641884-27a2-11e4-96d6-005056b61161)
		    |%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/jquery/jquery-migrate-1.2.1.min.js:4986e200-8834-11e3-8675-3b52e9337fb8)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/bootstrap/js/bootstrap.min.js:a35b35b0-8833-11e3-8675-3b52e9337fb8)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/plugins/bxslider/jquery.bxslider.js:12686601-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/plugins/back-to-top.js:1908df28-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/js/app.js:11fe5a44-3a3b-11e3-a584-000c2943a707)" />
	</c:if>
	<c:if test="${cms.isOnlineProject}">
		<cms:headincludes type="javascript" defaults="%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/jquery/jquery-1.11.1.min.js:2c702676-27a2-11e4-96d6-005056b61161)
		    |%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/jquery/jquery-migrate-1.2.1.min.js:4986e200-8834-11e3-8675-3b52e9337fb8)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/bootstrap/js/bootstrap.min.js:a35b35b0-8833-11e3-8675-3b52e9337fb8)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/plugins/bxslider/jquery.bxslider.js:12686601-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/plugins/back-to-top.js:1908df28-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/js/app.js:11fe5a44-3a3b-11e3-a584-000c2943a707)" />
	</c:if>

	<script type="text/javascript">
		jQuery(document).ready(function() {
			App.init();
		});
	</script>
	<!--[if lt IE 9]>
    	<script src="<cms:link>%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/plugins/respond.js:192037c7-3a3b-11e3-a584-000c2943a707)</cms:link>"></script>
	<![endif]-->
	<cms:include file="%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/search/config.jsp:b4a9ffc9-416c-11e3-81ba-000c297c001d)" />
</head><body>
<div class="page-wrap wrapper">
<c:if test="${cms.isEditMode}">
<!--=== Placeholder for OpenCms toolbar in edit mode ===-->
<div style="background: lightgray; height: 35px">&nbsp;</div>
</c:if>

<cms:container name="page-complete" type="page" width="1200" maxElements="15" editableby="ROLE.DEVELOPER">
    <cms:bundle basename="com.alkacon.bootstrap.formatters.messages">
        <div class="servive-block rounded-3x servive-block-red">
            <h2 class="heading-md"><fmt:message key="bootstrap.page.headline.emptycontainer"/></h4>
            <p><fmt:message key="bootstrap.page.text.emptycontainer"/></p>           
        </div>
    </cms:bundle>
</cms:container>

</div><!--/page-wrap-->
</body>
</html>
