<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.bootstrap.grid.schemas.row">
<cms:formatter var="content" val="value">

		<div <c:if test="${cms.element.setting.createrow.value == 'true'}">class="row"</c:if>>
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

				<cms:container name="${column.value.Name}" type="${column.value.Type}" tagClass="${bssClass}" maxElements="${column.value.Count}" detailview="${detailAttr}" editableby="${column.value.Editors}">
					<div class="alert alert-info fade in">
						<h4><fmt:message key="bootstrap.row.headline.emptycontainer"/></h4>
            <p>${column.value.EmptyText}</p>           
					</div>                  
				</cms:container>

			</c:forEach>
		</div>

</cms:formatter>
</cms:bundle>