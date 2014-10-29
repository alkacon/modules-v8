<%@page trimDirectiveWhitespaces="true" buffer="none" session="false" taglibs="c,cms,fmt,fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict //EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<cms:contentload collector="singleFile" param="%(opencms.uri)" >
<cms:contentaccess var="content" />
<head>
<title>${content.value.Title}</title>
<link rel="stylesheet" href="<cms:link>/system/modules/com.alkacon.bootstrap.basics/resources/bootstrap/css/bootstrap.min.css</cms:link>" type="text/css" />
<link rel="stylesheet" href="<cms:link>/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/css/style.css</cms:link>" type="text/css" />	
<link rel="stylesheet" href="<cms:link>/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/css/app.css</cms:link>" type="text/css" />	
<link rel="stylesheet" href="<cms:link>/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/plugins/line-icons/line-icons.css</cms:link>" type="text/css" />	
<link rel="stylesheet" href="<cms:link>/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/plugins/font-awesome/css/font-awesome.css</cms:link>" type="text/css" />			 
<link rel="stylesheet" href="<cms:link>/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/css/themes/red.css</cms:link>" type="text/css" />		  
<link rel="stylesheet" href="<cms:link>/system/modules/com.alkacon.bootstrap.formatters/resources/css/page.css</cms:link>" type="text/css" />		 	
</head>
<body>
<div class="blog-page">
    <%-- create author link --%>
    <c:set var="author" value="${fn:trim(content.value.Author)}" />
    <c:choose>
        <c:when test="${fn:length(author) > 3 && content.value.AuthorMail.exists}">
            <c:set var="author"><a href="mailto:${content.value.AuthorMail}" title="${author}">${author}</a></c:set>
        </c:when>
        <c:when test="${fn:length(author) > 3}">
            <c:set var="author">${author}</c:set>
        </c:when>
        <c:when test="${content.value.AuthorMail.exists}">
            <c:set var="author"><a href="mailto:${content.value.AuthorMail}" title="${content.value.AuthorMail}">${content.value.AuthorMail}</a></c:set>
        </c:when><c:otherwise><c:set var="author" value=""></c:set></c:otherwise>
    </c:choose>

	<div class="blog">
	<h2>${content.value.Title}</h2>  
	<ul class="list-unstyled list-inline  blog-tags">
    	<li><fmt:formatDate value="${cms:convertDate(content.value.Date)}" dateStyle="SHORT" timeStyle="SHORT" type="both" /></li>
        <c:if test="${author ne ''}">
        	<li>${author}</li>
         </c:if>
    </ul>
 	<c:if test="${fn:length(content.valueList.Category) > 0}">
   		<ul class="list-unstyled list-inline blog-tags">
    		<li>
        	<c:forEach var="item" items="${fn:split(content.value.Category,',')}" varStatus="status">
            	${cms.vfs.property[item]['Title']}
				<c:if test="${not status.last}">, </c:if>
            </c:forEach>
          	</li>
    	</ul>
  	</c:if>	
  </div>
</div>


  <!-- paragraphs -->
    <c:forEach var="paragraph" items="${content.valueList.Paragraph}" varStatus="status">

    <div class="paragraph margin-bottom-20">

        <c:set var="imgalign">noimage</c:set>
        <c:if test="${paragraph.value.Image.exists}">
            <c:set var="imgalign">left</c:set>
        </c:if>

        <c:if test="${paragraph.value.Headline.isSet}">
            <div class="headline"><h4>${paragraph.value.Headline}</h4></div>
        </c:if>

        <c:choose>

            <c:when test="${imgalign == 'noimage'}">
                <span></span>
                <div>${paragraph.value.Text}</div>       
                <c:if test="${paragraph.value.Link.exists}">
                    <p><a class="btn-u btn-u-small" href="<cms:link>${paragraph.value.Link.value.URI}</cms:link>">${paragraph.value.Link.value.Text}</a></p>
                </c:if>
            </c:when>

            <c:when test="${imgalign == 'left'}">       
                <div class="row">
                    <div class="col-md-4">
                        <div class="thumbnail-kenburn"><div class="overflow-hidden">
                            <cms:img src="${paragraph.value.Image.value.Image}" scaleColor="transparent" width="400" scaleType="0" cssclass="img-responsive" alt="${paragraph.value.Image.value.Title}" title="${paragraph.value.Image.value.Title}" />
                        </div></div>        
                    </div>
                    <div class="col-md-8">
                        <div>${paragraph.value.Text}</div>       
                        <c:if test="${paragraph.value.Link.exists}">
                            <p><a class="btn-u btn-u-small" href="<cms:link>${paragraph.value.Link.value.URI}</cms:link>">${paragraph.value.Link.value.Text}</a></p>
                        </c:if>     
                    </div>
                </div>      
            </c:when>

          
        </c:choose> 

    </div>
  </c:forEach><!-- //END paragraphs -->



</cms:contentload>
</body>
</html>