<%@page buffer="none" session="false" taglibs="c,cms" %>

<%-- The jsp html should be surround by block element --%>
<div>
	<h2>List of resources:</h2>
	
	<%-- Read collector paramter, e.g. from request --%>	
	<c:set var="folder" value="/dev-demo/collector-with-detail-page/.content/article/" />
	<c:if test="${not empty param.folder}"><c:set var="folder" value="${param.folder}" /></c:if>	
	<c:set var="type" value="ddarticle" />
	<c:if test="${not empty param.type}"><c:set var="type" value="${param.type}" /></c:if>
	<c:set var="count" value="5"/>
	<c:if test="${not empty param.count}"><c:set var="count" value="${param.count}" /></c:if>
	
	<div class="paragraph">
		<p>Used collector: <b>myCollector</b></p>
		<p>Collector parameters: [path]|[resource type]|[count]<br/>
		<b>${folder}|${type}|${count}</b></p>
	</div>

	<ul>
	<c:catch var="error" >	
		<%-- Use <cms:contentload> with new collector--%>
		<cms:contentload collector="myCollector" param="${folder}a_%(number).html|${type}|${count}" editable="true">
			<%-- Access the content --%>  
			<cms:contentaccess var="content" />
			<%-- Set the link to the content in the list and do not forgat to use <cms:link> tag --%>
			<li><a href="<cms:link>${content.filename}</cms:link>">${content.value.Title}</a></li>				
		</cms:contentload>	
	</c:catch>
	</ul>
	
	<c:if test="${error != null}">
		<div class="paragraph">
			<p><b>If you call this demo for the first time the collector "myCollector" maybe has not been configured yet.</b></p>
			<p>Edit <b>opencms-vfs.xml</b> and add code line to <tt><collectors></tt> node:</p>	
			<pre>
&lt;collectors&gt;
	...
	&lt;collector class="org.opencms.dev.demo.CmsSimpleResourceCollector" order="180" /&gt;
&lt;/collectors&gt;
        	</pre>
			<p>Restart the servlet container.</p>
		</div>
		<br/>
		${error}
	</c:if>
</div>