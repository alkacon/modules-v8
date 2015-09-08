<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<cms:formatter var="content" val="value" rdfa="rdfa">
<div>
<div class="header">
    <div class="container">

      <a class="logo" href="<cms:link>${value.LogoLink}</cms:link>">
          <cms:img scaleType="2" scaleColor="transparent" height="40" id="logo-header" src="%(link.weak:/system/modules/com.alkacon.unify.basics/resources/img/logo/logo_opencms_png24.png:0c407c7c-5159-11e5-abeb-0242ac11002b)" alt="Logo"/>
      </a>

      <c:if test="${not value.Header.isEmpty}">
      <!--=== Top ===-->
      <div class="topbar">
          ${value.Header}
      </div><!--/top-->
      <!--=== End Top ===-->
      </c:if>

      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-responsive-collapse">
          <span class="sr-only">Toggle navigation</span>
          <span class="fa fa-bars"></span>
      </button>
    </div><!--/end container-->

	<!-- Menu -->       
	<cms:include file="%(link.weak:/system/modules/com.alkacon.unify.formatters/elements/nav-main.jsp:f94e9fdc-5606-11e5-b868-0242ac11002b)">
		<cms:param name="startlevel">${value.NavStartLevel}</cms:param>
	</cms:include>

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
        <cms:include file="%(link.weak:/system/modules/com.alkacon.unify.formatters/elements/nav-breadcrumb.jsp:f93dafe7-5606-11e5-b868-0242ac11002b)">
			<cms:param name="startlevel">${value.NavStartLevel}</cms:param>
		</cms:include>
    </div><!--/container-->
</div><!--/breadcrumbs-->
<!--=== End Breadcrumbs ===-->
</c:if>

</div>
</cms:formatter>