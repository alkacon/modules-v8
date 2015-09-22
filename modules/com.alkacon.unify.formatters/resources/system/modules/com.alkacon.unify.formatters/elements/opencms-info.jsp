<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div class="colored-box-light mediumgrey margin-bottom-10">
   
    <div class="float-row">
        <div class="float-col">
            <i class="icon icon-3x fa fa-info-circle"></i>
        </div>
        <div class="float-col">
            <h2 class="heading-lg">
                You have installed <span style="white-space: nowrap;">OpenCms ${cms.systemInfo.versionNumber}
            </h2>
        </div>
    </div>

    <p>
    <c:forEach items="${cms.systemInfo.buildInfo}" var="item" varStatus="loop">
        <c:if test="${loop.count > 1}"><c:out value =" - "/></c:if>
        <span style="white-space: nowrap;">${item.value.niceName}: ${item.value.value}</span>
    </c:forEach>
    </p>
    
    <p>
        Running on 
        <cms:info property="java.vm.vendor" /> 
        <cms:info property="java.vm.name" /> with
        <cms:info property="os.name" /> 
        <cms:info property="os.version" />
    </p>

</div>