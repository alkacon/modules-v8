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
	<c:set var="pagelayout"><cms:property name="bs.page.layout" file="search" default="default" /></c:set>

	<cms:enable-ade/>

	<cms:headincludes type="css" closetags="true" defaults="%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/bootstrap/css/bootstrap.min.css:0dabb26f-1b95-11e3-a120-000c29f9a2ec)
		|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/css/style.css:0b639751-1b95-11e3-a120-000c29f9a2ec)
		|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/bootstrap/css/bootstrap-responsive.min.css:0d9d8199-1b95-11e3-a120-000c29f9a2ec)
		|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/bxslider/jquery.bxslider.css:771792bd-1eee-11e3-bba9-000c297c001d)
		|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/css/style_responsive.css:0b6ac344-1b95-11e3-a120-000c29f9a2ec)
		|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/font-awesome/css/font-awesome.css:0e03e4ae-1b95-11e3-a120-000c29f9a2ec)" />
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
        <cms:include file="%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/elements/nav-main.jsp:f6dcd82c-1a24-11e3-9358-000c29f9a2ec)" />                          
    </div><!-- /container -->
</div><!--/header -->
<!--=== End Header ===-->

<!--=== Breadcrumbs ===-->
<div class="row-fluid breadcrumbs margin-bottom-30">
	<div class="container">
        <h1 class="pull-left"><cms:info property="opencms.title" /></h1>
        <cms:include file="%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/elements/nav-breadcrumb.jsp:6f6f2ea3-1bb3-11e3-a120-000c29f9a2ec)" />
    </div><!--/container-->
</div><!--/breadcrumbs-->
<!--=== End Breadcrumbs ===-->

<!--=== Content Part ===-->
<div class="container">		

    <cms:container name="top-content-container" type="content-full" width="940" maxElements="12" detailview="false"/>

	<c:choose>
		<c:when test="${pagelayout == 'default'}">
			<div class="row-fluid">
				<div class="span9">
					<cms:container name="content-container" type="content" width="680" maxElements="12" detailview="true"/>
				</div>
				<div class="span3">
					<cms:container name="column-container" type="column" width="230" maxElements="8" detailview="false"/>
				</div> 
			</div><!--/row-fluid-->
		</c:when>
		<c:when test="${pagelayout == 'left'}">
			<div class="row-fluid">
				<div class="span3">
					<cms:container name="column-container" type="column" width="230" maxElements="8" detailview="false"/>
				</div> 
				<div class="span9">
					<cms:container name="content-container" type="content" width="680" maxElements="12" detailview="true"/>
				</div>
			</div><!--/row-fluid-->
		</c:when>
	</c:choose>

	<c:if test="${pagelayout != 'full'}">
        <cms:container name="bottom-content-container" type="content-full" width="940" maxElements="12" detailview="false"/>
	</c:if>

</div><!--/container-->		
<!--=== End Content Part ===-->

<!--=== Footer ===-->
<div class="footer">
	<div class="container">
		<div class="row-fluid">
			<div class="span4">
                <!-- About -->
		        <div class="headline"><h3>About</h3></div>	
				<p class="margin-bottom-25">Unify is an incredibly beautiful responsive Bootstrap Template for corporate and creative professionals.</p>	

	            <!-- Monthly Newsletter -->
		        <div class="headline"><h3>Monthly Newsletter</h3></div>	
				<p>Subscribe to our newsletter and stay up to date with the latest news and deals!</p>
				<form class="form-inline">
					<div class="input-append">
						<input type="text" placeholder="Email Address" class="input-medium">
						<button class="btn-u">Subscribe</button>
					</div>
				</form>							
			</div><!--/span4-->	
			
			<div class="span4">
                <div class="posts">
                    <div class="headline"><h3>Recent Blog Entries</h3></div>
                    <dl class="dl-horizontal">
                        <dt><a href="#"><img src="assets/img/sliders/elastislide/6.jpg" alt="" /></a></dt>
                        <dd>
                            <p><a href="#">Anim moon officia Unify is an incredibly beautiful responsive Bootstrap Template</a></p> 
                        </dd>
                    </dl>
                    <dl class="dl-horizontal">
                    <dt><a href="#"><img src="assets/img/sliders/elastislide/10.jpg" alt="" /></a></dt>
                        <dd>
                            <p><a href="#">Anim moon officia Unify is an incredibly beautiful responsive Bootstrap Template</a></p> 
                        </dd>
                    </dl>
                    <dl class="dl-horizontal">
                    <dt><a href="#"><img src="assets/img/sliders/elastislide/11.jpg" alt="" /></a></dt>
                        <dd>
                            <p><a href="#">Anim moon officia Unify is an incredibly beautiful responsive Bootstrap Template</a></p> 
                        </dd>
                    </dl>
                </div>
			</div><!--/span4-->

			<div class="span4">
	            <!-- Monthly Newsletter -->
		        <div class="headline"><h3>Contact Us</h3></div>	
                <address>
					25, Lorem Lis Street, Orange <br />
					California, US <br />
					Phone: 800 123 3456 <br />
					Fax: 800 123 3456 <br />
					Email: <a href="mailto:info@anybiz.com" class="">info@anybiz.com</a>
                </address>

                <!-- Stay Connected -->
		        <div class="headline"><h3>Stay Connected</h3></div>	
                <ul class="social-icons">
                    <li><a href="#" data-original-title="Feed" class="social_rss"></a></li>
                    <li><a href="#" data-original-title="Facebook" class="social_facebook"></a></li>
                    <li><a href="#" data-original-title="Twitter" class="social_twitter"></a></li>
                    <li><a href="#" data-original-title="Goole Plus" class="social_googleplus"></a></li>
                    <li><a href="#" data-original-title="Pinterest" class="social_pintrest"></a></li>
                    <li><a href="#" data-original-title="Linkedin" class="social_linkedin"></a></li>
                    <li><a href="#" data-original-title="Vimeo" class="social_vimeo"></a></li>
                </ul>
			</div><!--/span4-->
		</div><!--/row-fluid-->	
	</div><!--/container-->	
</div><!--/footer-->	
<!--=== End Footer ===-->

<!--=== Copyright ===-->
<div class="copyright">
	<div class="container">
		${configcontent.value.Copyright}
	</div><!--/container-->
</div><!--/copyright-->
<!--=== End Copyright ===-->

</div><!--/page-wrap-->
</body>
</html>