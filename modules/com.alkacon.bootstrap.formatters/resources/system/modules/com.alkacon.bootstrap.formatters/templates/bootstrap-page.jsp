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

	<cms:headincludes type="css" closetags="true" defaults="%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/bootstrap/css/bootstrap.min.css:121c4199-3a3b-11e3-a584-000c2943a707)
		|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/css/style.css:0f8fcb02-3a3b-11e3-a584-000c2943a707)
		|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/css/responsive.css:0f8c217f-3a3b-11e3-a584-000c2943a707)
		|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/bxslider/jquery.bxslider.css:1264956e-3a3b-11e3-a584-000c2943a707)
		|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/font-awesome/css/font-awesome.css:127bc6fe-3a3b-11e3-a584-000c2943a707)
		|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/css/page.css:52f716c6-20f8-11e3-b4d8-000c297c001d)" />
		<link href="<cms:link>/system/modules/com.alkacon.bootstrap.formatters/resources/css/headers/header${configcontent.value.HeaderType}.css</cms:link>" rel="stylesheet" type="text/css"></link>
	<link href="<cms:link>/system/modules/com.alkacon.bootstrap.formatters/resources/css/themes/${configcontent.value.Theme}.css</cms:link>" rel="stylesheet" type="text/css"></link>
	<link href="<cms:link>/system/modules/com.alkacon.bootstrap.formatters/resources/css/themes/headers/header1-${configcontent.value.Theme}.css</cms:link>" rel="stylesheet" type="text/css"></link>

	<cms:headincludes type="javascript" defaults="%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/jquery-1.10.2.min.js:190d730b-3a3b-11e3-a584-000c2943a707)
		|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/jquery-migrate-1.2.1.min.js:18ff9052-3a3b-11e3-a584-000c2943a707)
		|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/bootstrap/js/bootstrap.min.js:123d101f-3a3b-11e3-a584-000c2943a707)
		|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/hover-dropdown.min.js:1903fd25-3a3b-11e3-a584-000c2943a707)
		|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/bxslider/jquery.bxslider.js:12686601-3a3b-11e3-a584-000c2943a707)
		|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/back-to-top.js:1908df28-3a3b-11e3-a584-000c2943a707)
		|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/js/app.js:11fe5a44-3a3b-11e3-a584-000c2943a707)" />
	<script type="text/javascript">
		jQuery(document).ready(function() {
			App.init();
		});
	</script>
	<!--[if lt IE 9]>
    	<script src="<cms:link>%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/respond.js:192037c7-3a3b-11e3-a584-000c2943a707)</cms:link>"></script>
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
	<div class="navbar navbar-default" role="navigation">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-responsive-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="<cms:link>${cms.subSitePath}</cms:link>">
                    <cms:img scaleType="2" scaleColor="transparent" height="40" id="logo-header" src="%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/img/logo/logo_opencms_png24.png:aa1519ad-1abc-11e3-9246-000c29f9a2ec)" alt="Logo"/>
                </a>
            </div>
			<!-- Menu -->       
			<cms:include file="%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/elements/nav-main.jsp:f6dcd82c-1a24-11e3-9358-000c29f9a2ec)">
				<cms:param name="startlevel">${configcontent.value.NavStartLevel}</cms:param>
			</cms:include>
		</div><!-- /container -->
	</div><!-- /navbar -->
</div><!--/header -->
<!--=== End Header ===-->

<c:if test="${(pagefullwidth != 'true') && (pagefullwidth != 'false')}">
<!--=== Breadcrumbs ===-->
<div class="breadcrumbs margin-bottom-30">
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
		<div class="row">
			<div class="col-md-${pagelayout}">
				<cms:container name="middle-left" type="content" width="${(pagelayout * 100) - 30}" detailview="${leftDetail}"/>
				<cms:container name="middle-left-detail" type="content" detailonly="true"/>				
			</div>
			<div class="col-md-${12 - pagelayout}">
				<cms:container name="middle-right-detail" type="content" detailonly="true"/>				
				<cms:container name="middle-right" type="content" width="${((12 - pagelayout) * 100) - 30}" detailview="${not leftDetail}"/>
			</div> 
		</div><!--/row-->
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