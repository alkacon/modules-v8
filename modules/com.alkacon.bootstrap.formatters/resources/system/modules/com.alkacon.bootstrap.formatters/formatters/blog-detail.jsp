<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.bootstrap.schemas.blog">

<cms:formatter var="content" val="value" rdfa="rdfa">

<div <c:if test="${cms.container.type != 'content'}"> class="row"</c:if>>
    <%-- create author link --%>
    <c:set var="author" value="${fn:trim(value.Author)}" />
    <c:choose>
        <c:when test="${fn:length(author) > 3 && value.AuthorMail.exists}">
            <c:set var="author"><a href="mailto:${value.AuthorMail}" title="${author}">${author}</a></c:set>
        </c:when>
        <c:when test="${fn:length(author) > 3}">
            <c:set var="author">${author}</c:set>
        </c:when>
        <c:when test="${value.AuthorMail.exists}">
            <c:set var="author"><a href="mailto:${value.AuthorMail}" title="${value.AuthorMail}">${value.AuthorMail}</a></c:set>
        </c:when><c:otherwise><c:set var="author" value=""></c:set></c:otherwise>
    </c:choose>
    <%-- //END create author link --%>
    <!-- blog header -->
    <div class="blog-page">
        <div class="blog">
            <h2 ${rdfa.Title}>${value.Title}</h2>                             
            <ul class="list-unstyled list-inline blog-info">
                <li><i class="icon-calendar"></i> <fmt:formatDate value="${cms:convertDate(value.Date)}" dateStyle="SHORT" timeStyle="SHORT" type="both" /></li>
                <c:if test="${author ne ''}">
                <li><i class="icon-pencil"></i> ${author}</li>
                </c:if>
            </ul>
            <c:if test="${fn:length(content.valueList.Category) > 0}">
            <ul class="list-unstyled list-inline blog-tags">
                <li>
                    <i class="icon-tags"></i>
                    <c:forEach var="item" items="${fn:split(content.value.Category,',')}" varStatus="status">
                        <a href="#">${cms.vfs.property[item]['Title']}</a>
                    </c:forEach>
                </li>
            </ul>
            </c:if>
        </div>
    </div><!-- //END blog header -->

    <!-- paragraphs -->
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
                        <c:if test="${paragraph.value.Link.exists}">
                            <p><a class="btn-u btn-u-small" href="<cms:link>${paragraph.value.Link.value.URI}</cms:link>">${paragraph.value.Link.value.Text}</a></p>
                        </c:if>     
                    </div>
                </div>      
            </c:when>

            <c:when test="${imgalign == 'right'}">
                <div class="row-fluid">
                    <div class="col-md-8">
                        <div ${paragraph.rdfa.Text}>${paragraph.value.Text}</div>       
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

    </c:forEach><!-- //END paragraphs -->
    
    <c:if test="${content.isEditable}">
    <a href="<cms:link>%(link.weak:/demo/blog-entries/post-a-new-blog-entry/)</cms:link>?fileId=${content.id}">
        <button type="button" class="btn btn-default">Edit this blog entry</button>
    </a>
    </c:if>    
</div>
</cms:formatter>
</cms:bundle> 