<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<cms:formatter var="content">
	<div>
		<c:choose>
			<c:when test="${cms.element.inMemoryOnly}">
				<h2>Please edit the content.</h2>
			</c:when>
			<c:when test="${cms.edited}">
				<h2>Please reload the page.</h2>
			</c:when>
			<c:when test="${empty param.action}">
				<c:choose>
					<c:when test="${empty param.fileId}">
						<cms:ugc var="sessionId"
							configPath="${content.filename}" />
					</c:when>
					<c:otherwise>
						<cms:ugc var="sessionId" editId="${param.fileId}"
							configPath="${content.filename}" />
					</c:otherwise>
				</c:choose>
				<div id="postFormLoading"></div>
				<c:set var="backLinkSuccess">
					<c:choose>
						<c:when test="${empty param.backLinkSuccess}">
							<cms:link>${cms.requestContext.uri}</cms:link>?action=successMessage</c:when>
						<c:otherwise>
							<cms:link>${param.backLinkSuccess}</cms:link>
						</c:otherwise>
					</c:choose>
				</c:set>
				<c:set var="backLinkCancel">
					<c:choose>
						<c:when test="${empty param.backLinkCancel}">
							<cms:link>${cms.requestContext.uri}</cms:link>?action=cancelMessage</c:when>
						<c:otherwise>
							<cms:link>${param.backLinkCancel}</cms:link>
						</c:otherwise>
					</c:choose>
				</c:set>
				<form role="form" id="ugcForm" session-id="${sessionId}"
					back-link-success="${backLinkSuccess}"
					back-link-cancel="${backLinkCancel}" method="post">
					<div class="form-group">
						<label for="headline">Headline</label> <input type="text"
							class="form-control" name="headline">
					</div>
					<div class="form-group">
						<label for="text">Text</label>
						<textarea class="form-control" rows="5" name="text"></textarea>
					</div>
					<div class="form-group">
						<label for="imagefile">Image</label> <input type="file"
							name="imagefile" id="imagefile">
					</div>
					<div class="form-group">
						<label for="imagetitle">Image Title</label> <input
							class="form-control" type="text" name="imagetitle">
					</div>
					<div class="form-group">
						<label for="imagedescription">Image Description</label> <input
							class="form-control" type="text" name="imagedescription">
					</div>
					<div class="checkbox">
						<label> <input type="checkbox" name="imageremove">Remove
							current image
						</label>
					</div>
					<div class="form-group">
						<label for="author">Author</label> <input type="text"
							class="form-control" name="author">
					</div>
					<div class="form-group">
						<label for="authormail">Email</label> <input type="email"
							class="form-control" name="authormail">
					</div>
					<div class="form-group">
						<label for="webpageurl">Webpage URL</label> <input type="text"
							class="form-control" name="webpageurl">
					</div>
					<div class="form-group">
						<label for="webpagenice">Webpage nicename</label> <input
							type="text" class="form-control" name="webpagenice">
					</div>
					<input type="submit" style="display: none;">
					<div class="form-group">
						<button id="saveButton" type="button" class="btn btn-success">Save</button>
						<button id="validateButton" type="button" class="btn btn-primary">Validate</button>
						<button id="cancelButton" type="button" class="btn btn-default">Cancel</button>
					</div>
				</form>
			</c:when>
			<c:when test="${param.action == 'cancelMessage'}">
				<h2>Form was not saved.</h2>
			</c:when>
			<c:when test="${param.action == 'successMessage'}">
				<h2>Form was successfully committed!</h2>
			</c:when>
			<c:otherwise>
				<h2>Invalid action parameter.</h2>
			</c:otherwise>
		</c:choose>
	</div>
</cms:formatter>