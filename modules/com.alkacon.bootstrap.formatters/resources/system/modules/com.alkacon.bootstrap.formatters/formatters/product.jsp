<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<cms:formatter var="product" val="value" rdfa="rdfa">

<c:if test="${cms.container.type == 'content-full'}"><div class="row-fluid"></c:if>


<!--=== Content Part ===-->
<div class="container portfolio-item"> 	
	<div class="row-fluid margin-bottom-20"> 
		<!-- Carousel -->
        <div class="span5">
            <div id="myCarousel" class="carousel slide">
                <div class="carousel-inner">
					<c:forEach items="${product.valueList.Images}" var="image">
					<div class="item">
						<cms:img src="${image.value.Image}" alt="${image.value.Title}" title="${image.value.Title}" width="600" scaleColor="transparent" scaleType="0"/>
						<div class="carousel-caption">
							<h4>${image.value.Title}</h4>
							<p>${image.value.Title}</p>
						</div>
					</div>
					</c:forEach>
                </div>
                <div class="carousel-arrow">
                    <a data-slide="prev" href="#myCarousel" class="left carousel-control"><i class="icon-angle-left"></i></a>
                    <a data-slide="next" href="#myCarousel" class="right carousel-control"><i class="icon-angle-right"></i></a>
                </div>
            </div>
        </div><!--/span5-->
        <!-- //End Tabs and Carousel -->

        <div class="span7">
        	<h3>${product.value.Name}</h3>
			<p>${product.value.Description}</p>
            <ul class="unstyled">
            	<li><i class="icon-user color-green"></i> Jack Baur</li>
            	<li><i class="icon-calendar color-green"></i> 14,2003 February</li>
            	<li><i class="icon-tags color-green"></i> Websites, Google, HTML5/CSS3</li>
            </ul>
			<c:if test="${!empty product.value.Color}">
				<div style="background-color: ${product.value.Color}; width: 50px; height: 50px;">&nbsp;</div>
			</c:if>
        </div><!--/span7-->
    </div><!--/row-fluid-->
</div><!--/container-->
<!--=== End Content Part ===-->


<c:if test="${cms.container.type == 'content-full'}"></div></c:if>

</cms:formatter>

