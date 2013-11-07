<%@page buffer="none" session="false" taglibs="cms,c,fn" %>
<cms:navigation type="forFolder" startLevel="2" var="nav"/>
<div class="margin-bottom-30">
	<div class="headline">
		<h3>A simple sample navigation</h3>
	</div>
	<div>
		<p>Cache properties: <b><cms:property name="cache" file="this" /></b></p>
		<ul>
		<c:forEach items="${nav.items}" var="elem">
			<li><a href="<cms:link>${elem.resourceName}</cms:link>">${elem.navText}</a></li>
		</c:forEach>
		</ul>
	</div>
</div>
