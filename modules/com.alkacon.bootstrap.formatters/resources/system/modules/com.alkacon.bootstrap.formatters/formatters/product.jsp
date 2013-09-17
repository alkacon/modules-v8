<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="${cms.locale}" />

<cms:formatter var="content" val="product" rdfa="rdfa">
	<c:if test="${cms.container.type == 'content-full'}">
		<div class="row-fluid">
	</c:if>

	<!--=== Content Part ===-->
	<div class="container portfolio-item">
		<div class="row-fluid margin-bottom-20">

			<!-- Carousel -->
			<div class="span4">
				<div id="myCarousel" class="carousel slide">
					<div class="carousel-inner">
						<c:forEach items="${content.valueList.Images}" var="image" varStatus="stat">
							<div class="item<c:if test="${stat.first}"> active</c:if>">
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
			<!--/span4-->
			<!-- //End Carousel -->

			<!-- Description -->
			<div class="span8">
				<h3 ${rdfa.Name}>${product.Name}</h3>
				<c:if test="${!empty product.ID || !empty product.Date || !empty product.Manufacturer}">
					<ul class="unstyled">
						<c:if test="${!empty product.ID}">
							<li ${rdfa.ID}><i class="icon-tag color-green"></i> ${product.ID}</li>
						</c:if>
						<c:if test="${!empty product.Date}">
							<li><i class="icon-calendar color-green"></i> <fmt:formatDate value="${cms:convertDate(product.Date)}" dateStyle="SHORT" timeStyle="SHORT" type="both" /></li>
						</c:if>
						<c:if test="${!empty product.Manufacturer}">
							<li ${rdfa.Manufacturer}><i class="icon-home color-green"></i> ${product.Manufacturer}</li>
						</c:if>
					</ul>
				</c:if>
				<c:if test="${!empty product.Color}">
					<div style="background-color: ${product.Color}; width: 50px; height: 50px;">&nbsp;</div>
				</c:if>
				<div ${rdfa.Description}>${product.Description}</div>
			</div>
			<!--/span8-->
			<!-- //End Description -->

		</div>
		<!--/row-fluid-->
	</div>
	<!--/container-->
	<!--=== End Content Part ===-->

	<c:if test="${cms.container.type == 'content-full'}">
		</div>
	</c:if>
</cms:formatter>
