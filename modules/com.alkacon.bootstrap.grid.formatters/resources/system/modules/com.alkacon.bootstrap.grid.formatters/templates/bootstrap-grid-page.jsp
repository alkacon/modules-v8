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

	<link rel="apple-touch-icon" sizes="120x120" href="<cms:link>/system/modules/com.alkacon.bootstrap.grid.formatters/resources/img/favicon_120.png</cms:link>"/>
	<link rel="shortcut icon" href="<cms:link>/system/modules/com.alkacon.bootstrap.grid.formatters/resources/img/favicon_16.png</cms:link>" type="image/png"/>

	<cms:enable-ade/>
	
	<c:if test="${not cms.isOnlineProject}">
		<cms:headincludes type="css" closetags="false" defaults="%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/bootstrap/css/bootstrap.css:a37af2b8-8833-11e3-8675-3b52e9337fb8)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.grid.formatters/resources/css/style.css:e6448383-3989-11e4-a560-005056b61161)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.grid.formatters/resources/css/app.css:e639d516-3989-11e4-a560-005056b61161)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.grid.formatters/resources/plugins/bxslider/jquery.bxslider.css:e6d6b137-3989-11e4-a560-005056b61161)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.grid.formatters/resources/plugins/line-icons/line-icons.css:e74e52c3-3989-11e4-a560-005056b61161)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.grid.formatters/resources/plugins/font-awesome/css/font-awesome.css:e6fc3ac9-3989-11e4-a560-005056b61161)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.grid.formatters/resources/css/search.css:e6408bde-3989-11e4-a560-005056b61161)" />
	</c:if>
	<c:if test="${cms.isOnlineProject}">
		<cms:headincludes type="css" closetags="false" defaults="%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/bootstrap/css/bootstrap.min.css:a383301a-8833-11e3-8675-3b52e9337fb8)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.grid.formatters/resources/css/style.css:e6448383-3989-11e4-a560-005056b61161)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.grid.formatters/resources/css/app.css:e639d516-3989-11e4-a560-005056b61161)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.grid.formatters/resources/plugins/bxslider/jquery.bxslider.css:e6d6b137-3989-11e4-a560-005056b61161)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.grid.formatters/resources/plugins/line-icons/line-icons.css:e74e52c3-3989-11e4-a560-005056b61161)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.grid.formatters/resources/plugins/font-awesome/css/font-awesome.css:e6fc3ac9-3989-11e4-a560-005056b61161)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.grid.formatters/resources/css/search.css:e6408bde-3989-11e4-a560-005056b61161)" />
	</c:if>
		
	<c:set var="colortheme"><cms:property name="bs.page.color" file="search" default="red" /></c:set>
	<c:set var="pagelayout"><cms:property name="bs.page.layout" file="search" default="9" /></c:set>
	<link rel="stylesheet" href="<cms:link>/system/modules/com.alkacon.bootstrap.grid.formatters/resources/css/themes/${colortheme}.css</cms:link>">
	<link rel="stylesheet" href="<cms:link>%(link.weak:/system/modules/com.alkacon.bootstrap.grid.formatters/resources/css/page.css:e63d096a-3989-11e4-a560-005056b61161)</cms:link>">

	<c:if test="${not cms.isOnlineProject}">
		<cms:headincludes type="javascript" defaults="%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/jquery/jquery-1.11.1.js:2c641884-27a2-11e4-96d6-005056b61161)
		    |%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/jquery/jquery-migrate-1.2.1.min.js:4986e200-8834-11e3-8675-3b52e9337fb8)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/bootstrap/js/bootstrap.min.js:a35b35b0-8833-11e3-8675-3b52e9337fb8)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.grid.formatters/resources/plugins/bxslider/jquery.bxslider.js:e6d885f9-3989-11e4-a560-005056b61161)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.grid.formatters/resources/plugins/back-to-top.js:e85784de-3989-11e4-a560-005056b61161)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.grid.formatters/resources/js/app.js:e6bd5dae-3989-11e4-a560-005056b61161)" />
	</c:if>
	<c:if test="${cms.isOnlineProject}">
		<cms:headincludes type="javascript" defaults="%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/jquery/jquery-1.11.1.min.js:2c702676-27a2-11e4-96d6-005056b61161)
		    |%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/jquery/jquery-migrate-1.2.1.min.js:4986e200-8834-11e3-8675-3b52e9337fb8)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/bootstrap/js/bootstrap.min.js:a35b35b0-8833-11e3-8675-3b52e9337fb8)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.grid.formatters/resources/plugins/bxslider/jquery.bxslider.js:e6d885f9-3989-11e4-a560-005056b61161)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.grid.formatters/resources/plugins/back-to-top.js:e85784de-3989-11e4-a560-005056b61161)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.grid.formatters/resources/js/app.js:e6bd5dae-3989-11e4-a560-005056b61161)" />
	</c:if>

	<script type="text/javascript">
		jQuery(document).ready(function() {
			App.init();
		});
	</script>
	<!--[if lt IE 9]>
    	<script src="<cms:link>%(link.weak:/system/modules/com.alkacon.bootstrap.grid.formatters/resources/plugins/respond.js:e863e0fa-3989-11e4-a560-005056b61161)</cms:link>"></script>
	<![endif]-->
	<cms:include file="%(link.weak:/system/modules/com.alkacon.bootstrap.grid.formatters/search/config.jsp:cec7d832-3983-11e4-a560-005056b61161)" />
</head><body>
<div class="page-wrap wrapper">
<c:if test="${cms.isEditMode}">
<!--=== Placeholder for OpenCms toolbar in edit mode ===-->
<div style="background: lightgray; height: 35px">&nbsp;</div>
</c:if>

<cms:container name="page-complete" type="page" width="1200" maxElements="10" editableby="ROLE.DEVELOPER" />

</div><!--/page-wrap-->
</body>
</html>
