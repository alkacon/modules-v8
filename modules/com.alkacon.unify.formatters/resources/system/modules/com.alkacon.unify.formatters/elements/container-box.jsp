<c:set var="label" value="${content.value.Title} - ${column.value.Name}" /> 
<c:set var="parent_role" value="${cms.container.param}" /> 

<c:choose>
    <c:when test="${(role == 'ROLE.DEVELOPER') or (parent_role == 'ROLE.DEVELOPER')}">
        <c:set var="myrole" value="developer" /> 
    </c:when>
    <c:when test="${(role == 'ROLE.EDITOR') or (parent_role == 'ROLE.EDITOR')}">
        <c:set var="myrole" value="editor" /> 
    </c:when>
    <c:otherwise>
        <c:set var="myrole" value="author" /> 
    </c:otherwise>
</c:choose> 

<c:choose>
    <c:when test="${(resTypeName == 'u-templaterow') && (typeName == 'mainsection')}">
        <c:set var="variant" value="jsp" /> 
    </c:when> 
    <c:when test="${(resTypeName == 'u-templaterow') && !(typeName == 'default')}">
        <c:set var="variant" value="template" /> 
    </c:when>    
    <c:otherwise>
        <c:set var="variant" value="layout" /> 
    </c:otherwise>
</c:choose> 

<div class="oc-container-${variant}">
    <h1><fmt:message key="unify.row.headline.emptycontainer"/> 
    <div class="oc-label-${myrole}">${fn:toUpperCase(myrole)}</div><c:if test="${detailView == 'true'}"><div class="oc-label-detail">DETAIL VIEW</div></c:if>
    </h1>
    <p>${label}</p>
</div> 