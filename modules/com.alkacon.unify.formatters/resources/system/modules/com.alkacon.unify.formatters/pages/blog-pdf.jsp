<%@page trimDirectiveWhitespaces="true" buffer="none" session="false" taglibs="c,cms,fmt,fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict //EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<cms:contentload collector="singleFile" param="%(opencms.uri)" >
<cms:contentaccess var="content" />
<head>
<title>${content.value.Title}</title>
<link rel="stylesheet" href="<cms:link>/system/modules/com.alkacon.bootstrap.basics/resources/bootstrap/css/bootstrap.min.css</cms:link>" type="text/css" />
<link rel="stylesheet" href="<cms:link>/system/modules/com.alkacon.bootstrap.formatters/resources/css/page.css</cms:link>" type="text/css" />		 	
</head>
<body>
<div class="blog-page">
    <c:set var="author" value="${fn:trim(content.value.Author)}" />
  
    <div class="pull-right">
        <cms:img src="/sites/default/.galleries/slider/opencms_logo.png" scaleColor="transparent" width="300" scaleType="0" />
    </div>
    
	<div class="margin-top-10">
        <h2>${content.value.Title}</h2>  
        <c:if test="${author ne ''}">
        	<div class="margin-top-5"><i>By ${author}</i></div>
        </c:if> 
        <div>        
            <small><fmt:formatDate value="${cms:convertDate(content.value.Date)}" dateStyle="LONG" timeStyle="SHORT" type="both" /></small>
        </div>
    </div>
    
 	<c:if test="${fn:length(content.valueList.Category) > 0}">
	<div class="margin-top-10">
        <ul class="list-unstyled list-inline blog-tags">
            <li>
            <c:forEach var="item" items="${fn:split(content.value.Category,',')}" varStatus="status">
                <span class="label">${cms.vfs.property[item]['Title']}</span>
                <c:if test="${not status.last}"> </c:if>
            </c:forEach>
            </li>
        </ul>
    </div>
  	</c:if>	
</div>


<c:forEach var="paragraph" items="${content.valueList.Paragraph}" varStatus="status">
    <div class="paragraph margin-top-20">

        <c:set var="imgalign">noimage</c:set>
        <c:if test="${paragraph.value.Image.exists}">
            <c:set var="imgalign">left</c:set>
        </c:if>

        <c:if test="${paragraph.value.Headline.isSet}">
            <div class="headline"><h4>${paragraph.value.Headline}</h4></div>
        </c:if>

        <c:choose>

            <c:when test="${imgalign == 'noimage'}">
                <div>${paragraph.value.Text}</div>       
                <c:if test="${paragraph.value.Link.exists}">
                    <p><a class="btn-u btn-u-small" href="<cms:link>${paragraph.value.Link.value.URI}</cms:link>">${paragraph.value.Link.value.Text}</a></p>
                </c:if>
            </c:when>

            <c:when test="${imgalign == 'left'}">       
                <div>
                    <cms:img src="${paragraph.value.Image.value.Image}" scaleColor="transparent" width="400" scaleType="0" />
                </div>       
                <div class="margin-top-20">
                    ${paragraph.value.Text}
                </div>                  
                <c:if test="${paragraph.value.Link.exists}">
                    <button type="button" class="btn btn-danger">
                        <a href="<cms:link>${paragraph.value.Link.value.URI}</cms:link>">${paragraph.value.Link.value.Text}</a>
                    </button>
                </c:if>
            </c:when>

        </c:choose> 

    </div>
</c:forEach>

</cms:contentload>
</body>
</html>