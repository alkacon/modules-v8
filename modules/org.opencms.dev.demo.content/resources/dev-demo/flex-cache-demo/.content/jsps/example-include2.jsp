<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"  %>
<div>
	<blockquote>
	<h3>File: example-include2.jsp</h3>
	
	<p>The Date is <b><%= new java.util.Date() %></b></p>
	
	<h3>Cache properties: <cms:property name="cache" file="this" default="(caching not set)"/></h3>
	   
	<p>((tagtest_include.jsp[[</p><p><cms:include file="example-include2a.jsp"/></p>]]tagtest_include.jsp))</p>
	
	</blockquote>
</div>
