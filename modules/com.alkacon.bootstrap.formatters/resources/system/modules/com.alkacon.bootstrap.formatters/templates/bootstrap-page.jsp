<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %><%--
--%><%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %><%--
--%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%--
--%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%--
--%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%--
--%><fmt:setLocale value="${cms.locale}" /><!DOCTYPE html>
<!--[if IE 7]> <html lang="${cms.locale}" class="ie7"> <![endif]-->  
<!--[if IE 8]> <html lang="${cms.locale}" class="ie8"> <![endif]-->  
<!--[if IE 9]> <html lang="${cms.locale}" class="ie9"> <![endif]-->  
<!--[if !IE]><!--> <html lang="${cms.locale}"> <!--<![endif]-->  
<head>
	<title><cms:info property="opencms.title" /></title>
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	<meta name="description" content="<cms:property name="Description" file="search" default="" />"/>
	<meta name="keywords" content="<cms:property name="Keywords" file="search" default="" />"/>
	<meta http-equiv="Content-Type" content="text/html; charset=${cms.requestContext.encoding}"/>
	<meta name="robots" content="index, follow"/>
	<meta name="revisit-after" content="7 days"/>

	<c:set var="pageconfig">${cms.subSitePath}.content/.pageconfig</c:set>
	<c:catch var="errconf">
		<c:set var="confparam">${cms.subSitePath}.content/|bs-configuration|1</c:set>
		<cms:contentload collector="allInFolder" param="%(pageContext.confparam)" editable="false">
			<cms:contentaccess var="configcontent" />
			<c:set var="pageconfig">${configcontent.filename}</c:set>
		</cms:contentload>
	</c:catch>
	<c:set var="pagelayout"><cms:property name="bs.page.layout" file="search" default="9" /></c:set>
	<c:set var="pagefullwidth"><cms:property name="bs.page.fullwidth" file="search" default="false-bc" /></c:set>

	<cms:enable-ade/>

	<cms:headincludes type="css" closetags="true" defaults="%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/bootstrap/css/bootstrap.min.css:0dabb26f-1b95-11e3-a120-000c29f9a2ec)
		|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/css/style.css:0b639751-1b95-11e3-a120-000c29f9a2ec)
		|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/bootstrap/css/bootstrap-responsive.min.css:0d9d8199-1b95-11e3-a120-000c29f9a2ec)
		|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/bxslider/jquery.bxslider.css:771792bd-1eee-11e3-bba9-000c297c001d)
		|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/css/style_responsive.css:0b6ac344-1b95-11e3-a120-000c29f9a2ec)
		|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/font-awesome/css/font-awesome.css:0e03e4ae-1b95-11e3-a120-000c29f9a2ec)
		|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/css/page.css:52f716c6-20f8-11e3-b4d8-000c297c001d)" />
		<link href="<cms:link>/system/modules/com.alkacon.bootstrap.formatters/resources/css/headers/header${configcontent.value.HeaderType}.css</cms:link>" rel="stylesheet" type="text/css"></link>
	<link href="<cms:link>/system/modules/com.alkacon.bootstrap.formatters/resources/css/themes/${configcontent.value.Theme}.css</cms:link>" rel="stylesheet" type="text/css"></link>
	<link href="<cms:link>/system/modules/com.alkacon.bootstrap.formatters/resources/css/themes/headers/header1-${configcontent.value.Theme}.css</cms:link>" rel="stylesheet" type="text/css"></link>

	<cms:headincludes type="javascript" defaults="%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/js/jquery-1.8.2.min.js:0bd87967-1b95-11e3-a120-000c29f9a2ec)
		|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/js/modernizr.custom.js:0bdfa55a-1b95-11e3-a120-000c29f9a2ec)
		|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/bootstrap/js/bootstrap.min.js:0de75bf1-1b95-11e3-a120-000c29f9a2ec)
		|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/bxslider/jquery.bxslider.js:771cc2e0-1eee-11e3-bba9-000c297c001d)
		|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/back-to-top.js:0e8263b2-1b95-11e3-a120-000c29f9a2ec)
		|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/js/app.js:0bd14d74-1b95-11e3-a120-000c29f9a2ec)" />
	<script type="text/javascript">
		jQuery(document).ready(function() {
			App.init();
		});
	</script>
	<!--[if lt IE 9]>
    	<script src="<cms:link>%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/js/respond.js:0bf77325-1b95-11e3-a120-000c29f9a2ec)</cms:link>"></script>
	<![endif]-->
</head><body>
<div class="page-wrap">

<!--=== Top ===-->
<div class="top">
    <div class="container">
        ${configcontent.value.Header}
    </div>
</div><!--/top-->
<!--=== End Top ===-->

<!--=== Header ===-->
<div class="header">
    <div class="container">
        <!-- Logo -->
        <div class="logo">
            <a href="<cms:link>${cms.subSitePath}</cms:link>"><img id="logo-header" src="<cms:link>%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/img/logo/logo_opencms_png24.png:aa1519ad-1abc-11e3-9246-000c29f9a2ec)</cms:link>" alt="Logo"></a>
        </div><!-- /logo -->
        <!-- Menu -->       
        <cms:include file="%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/elements/nav-main.jsp:f6dcd82c-1a24-11e3-9358-000c29f9a2ec)">
			<cms:param name="startlevel">${configcontent.value.NavStartLevel}</cms:param>
		</cms:include>
    </div><!-- /container -->
</div><!--/header -->
<!--=== End Header ===-->

<c:if test="${(pagefullwidth != 'true') && (pagefullwidth != 'false')}">
<!--=== Breadcrumbs ===-->
<div class="row-fluid breadcrumbs margin-bottom-30">
	<div class="container">
        <h1 class="pull-left"><cms:info property="opencms.title" /></h1>
        <cms:include file="%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/elements/nav-breadcrumb.jsp:6f6f2ea3-1bb3-11e3-a120-000c29f9a2ec)">
			<cms:param name="startlevel">${configcontent.value.NavStartLevel}</cms:param>
		</cms:include>
    </div><!--/container-->
</div><!--/breadcrumbs-->
<!--=== End Breadcrumbs ===-->
</c:if>

<!--=== Content Part ===-->

<c:if test="${(pagefullwidth != 'true') && (pagefullwidth != 'true-bc')}">
	<div class="container">
</c:if>

    <cms:container name="top" type="content-full" width="1200" maxElements="15" />

<c:if test="${(pagefullwidth == 'true') || (pagefullwidth == 'true-bc')}">
	<div class="container">
</c:if>

	<c:if test="${pagelayout != 'full'}">
		<c:choose>
			<c:when test="${pagelayout < 6}">
				<c:set var="leftDetail" value="false" />
			</c:when>
			<c:otherwise>
				<c:set var="leftDetail" value="true" />
			</c:otherwise>
		</c:choose>
		<div class="row-fluid">
			<div class="span${pagelayout}">
				<cms:container name="middle-left" type="content" width="${(pagelayout * 100) - 30}" detailview="${leftDetail}"/>
				<cms:container name="middle-left-detail" type="content" detailonly="true"/>				
			</div>
			<div class="span${12 - pagelayout}">
				<cms:container name="middle-right" type="content" width="${((12 - pagelayout) * 100) - 30}" detailview="${not leftDetail}"/>
				<cms:container name="middle-right-detail" type="content" detailonly="true"/>				
			</div> 
		</div><!--/row-fluid-->
        <cms:container name="bottom" type="content-full" width="1200" maxElements="15" />
	</c:if>

</div><!--/container-->		
<!--=== End Content Part ===-->

<!--=== Foot ===-->
<cms:container name="foot" type="foot-full" width="1200" maxElements="15" />
<!--=== End Foot ===-->

</div><!--/page-wrap-->
</body>
</html>