<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.bootstrap.schemas.list">
	
	<cms:formatter var="con" rdfa="rdfa">
	<div <c:if test="${cms.container.type != 'content'}">class="row"</c:if>>
	<c:set var="wordCount"><fmt:formatNumber type="number" value="${((cms.container.width) / 100) * 20}" maxFractionDigits="0" /></c:set>
		<c:choose>
			<c:when test="${cms.element.inMemoryOnly}">
				<div class="alert"><fmt:message key="bootstrap.list.message.new" /></div>
			</c:when>
			<%-- <c:when test="${empty collectorParam}">
				<div class="alert"><fmt:message key="bootstrap.list.message.edit" /></div>
			</c:when> --%>
			<c:otherwise>

				<c:if test="${not cms.element.settings.hidetitle}">
					<div class="headline headline-md"><h3 ${rdfa.Title}><c:out value="${con.value.Title}" escapeXml="false" /></h3></div>
				</c:if>			

				<div class="posts lists blog-item margin-bottom-20">
					
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
								<c:set var="paragraph" value="${content.value.Paragraph}" />
								<c:set var="headline">${content.value.Title}</c:set>
								<c:if test="${paragraph.value.Headline.isSet}"><c:set var="headline">${paragraph.value.Headline}</c:set></c:if>
								<!-- entry -->
								<dl class="dl-horizontal entry">
								<dt>
									<c:set var="imageExist" value="false"/>
									<c:if test="${paragraph.value.Image.exists}">
										<c:set var="imageExist" value="true"/>
										<a href="<cms:link>${content.file.rootPath}</cms:link>">
										<cms:img src="${paragraph.value.Image.value.Image}" alt="${paragraph.value.Image.value.Title}" width="50" scaleColor="transparent" scaleType="0"/>
										</a>
									</c:if>
								</dt>
								<dd<c:if test="${!imageExist}"> class="noImg"</c:if>>
									<a href="<cms:link>${content.file.rootPath}</cms:link>">
										<h4 class="media-heading">
											${headline}
											<a href="<cms:link>%(link.weak:/demo/user-content-list/edit-post/)</cms:link>?fileId=${content.id}&backLinkSuccess=${cms.requestContext.uri}&backLinkCancel=${cms.requestContext.uri}">
												<button type="button"
														class="btn btn-default bs-post-edit pull-right glyphicon glyphicon-edit"></button>
											</a>
										</h4>
										<%-- <p><i><small><fmt:formatDate value="${cms:convertDate(content.value.Date)}" dateStyle="LONG" type="DATE" /></small></i></p> --%>
										<p>${cms:trimToSize(cms:stripHtml(paragraph.value.Text), wordCount)}</p>
									</a>
								</dd>
								</dl>
								<!-- // END entry -->

							</cms:contentload>
						</c:if>
					</cms:contentload>
	<%--
					<c:if test="${con.value.Link.exists}">
						<p><a class="btn-u btn-u-small" href="<cms:link>${con.value.Link.value.URI}</cms:link>">${con.value.Link.value.Text}</a></p>
					</c:if>		
	--%>				
				</div>

			</c:otherwise>
		</c:choose>

	</div>
		<%--
		<div <c:if test="${cms.container.type != 'content'}">class="row"</c:if>>

		<div class="headline headline-md">
			<h3><c:out value="${con.value.Title}" escapeXml="false" /></h3>
			--%><%-- <a type="button" 
				class="btn btn-default bs-post-new pull-right glyphicon glyphicon-edit"
				href="<cms:link>/demo/feedback/post-form/</cms:link>?backLink=${cms.requestContext.uri}"
			></a> --%><%--
		</div>
		
		<div class="posts lists blog-item margin-bottom-20">
			
			--%><%-- Get path where to load / store content --%><%--
			<c:set var="ugcConfigFile" value="${con.value.UgcConfig}" />
			<cms:contentload collector="singleFile" param="${ugcConfigFile}">
				<cms:contentaccess var="config" />
				<c:set var="ugcConfigPath">${config.value.ContentPath}</c:set>
			</cms:contentload>
			
			<cms:contentload collector="allInFolder" param="${ugcConfigPath}|bs-post" preload="true" >
				<cms:contentinfo var="info" />
				<c:choose>
					<c:when test="${info.resultSize > 0}">
						<cms:contentload>
							<cms:contentaccess var="content" />
							<c:set var="value" value="${content.value}" />
							<%@include file="%(link.strong:/system/modules/com.alkacon.bootstrap.formatters/elements/post-element.jsp:635c89d1-da73-11e3-9c6c-c11cc2af282b)" %>
						</cms:contentload>
					</c:when>
					<c:otherwise><h2>No posts present.</h2></c:otherwise>
				</c:choose>
			</cms:contentload>
		</div>
	</div>--%>
</cms:formatter>
</cms:bundle>
