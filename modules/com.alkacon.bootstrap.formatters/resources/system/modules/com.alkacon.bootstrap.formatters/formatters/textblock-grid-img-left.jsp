<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<cms:formatter var="content">

<div class="container">

<c:forEach var="paragraph" items="${content.valueList.Paragraph}">

  <c:if test="${paragraph.value.Headline.isSet}">
    <div class="headline"><h2 ${paragraph.rdfa.Headline}>${paragraph.value.Headline}</h2></div>
  </c:if>

  <div class="row margin-bottom-30" ${paragraph.rdfa["Link|Image"]}>
    <c:if test="${paragraph.value.Image.exists}">
      <div class="${cms.element.parent.setting.div1.bs.css}">
			  <div class="thumbnail-kenburn"><div class="overflow-hidden">
			    <cms:img src="${paragraph.value.Image.value.Image}" scaleColor="transparent" width="800" scaleType="0" noDim="true" cssclass="img-responsive" alt="${paragraph.value.Image.value.Title}" title="${paragraph.value.Image.value.Title}" />
				</div></div>
      </div>
		</c:if>
       
    <c:choose>
      <c:when test="${paragraph.value.Image.exists}">
        <div class="${cms.element.parent.setting.div1.bs.restCss}">
      </c:when>
      <c:otherwise>
        <div class="col-xs-12">
      </c:otherwise>
    </c:choose>
		<div ${paragraph.rdfa.Text}>${paragraph.value.Text}</div>		
		<c:if test="${paragraph.value.Link.exists}">
		  <p><a class="btn-u btn-u-small" href="<cms:link>${paragraph.value.Link.value.URI}</cms:link>">${paragraph.value.Link.value.Text}</a></p>
		</c:if>
	  </div>
  </div> 

</c:forEach> 

</div>

</cms:formatter>