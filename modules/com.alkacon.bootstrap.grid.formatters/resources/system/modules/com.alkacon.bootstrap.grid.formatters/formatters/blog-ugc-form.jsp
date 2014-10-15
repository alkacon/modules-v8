<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<cms:formatter var="content">
<div>
<c:choose>

<c:when test="${cms.element.inMemoryOnly}">
    <h2>New form element has been created</h2>
    <h3>Please edit the form configuration</h3>
</c:when>

<c:when test="${cms.edited}">
    <h2>The form configuration was edited</h2>
    <h3>This page will automatically reload.</h3>
    ${cms.enableReload}
</c:when>
    
<c:otherwise>
    <cms:ugc var="ugcId" editId="${param.fileId}" configPath="${content.filename}" />
    <div id="postFormLoading" style="display: none"></div>
    <form 
        id="ugcForm" 
        ugc-id="${ugcId}" 
        back-link="${cms.typeDetailPage['bsg-blog']}"
        method="post" 
        role="form">
        
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
        <!-- Option to remove an image, will be displayed only if an image is available -->
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
</c:otherwise>

</c:choose>
</div>
</cms:formatter>