<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.bootstrap.schemas.list">
<cms:formatter var="con">
	<div <c:if test="${cms.container.type != 'content'}">class="row"</c:if>>

		<c:choose>
			<c:when test="${cms.element.inMemoryOnly}">
				<div class="alert"><fmt:message key="bootstrap.list.message.new" /></div>
			</c:when>
			<c:otherwise>      
				<c:if test="${not cms.element.settings.hidetitle}">
					<div class="headline headline-md"><h3 ${rdfa.Title}><c:out value="${con.value.Title}" escapeXml="false" /></h3></div>
				</c:if>
				<div class="posts lists blog-item margin-bottom-20">

   				<c:set var="layoutvariant"><c:out value="${cms.element.settings.layoutvariant}" default="top" /></c:set>
  				<c:choose>
  					<c:when test="${layoutvariant == 'top' or layoutvariant == 'left'}">
  						<c:set var="boxClass">search-blocks-${layoutvariant}-<c:out value="${cms.element.settings.color}" default="red" /></c:set>
  					</c:when>
  					<c:otherwise>
  						<c:set var="boxClass">search-blocks-colored search-blocks-<c:out value="${cms.element.settings.color}" default="red" /></c:set>
  					</c:otherwise>
  				</c:choose>

					<%-- Get path where to load / store content --%>
					<c:set var="ugcConfigFile" value="${con.value.UgcConfig}" />
					<cms:contentload collector="singleFile" param="${ugcConfigFile}">
						<cms:contentaccess var="config" />
						<c:set var="ugcConfigPath">${config.value.ContentPath}</c:set>
					</cms:contentload>


					<cms:contentload collector="allInFolder" param="${ugcConfigPath}|bs-post|${con.value.MaxShown}" preload="true" >
						<cms:contentinfo var="info" />
						<c:if test="${info.resultSize > 0}">
							<%-- <cms:contentload editable="true"> --%>
							<cms:contentload>
								<cms:contentaccess var="content" />
					
								<!-- entry -->
								<c:set var="paragraph" value="${content.value.Paragraph}" />
								<div class="search-page"><div class="search-blocks ${boxClass}">
									<div class="row">
										<c:if test="${paragraph.value.Image.exists}">
											<div class="col-md-4 search-img">
												<cms:img src="${paragraph.value.Image.value.Image}" width="800" cssclass="img-responsive"
												scaleColor="transparent" scaleType="0" noDim="true" alt="${paragraph.value.Image.value.Title}"
												title="${paragraph.value.Image.value.Title}" />
											</div>
										</c:if>
										<c:set var="textcols">
											<c:choose>
												<c:when test="${paragraph.value.Image.exists}">col-md-8</c:when>
												<c:otherwise>col-md-12</c:otherwise>
											</c:choose>
										</c:set>
										<div class="${textcols}">
											<h3>
												<a href="<cms:link>%(link.weak:/demo/user-content-list/edit-post/)</cms:link>?fileId=${content.id}&backLinkSuccess=${cms.requestContext.uri}&backLinkCancel=${cms.requestContext.uri}">
													<button type="button" class="btn btn-default bs-post-edit pull-right glyphicon glyphicon-edit"></button>
												</a>
											</h3>
											<h2><a href="<cms:link>${content.filename}</cms:link>">${paragraph.value.Headline}</a></h2>
        							<%-- <c:set var="showdate"><c:out value="${cms.element.settings.showdate}" default="true" /></c:set>
        							<c:if test="${showdate}">
                        <p><i><fmt:formatDate value="${cms:convertDate(content.value.Date)}" dateStyle="LONG" timeStyle="SHORT" type="both" /></i></p>
                      </c:if>--%>
								<%--			<c:choose>
												<c:when test="${content.value.Teaser.isSet}">
													<p>${content.value.Teaser}</p>
												</c:when>
												<c:otherwise> --%>
        									<c:set var="teaserlength"><c:out value="${cms.element.settings.teaserlength}" default="250" /></c:set>
        									<p>${cms:trimToSize(cms:stripHtml(paragraph.value.Text), teaserlength)}</p>
												<%--</c:otherwise>
											</c:choose>--%>
                      <a href="<cms:link>${content.filename}</cms:link>" class="btn-u btn-u-<c:out value="${cms.element.settings.buttoncolor}" default="red" />"><fmt:message key="bootstrap.list.message.readmore" /></a>										
										</div>
									</div>                            
								</div></div>
								<div style="height:10px"></div>
								<!-- // END entry -->

							</cms:contentload>
						</c:if>
					</cms:contentload>

					<%-- <c:if test="${con.value.Link.exists}">
						<p><a class="btn-u btn-u-small" href="<cms:link>${con.value.Link.value.URI}</cms:link>">${con.value.Link.value.Text}</a></p>
					</c:if>		
					--%>
				</div>

			</c:otherwise>
		</c:choose>

	</div>
</cms:formatter>
</cms:bundle>
