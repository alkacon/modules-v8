<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.bootstrap.schemas.row">
<cms:formatter var="content" val="value">

<c:if test="${cms.element.setting.createcontainerandrow.value == 'true'}">
    <div class="<c:if test="${cms.element.setting.addcontentclass.value == 'true'}">content </c:if>container<c:if test="${cms.element.setting.full.value == 'true'}">-fluid</c:if>">
    <div class="row">   
</c:if>

<c:forEach var="column" items="${content.valueList.Column}">

    <c:set var="detailAttr" value="false" />
    <c:set var="bssClass" value="" />
    <c:set var="spacer" value="" />
    <c:if test="${cms.element.setting.createcontainerandrow.value == 'true'}">
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
    <c:if test="${column.value.Modifier.isSet and cms.element.setting.usemodifier.value == 'true'}">
        <c:set var="bssClass">${column.value.Modifier}</c:set>
    </c:if>

    <c:if test="${column.value.Detail.exists}">
        <c:set var="detailAttr">${column.value.Detail}</c:set> 
    </c:if>
    
    <c:set var="alert" value="" />
    <c:if test="${column.value.Editors == 'ROLE.EDITOR'}">
        <c:set var="alert"><span> </span><span class="label rounded label-warning"><fmt:message key="bootstrap.row.restricted"/></span></c:set>
    </c:if>    
    <c:if test="${column.value.Editors == 'ROLE.DEVELOPER'}">
        <c:set var="alert"><span> </span><span class="label rounded label-danger"><fmt:message key="bootstrap.row.restricted"/></span></c:set>
    </c:if>          

    <cms:container 
        name="${column.value.Name}" 
        type="${column.value.Type}" 
        tagClass="${bssClass}" 
        maxElements="${column.value.Count}" 
        detailview="${detailAttr}" 
        editableby="${column.value.Editors}"
        param="${column.value.Editors}">
        
    <div class="service-block rounded-3x service-block-dark-blue">
        <h2 class="heading-md"><fmt:message key="bootstrap.row.headline.emptycontainer"/>  ${alert}</h2>
        <p>${column.value.EmptyText}</p>          
    </div>                  
    </cms:container>

</c:forEach>
            
<c:if test="${cms.element.setting.createcontainerandrow.value == 'true'}">
    </div>
    </div>
</c:if>

</cms:formatter>
</cms:bundle>