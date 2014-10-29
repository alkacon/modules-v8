<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<cms:formatter var="content" val="value" rdfa="rdfa">
<div>
<div class="header">

<c:if test="${not value.Header.isEmpty}">
<!--=== Top ===-->
<div class="topbar">
    <div class="container">
        ${value.Header}
    </div>
</div><!--/top-->
<!--=== End Top ===-->
</c:if>

<!--=== Navbar ===-->
	<div class="navbar navbar-default" role="navigation">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-responsive-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="fa fa-bars"></span>
                </button>
                <a class="navbar-brand" href="<cms:link>${value.LogoLink}</cms:link>">
                    <cms:img scaleType="2" scaleColor="transparent" height="40" id="logo-header" src="%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/img/logo/logo_opencms_png24.png:aa1519ad-1abc-11e3-9246-000c29f9a2ec)" alt="Logo"/>
                </a>
            </div>
			<!-- Menu -->       
			<cms:include file="%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/elements/nav-main.jsp:f6dcd82c-1a24-11e3-9358-000c29f9a2ec)">
				<cms:param name="startlevel">${value.NavStartLevel}</cms:param>
			</cms:include>
		</div><!-- /container -->
	</div><!-- /navbar -->
<!--=== End Navbar ===-->

</div><!--/header -->

<c:set var="showbreadcrumb"><c:out value="${cms.element.settings.showbreadcrumb}" default="true" /></c:set>
<c:if test="${showbreadcrumb == 'true'}">
<!--=== Breadcrumbs ===-->
<div class="breadcrumbs">
	<div class="container">
        <h1 class="pull-left">
			${cms.title}
            <c:if test="${cms.isEditMode}">
            <span class="badge badge-dark-blue rounded superscript">${cms.requestContext.currentUser.name}</span>
            </c:if>
		</h1>
        <cms:include file="%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/elements/nav-breadcrumb.jsp:6f6f2ea3-1bb3-11e3-a120-000c29f9a2ec)">
			<cms:param name="startlevel">${value.NavStartLevel}</cms:param>
		</cms:include>
    </div><!--/container-->
</div><!--/breadcrumbs-->
<!--=== End Breadcrumbs ===-->
</c:if>

</div>
</cms:formatter>