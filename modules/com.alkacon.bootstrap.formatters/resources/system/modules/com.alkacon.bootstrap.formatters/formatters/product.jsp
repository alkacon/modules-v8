<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.bootstrap.schemas.product">

<cms:formatter var="content" val="product" rdfa="rdfa">
	
<!--=== Content Part ===-->
	<div class="portfolio-item" itemscope itemtype="http://schema.org/Product">
		<div class="row margin-bottom-20">

			<c:if test="${fn:length(content.valueList.Images) > 0}">
			<!-- Carousel -->
			<div class="col-md-4">
				<div id="myCarousel" class="carousel slide carousel-v1">
					<div class="carousel-inner">
						<c:forEach items="${content.valueList.Images}" var="image" varStatus="stat">
							<div class="item<c:if test="${stat.first}"> active</c:if>" itemprop="image">
								<cms:img src="${image.value.Image}" width="800" scaleType="2" scaleColor="transparent" scalePosition="0" title="${image.value.Title}" alt="${image.value.Description}" />
								<div class="carousel-caption">
									<h4 ${image.rdfa.Title}>${image.value.Title}</h4>
									<p ${image.rdfa.Description}>${image.value.Description}</p>
								</div>
							</div>
						</c:forEach>
					</div>
					<div class="carousel-arrow">
						<a data-slide="prev" href="#myCarousel" class="left carousel-control"><i class="icon-angle-left"></i></a>
						<a data-slide="next" href="#myCarousel" class="right carousel-control"><i class="icon-angle-right"></i></a>
					</div>
				</div>
			</div>
			<!--/col-md-4-->
			<!-- //End Carousel -->
			</c:if>

			<!-- Description -->
			<div class="col-md-8">
				<h3 ${rdfa.Name} itemprop="name">${product.Name}</h3>
				<c:if test="${product.Price.isSet}">
					<div itemprop="offers" itemscope itemtype="http://schema.org/Offer">
						<h4><span><fmt:message key="product.price" /> </span><b><span itemprop="price" ${rdfa.Price}>${product.Price}</span></b></h4>
					</div>
				</c:if>
				<c:if test="${product.Color.exists}">
					<h4>Color: <div style="background-color: ${product.Color}; color: white; padding: 7px; text-align: center; display: inline-block; width: 125px; height: 20px;" itemprop="color">${product.Color}</div></h4>
				</c:if>
				<c:choose>
					<c:when test="${product.BrandLogo.isSet && product.BrandLogo.value.Image.exists && product.BrandName.exists}">
						<div itemprop="brand" itemscope itemtype="http://schema.org/Brand">
							<h4><fmt:message key="product.brand" /> <img itemprop="logo" src="<cms:link>${product.BrandLogo.value.Image}?__scale=w:80,h:39,c:transparent</cms:link>" title="${product.BrandLogo.value.Title}" alt="${product.BrandLogo.value.Description}" /><span ${rdfa.BrandName} itemprop="name" style="visibility: hidden;">${product.BrandName}</span></h4>
						</div>
					</c:when>
					<c:when test="${product.BrandLogo.isSet && product.BrandLogo.value.Image.exists}">
						<div itemprop="brand" itemscope itemtype="http://schema.org/Brand">
							<h4><fmt:message key="product.brand" /> <img itemprop="logo" src="<cms:link>${product.BrandLogo.value.Image}?__scale=w:80,h:39,c:transparent</cms:link>" title="${product.BrandLogo.value.Title}" alt="${product.BrandLogo.value.Description}" /></h4>
						</div>
					</c:when>
					<c:when test="${product.BrandName.exists}">
						<div itemprop="brand" itemscope itemtype="http://schema.org/Brand">
							<h4><fmt:message key="product.brand" /> <span ${rdfa.BrandName} itemprop="name">${product.BrandName}</span></h4>
						</div>
					</c:when>
					<c:otherwise>
						<!-- NOOP -->
					</c:otherwise>
				</c:choose>
				<c:if test="${product.Price.exists || product.Date.exists || product.Manufacturer.exists || product.ID.exists}">
					<ul class="list-unstyled">
						<c:if test="${product.Date.exists}">
							<li itemprop="releaseDate"><i class="icon-calendar color-green"></i> <fmt:formatDate value="${cms:convertDate(product.Date)}" dateStyle="SHORT" timeStyle="SHORT" type="both" /></li>
						</c:if>
						<c:if test="${product.Manufacturer.exists}">
							<li ${rdfa.Manufacturer} itemprop="manufacturer"><i class="icon-home color-green"></i> ${product.Manufacturer}</li>
						</c:if>
						<c:if test="${product.ID.exists}">
							<li ${rdfa.ID} itemprop="productID"><i class="icon-tag color-green"></i> ${product.ID}</li>
						</c:if>
					</ul>
				</c:if>
				<div ${rdfa.Description} itemprop="description">${product.Description}</div>
			</div>
			<!--/col-md-8-->
			<!-- //End Description -->

		</div>
		<!--/row-->
	</div>
	<!--/container-->
<!--=== End Content Part ===-->

</cms:formatter>
</cms:bundle>