<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.bootstrap.schemas.row">
<cms:formatter var="content" val="value">

    <c:set var="detailOnlyAttr" value="false" />
    <c:if test="${value.DetailOnly.exists}">
			<c:set var="detailOnlyAttr">${value.DetailOnly}</c:set> 
		</c:if>
    <c:set var="rowClass" value="" />
    <c:if test="${cms.element.setting.createrow.value == 'true'}"><c:set var="rowClass" value="row" /></c:if>
    <c:if test="${cms.element.setting.marginbottom.value != '0'}"><c:set var="rowClass">${rowClass} margin-bottom-${cms.element.setting.marginbottom.value}</c:set></c:if>
		<div <c:if test="${detailOnlyAttr == 'false' or (detailOnlyAttr == 'true' and cms.detailRequest)}">class="${rowClass}"</c:if>>
    
    <c:if test="${cms.isEditMode and detailOnlyAttr == 'true' and not cms.detailRequest}">
      <div class="alert alert-warning fade in">
				<h4><fmt:message key="bootstrap.row.headline.detailonlycontainer"/></h4>           
			</div>
    </c:if>
    
			<c:forEach var="column" items="${content.valueList.Column}">

				<c:set var="detailAttr" value="false" />
        
        <c:set var="bssClass" value="" />
				<c:set var="spacer" value="" />
				<c:if test="${cms.element.setting.createrow.value == 'true'}">
        	<c:if test="${column.value.XS.stringValue != '-'}">
						<c:set var="bssClass">${column.value.XS}</c:set>
						<c:set var="spacer" value=" " />
					</c:if>
					<c:if test="${column.value.SM.stringValue != '-'}">
						<c:set var="bssClass">${bssClass}${spacer}${column.value.SM}</c:set>
						<c:set var="spacer" value=" " />
					</c:if>
					<c:if test="${column.value.MD.stringValue != '-'}">
						<c:set var="bssClass">${bssClass}${spacer}${column.value.MD}</c:set>
						<c:set var="spacer" value=" " />
					</c:if>
					<c:if test="${column.value.LG.stringValue != '-'}">
						<c:set var="bssClass">${bssClass}${spacer}${column.value.LG}</c:set>
						<c:set var="spacer" value=" " />
					</c:if>
        </c:if>

				<c:if test="${column.value.Detail.exists}">
					<c:set var="detailAttr">${column.value.Detail}</c:set> 
				</c:if>

				<c:choose>
          <c:when test="${column.value.Count.stringValue == '0'}">
            <div class="${bssClass}"></div>
          </c:when>
          <c:otherwise>
            <cms:container name="${column.value.Name}" type="${column.value.Type}" tagClass="${bssClass}" maxElements="${column.value.Count}" detailview="${detailAttr}" detailonly="${detailOnlyAttr}" editableby="${column.value.Editors}">
                <div class="alert alert-info fade in">
    						<h4><fmt:message key="bootstrap.row.headline.emptycontainer"/></h4>
                <p>${column.value.EmptyText}</p>           
    					</div>                  
    				</cms:container>
          </c:otherwise>
        </c:choose>
					

			</c:forEach>
		</div>

</cms:formatter>
</cms:bundle>