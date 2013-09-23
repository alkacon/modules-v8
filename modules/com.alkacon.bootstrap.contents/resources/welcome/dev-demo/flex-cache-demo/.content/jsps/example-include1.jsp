<%@page buffer="none" session="false" taglibs="c,cms,fn" %>

<div>
<blockquote>

<h3>File: example-include1.jsp</h3>

<p>The Date is <b><%= new java.util.Date() %></b></p>

<h3>Cache properties: <cms:property name="cache" file="this" default="(caching not set)"/></h3>
   
<p>((tagtest_include.jsp[[</p><p><cms:include file="%(link.weak:/welcome/dev-demo/flex-cache-demo/.content/jsps/example-include1a.jsp:ac4a0718-b4ad-11e1-b12d-c524a635a326)"/></p>]]tagtest_include.jsp))</p>

</blockquote>

</div>
