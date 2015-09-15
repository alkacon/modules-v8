<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.unify.schemas.event">

<cms:formatter var="content" val="value" rdfa="rdfa">

<div class="mb-20">
<c:choose>
		<c:when test="${cms.element.inMemoryOnly}">
			<div class="alert"><fmt:message key="unify.event.message.edit" /></div>
		</c:when>
		<c:otherwise>
          <!-- blog header -->
          <div class="blog-page">
              <div class="blog">

                  <div class="headline"><h2 ${rdfa.Title}>${value.Title}</h2></div>                             

                  <ul class="list-unstyled list-inline blog-info">
                      <li><i class="icon-calendar"></i> <fmt:formatDate value="${cms:convertDate(value.Date)}" dateStyle="SHORT" timeStyle="SHORT" type="both" />
                      	<c:if test="${value.EndDate.isSet}"> - <fmt:formatDate value="${cms:convertDate(value.EndDate)}" dateStyle="SHORT" timeStyle="SHORT" type="both" /></c:if>
                      </li>
                  </ul>
                  <c:if test="${fn:length(content.valueList.Category) > 0}">
                  <ul class="pull-left list-unstyled list-inline blog-tags">
                      <li>
                          <i class="fa fa-tag"></i>&nbsp;
                          <c:forEach var="item" items="${fn:split(content.value.Category,',')}" varStatus="status">
                              <span class="label rounded label-light">${cms.vfs.property[item]['Title']}</span>
                          </c:forEach>
                      </li>
                  </ul>
                  </c:if>
              </div>
          </div><%-- //END blog header --%>

          <%-- paragraphs --%>
          <c:forEach var="paragraph" items="${content.valueList.Paragraph}" varStatus="status">

          <div class="paragraph margin-bottom-20">

              <c:set var="imgalign">noimage</c:set>
              <c:if test="${paragraph.value.Image.exists}">
                  <c:set var="imgalign"><cms:elementsetting name="imgalign" default="left" /></c:set>
              </c:if>

              <c:if test="${paragraph.value.Headline.isSet}">
                  <div class="headline"><h4 ${paragraph.rdfa.Headline}>${paragraph.value.Headline}</h4></div>
              </c:if>

              <c:choose>

                  <c:when test="${imgalign == 'noimage'}">
                      <span ${paragraph.rdfa.Image}></span>
                      <div ${paragraph.rdfa.Text}>${paragraph.value.Text}</div>
                      <c:if test="${status.last and (value.Location.isSet or value.Address.isSet)}">
                              	<div class="row">
                              		<div class="hidden-xs col-sm-1">
                              			<i class="icon-custom icon-sm icon-color-u fa fa-map-marker"></i>
                              		</div>
                              		<div class="col-xs-12 col-sm-11">
	                              		<c:if test="${value.Location.isSet}">
	                              			<h5 ${rdfa.Location}>${value.Location}</h5>
	                              		</c:if>
	                              		<c:if test="${value.Address.isSet}">
	                              			<div ${rdfa.Address}>${value.Address}</div>
	                              		</c:if>
                              		</div>
                              	</div>
                              </c:if>       
                      <c:if test="${paragraph.value.Link.exists}">
                          <p><a class="btn-u btn-u-small" href="<cms:link>${paragraph.value.Link.value.URI}</cms:link>">${paragraph.value.Link.value.Text}</a></p>
                      </c:if>
                  </c:when>

                  <c:when test="${imgalign == 'left'}">       
                      <div class="row">
                          <div class="col-md-4">
                              <div ${paragraph.rdfa.Image} class="thumbnail-kenburn"><div class="overflow-hidden">
                                  <cms:img src="${paragraph.value.Image.value.Image}" scaleColor="transparent" width="400" scaleType="0" cssclass="img-responsive" alt="${paragraph.value.Image.value.Title}" title="${paragraph.value.Image.value.Title}" />
                              </div></div>        
                          </div>
                          <div class="col-md-8">
                              <div ${paragraph.rdfa.Text}>${paragraph.value.Text}</div>
                              <c:if test="${status.last and (value.Location.isSet or value.Address.isSet)}">
                              	<div class="row">
                              		<div class="hidden-xs col-sm-1">
                              			<i class="icon-custom icon-sm icon-color-u fa fa-map-marker"></i>
                              		</div>
                              		<div class="col-xs-12 col-sm-11">
	                              		<c:if test="${value.Location.isSet}">
	                              			<h5 ${rdfa.Location}>${value.Location}</h5>
	                              		</c:if>
	                              		<c:if test="${value.Address.isSet}">
	                              			<div ${rdfa.Address}>${value.Address}</div>
	                              		</c:if>
                              		</div>
                              	</div>
                              </c:if>       
                              <c:if test="${paragraph.value.Link.exists}">
                                  <p><a class="btn-u btn-u-small" href="<cms:link>${paragraph.value.Link.value.URI}</cms:link>">${paragraph.value.Link.value.Text}</a></p>
                              </c:if>     
                          </div>
                      </div>      
                  </c:when>

                  <c:when test="${imgalign == 'right'}">
                      <div class="row">
                          <div class="col-md-8">
                              <div ${paragraph.rdfa.Text}>${paragraph.value.Text}</div>
                              <c:if test="${status.last and (value.Location.isSet or value.Address.isSet)}">
                              	<div class="row">
                              		<div class="hidden-xs col-sm-1">
                              			<i class="icon-custom icon-sm icon-color-u fa fa-map-marker"></i>
                              		</div>
                              		<div class="col-xs-12 col-sm-11">
	                              		<c:if test="${value.Location.isSet}">
	                              			<h5 ${rdfa.Location}>${value.Location}</h5>
	                              		</c:if>
	                              		<c:if test="${value.Address.isSet}">
	                              			<div ${rdfa.Address}>${value.Address}</div>
	                              		</c:if>
                              		</div>
                              	</div>
                              </c:if>       
                              <c:if test="${paragraph.value.Link.exists}">
                                  <p><a class="btn-u btn-u-small" href="<cms:link>${paragraph.value.Link.value.URI}</cms:link>">${paragraph.value.Link.value.Text}</a></p>
                              </c:if>     
                          </div>
                          <div class="col-md-4">
                              <div ${paragraph.rdfa.Image} class="thumbnail-kenburn"><div class="overflow-hidden">
                                  <cms:img src="${paragraph.value.Image.value.Image}" scaleColor="transparent" width="400" scaleType="0" cssclass="img-responsive" alt="${paragraph.value.Image.value.Title}" title="${paragraph.value.Image.value.Title}" />
                              </div></div>        
                          </div>
                      </div>          
                  </c:when>

              </c:choose> 

          </div>

          </c:forEach><%-- //END paragraphs --%>
    	</c:otherwise>
	</c:choose>   
</div>
</cms:formatter>
</cms:bundle> 