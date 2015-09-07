<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.unify.schemas.row">
<cms:formatter var="content" val="value">
<c:choose>
	<c:when test="${!content.value.Container.isSet || (content.value.Container.isSet && fn:containsIgnoreCase(cms.container.type, content.value.Container))}">
	
		<c:set var="resTypeName" value="u-templaterow" /> 
		<c:set var="modelGroupElement" value="${cms.modelGroupElement}" />
		
		<%@include file="%(link.strong:/system/modules/com.alkacon.unify.formatters/elements/model-box-start.jsp:704c8ef8-5243-11e5-9495-0242ac11002b)" %>
		
		<c:if test="${content.value.PreMarkup.isSet}">
			<c:set var="preMarkup" value="${fn:replace(content.value.PreMarkup, '$(param)', cms.element.setting.param.value)}" />
			<c:set var="link" value="" />
			<c:if test="${cms.element.setting.link.isSet}">
					<c:set var="link"><cms:link>${cms.element.setting.link}</cms:link></c:set>
			</c:if>	
			${fn:replace(preMarkup, '$(link)', link)}
		</c:if>
		<c:forEach var="column" items="${content.valueList.Column}">
		
			<c:set var="role" value="${column.value.Editors.isSet ? column.value.Editors : (content.value.Defaults.isSet ? content.value.Defaults.value.Editors : 'ROLE.DEVELOPER')}" />
			<c:set var="typeName" value="${column.value.Type.isSet ? column.value.Type : (content.value.Defaults.isSet ? content.value.Defaults.value.Type : 'unknown')}" />
		
			<c:if test="${column.value.PreMarkup.isSet}">${column.value.PreMarkup}</c:if>
			
			<cms:container 
				name="${column.value.Name}" 
				type="${typeName}" 
				tagClass="${column.value.Grid.isSet ? column.value.Grid : (content.value.Defaults.isSet ? content.value.Defaults.value.Grid : '')}" 
				maxElements="${column.value.Count.isSet ? column.value.Count : (content.value.Defaults.isSet ? content.value.Defaults.value.Count : '50')}" 
				editableby="${role}"
				param="${role}">
			  
				<%@include file="%(link.strong:/system/modules/com.alkacon.unify.formatters/elements/container-box.jsp:49d1a304-5243-11e5-9495-0242ac11002b)" %>
			  
			</cms:container>
		
			<c:if test="${column.value.PostMarkup.isSet}">${column.value.PostMarkup}</c:if>
			
		</c:forEach>
		
		<c:if test="${content.value.PostMarkup.isSet}">  
		${content.value.PostMarkup}
		</c:if>
		
		<%@include file="%(link.strong:/system/modules/com.alkacon.unify.formatters/elements/model-box-end.jsp:8550f5cc-5243-11e5-9495-0242ac11002b)" %>
	
	</c:when>
	<c:otherwise>
		<%-- Required Container does not match, don't generate output --%>
	</c:otherwise>
</c:choose>
</cms:formatter>
</cms:bundle>