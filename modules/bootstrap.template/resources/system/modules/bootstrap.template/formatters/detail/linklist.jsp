<%@page buffer="none" session="false" taglibs="c,cms"%><%--
--%><cms:formatter var="content" val="value" rdfa="rdfa">
      <div class="adediv"><%--
--%><c:if test="${'true' eq value.ShowTitle}"><h4 ${rdfa.Title}>${value.Title}</h4></c:if><%--
--%><c:if test="${not empty content.valueList.Links}">
        <ul><%--
--%><c:set var="isFirstElement" value="true"/><c:forEach items="${content.valueList.Links}" var="link"><%--
--%><c:choose><%--
--%><c:when test="${isFirstElement}">
          <li class="last"><a title="${link.value.TitleAttribute}" href="<cms:link>${link.value.LinkTarget}</cms:link>">${link.value.LinkText}</a></li><%--
--%><c:set var="isFirstElement" value="false"/><%--
--%></c:when><%--
--%><c:otherwise>
          <li><a title="${link.value.TitleAttribute}" href="<cms:link>${link.value.LinkTarget}</cms:link>">${link.value.LinkText}</a></li><%--
--%></c:otherwise><%--
--%></c:choose><%--
--%></c:forEach>
        </ul><%--
--%></c:if>
      </div><%--
--%></cms:formatter>
    