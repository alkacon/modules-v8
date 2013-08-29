<%@page buffer="none" session="false" taglibs="cms"%><%--
--%><cms:formatter var="content" val="value" rdfa="rdfa">
      <div class="adediv">
        <h1 ${content.rdfa.Title}>${value.Title}</h1>
      </div><%--
--%></cms:formatter>
    