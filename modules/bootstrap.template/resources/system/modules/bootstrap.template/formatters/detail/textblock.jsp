<%@page buffer="none" session="false" taglibs="c,cms,fmt,fn"%><%--
--%><fmt:setLocale value="${cms.locale}" /><%--
--%><fmt:bundle basename="bootstrap.schemas.workplace"><%--
--%><cms:formatter var="content" val="value" rdfa="rdfa">
      <div class="adediv"><%--
--%><c:choose><%--
  --%><c:when test="${cms.element.inMemoryOnly || fn:length(content.subValueList['Choice']) < 1}">
        <h3><fmt:message key="textblock.message.edit" /></h3><%--
  --%></c:when><%--
  --%><c:otherwise><%--
    --%><c:forEach var="element" items="${content.subValueList['Choice']}"><%--
      --%><c:choose><%--
        --%><c:when test="${element.name == 'Paragraph'}">
        <h${element.value.HeadlineLevel} ${element.rdfa.Headline}>${element.value.Headline}</h${element.value.HeadlineLevel}>
        <div ${element.rdfa.Text}>
          ${element.value.Text}
        </div><%--
        --%></c:when><%--
        --%><c:when test="${element.name == 'Quote'}">
        <h3 ${element.rdfa.Headline}>${element.value.Headline}</h3>
        <blockquote><p ${element.rdfa.Quote}>${element.value.Quote}</p></blockquote>
        <div ${element.rdfa.Text}>${element.value.Text}</div><%--
        --%></c:when><%--
        --%><c:when test="${element.name == 'List'}"><%--
          --%><c:if test="${fn:length(element.valueList['Entry']) > 0}">
        <h3 ${element.rdfa.Headline}>${element.value.Headline}</h3><%--
            --%><c:choose><%--
              --%><c:when test="${element.value.Numbered eq 'true'}">
        <ol><%--
                --%><c:forEach var="entry" items="${element.valueList['Entry']}">
          <li ${entry.rdfaAttr}>${entry}</li><%--
                --%></c:forEach>
        </ol><%--
              --%></c:when><%--
              --%><c:otherwise>
        <ul><%--
                --%><c:forEach var="entry" items="${element.valueList['Entry']}">
          <li ${entry.rdfaAttr}>${entry}</li><%--
                --%></c:forEach>
        </ul><%--
              --%></c:otherwise><%--
            --%></c:choose><%--
          --%></c:if><%--
        --%></c:when><%--
        --%><c:otherwise>
        <h3><fmt:message key="textblock.message.edit" /></h3><%--
        --%></c:otherwise><%--
      --%></c:choose><%--
    --%></c:forEach><%--
  --%></c:otherwise><%--
--%></c:choose>
      </div><%--
--%></cms:formatter><%--
--%></fmt:bundle>
    