<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
                    <cms:initformsession var="sessionId" configPath="${content.filename}" />
                </c:when>
                <c:otherwise>
                    <cms:initformsession var="sessionId" editId="${param.fileId}" configPath="${content.filename}" />
                </c:otherwise>
            </c:choose>
            <!-- div id="postFormLoading"></div -->
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
                    <label for="title">Title</label> 
                    <input type="text" class="form-control" name="title">
                </div>                    
                <div class="form-group">
                    <label for="text">Text</label>
                    <textarea class="form-control" rows="5" name="text"></textarea>
                </div>
                <div class="form-group">                    
                    <label for="imagefile">Image</label>
                    <span class="btn btn-warning btn-block btn-file">
                        Click here to select a new image for upload...
                        <input type="file" name="imagefile" id="imagefile">
                    </span>
                </div>
                <div id="imageOptions" style="display: none">
                <div class="form-group">
                    <label for="imageuri">Current image</label>
                    <input disabled type="text" class="form-control" name="imageuri">
                </div>
                <div class="checkbox">
                    <label>
                        Remove current image
                        <input type="checkbox" name="imageremove">
                    </label>
                </div>   
                </div>
                <div class="form-group">
                    <label for="imagetitle">Image Title</label>
                    <input class="form-control" type="text" name="imagetitle">
                </div>
                <div class="form-group">
                    <label for="imagedescription">Image Description</label>
                    <input class="form-control" type="text" name="imagedescription">
                </div>
                <div class="form-group">
                    <label for="author">Author name</label>
                    <input type="text" class="form-control" name="author">
                </div>
                <div class="form-group">
                    <label for="authormail">Author email</label>
                    <input type="email" class="form-control" name="authormail">
                </div>
                <div class="form-group">
                    <label for="webpageurl">Link</label> <input type="text"
                        class="form-control" name="webpageurl">
                </div>
                <div class="form-group">
                    <label for="webpagenice">Link description</label> 
                    <input type="text" class="form-control" name="webpagenice">
                </div>
                <input type="submit" style="display: none;">
                <div class="form-group">
                    <div class="row">
                        <div class="col-sm-6">
                            <button id="saveButton" type="button" class="btn btn-block btn-primary">Save</button>
                        </div>
                        <div class="col-sm-3">
                            <button id="validateButton" type="button" class="btn btn-block btn-default">Validate</button>
                        </div>                            
                        <div class="col-sm-3">
                            <button id="cancelButton" type="button" class="btn btn-block btn-default">Cancel</button>
                        </div>
                    </div>
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