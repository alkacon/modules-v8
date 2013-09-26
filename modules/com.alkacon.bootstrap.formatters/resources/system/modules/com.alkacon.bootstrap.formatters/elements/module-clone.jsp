<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:useBean id="cloneModule" scope="request" class="org.opencms.workplace.tools.modules.CmsCloneModule">
	<jsp:setProperty name="cloneModule" property="*" />
	<%
	    cloneModule.init(pageContext, request, response);
	%>
</jsp:useBean>
<cms:formatter var="function" rdfa="rdfa">
	<div <c:if test="${cms.container.type == 'content-full'}"> class="row-fluid"</c:if>>
		<div class="headline">
			<h1>${function.value.Title}</h1>
		</div>
		<form class="form-horizontal" method="post" id="clone-module-form">
			<!-- Select a Source Module  -->
			<fieldset>
				<legend>Select a source module</legend>
				<div class="control-group">
					<label class="control-label" for="sourceModuleName">Source Module</label>
					<div class="controls">
						<select class="input-xlarge" id="sourceModuleName" name="sourceModuleName">
							<c:forEach items="${cloneModule.allModuleNames}" var="moduleName">
								<c:choose>
									<c:when test="${moduleName eq cloneModule.sourceModuleName}">
										<option selected>${moduleName}</option>
									</c:when>
									<c:otherwise>
										<option>${moduleName}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</div>
				</div>
				<!-- Option to delete the source module after cloning -->
				<div class="control-group">
					<div class="controls">
						<label class="checkbox" for="deleteModule">
							<input type="checkbox" value="true" 
								<c:if test="${param.deleteModule}">checked</c:if> id="deleteModule" name="deleteModule">
								Select this option if you like to delete the source module after cloning
						</label>
					</div>
				</div>
			</fieldset>
			<!-- Module Information -->
			<fieldset>
				<legend>New module information</legend>
				<!-- Enter new Module package name -->
				<div class="control-group">
					<label class="control-label" for="packageName">Package name</label>
					<div class="controls">
						<input type="text" id="packageName" name="packageName" class="border-radius-none input-xlarge"
							placeholder="Package name" value="${cloneModule.packageName}">
					</div>
				</div>
				<!-- Enter new Module nice name -->
				<div class="control-group">
					<label class="control-label" for="niceName">Module name</label>
					<div class="controls">
						<input type="text" id="niceName" name="niceName" class="border-radius-none input-xlarge"
							placeholder="Module nice name" value="${cloneModule.niceName}">
					</div>
				</div>
				<!-- Enter new Module description -->
				<div class="control-group">
					<label class="control-label" for="description">Module description</label>
					<div class="controls">
						<input type="text" id="description" name="description" class="border-radius-none input-xlarge"
							placeholder="Module description" value="${cloneModule.description}">
					</div>
				</div>
				<!-- Enter new Module Group -->
				<div class="control-group">
					<label class="control-label" for="group">Module Group</label>
					<div class="controls">
						<input type="text" id="group" name="group" class="border-radius-none input-xlarge" placeholder="Module Group"
							value="${cloneModule.group}">
					</div>
				</div>
				<!-- Enter new Action class -->
				<div class="control-group">
					<label class="control-label" for="actionClass">Action class</label>
					<div class="controls">
						<input type="text" id="actionClass" name="actionClass" class="border-radius-none input-xlarge"
							placeholder="Action class" value="${cloneModule.actionClass}">
					</div>
				</div>
			</fieldset>
			<!-- Author information -->
			<fieldset>
				<legend>New author information</legend>
				<!-- Enter new Author name -->
				<div class="control-group">
					<label class="control-label" for="authorName">Author name</label>
					<div class="controls">
						<input type="text" id="authorName" name="authorName" class="border-radius-none input-xlarge"
							placeholder="Author name" value="${cloneModule.authorName}">
					</div>
				</div>
				<!-- Enter new Author email -->
				<div class="control-group">
					<label class="control-label" for="authorEmail">Author email</label>
					<div class="controls">
						<input type="text" id="authorEmail" name="authorEmail" class="border-radius-none input-xlarge"
							placeholder="Author email" value="${cloneModule.authorEmail}">
					</div>
				</div>
			</fieldset>
			<!-- Translation options  -->
			<fieldset>
				<legend>Translation options</legend>
				<!-- Enter a source prefix name -->
				<div class="control-group">
					<label class="control-label" for="sourceNamePrefix">Source prefix name</label>
					<div class="controls">
						<input type="text" id="sourceNamePrefix" name="sourceNamePrefix" class="border-radius-none input-xlarge"
							placeholder="Source prefix name" value="${cloneModule.sourceNamePrefix}">
					</div>
				</div>
				<!-- Enter a target prefix name -->
				<div class="control-group">
					<label class="control-label" for="targetNamePrefix">Target prefix name</label>
					<div class="controls">
						<input type="text" id="targetNamePrefix" name="targetNamePrefix" class="border-radius-none input-xlarge"
							placeholder="Target prefix name" value="${cloneModule.targetNamePrefix}">
					</div>
				</div>
				<!-- Enter a source formatter module -->
				<div class="control-group">
					<label class="control-label" for="formatterSourceModule">Formatters source</label>
					<div class="controls">
						<input type="text" id="formatterSourceModule" name="formatterSourceModule" class="border-radius-none input-xlarge"
							placeholder="Formatters source module name" value="${cloneModule.formatterSourceModule}">
					</div>
				</div>
				<!-- Enter a new formatter path -->
				<div class="control-group">
					<label class="control-label" for="formatterTargetModule">Formatters target</label>
					<div class="controls">
						<input type="text" id="formatterTargetModule" name="formatterTargetModule" class="border-radius-none input-xlarge"
							placeholder="Formatters target module name" value="${cloneModule.formatterTargetModule}">
					</div>
				</div>
				<!-- Option to correct schema locations -->
				<div class="control-group">
					<div class="controls">
						<label class="checkbox" for="changeResourceTypes">
							<input type="checkbox" value="true"
								<c:if test="${param.changeResourceTypes}">checked</c:if> id="changeResourceTypes" name="changeResourceTypes">
								Select this option, if you like to change resource types
						</label>
					</div>
					<div class="controls">
						<label class="checkbox" for="changeResourceTypesEverywhere">
							<input type="checkbox" value="true"
								<c:if test="${param.changeResourceTypesEverywhere}">checked</c:if> id="changeResourceTypesEverywhere" name="changeResourceTypesEverywhere">
								Select this option, if you like to change resource types in all sites
						</label>
					</div>
				</div>
			</fieldset>
			<input type="hidden" name="submit" value="true">
			<div class="control-group">
				<div class="controls">
					<button class="btn-u">Clone module now!</button>
				</div>
			</div>
		</form>
		<div id="wait">
			<h2>Loading ...</h2>
		</div>
		<div id="result">
		</div>
<script>
$('#wait').hide();
$('#result').hide();
$("#clone-module-form").submit(function(event) {
  $('#wait').show();
  $('#clone-module-form').hide();
  var params = $('#clone-module-form').serialize();
  var posting = $.post('<cms:link>/system/modules/com.alkacon.bootstrap.formatters/elements/module-clone-action.jsp</cms:link>?' + params);
  posting.done(function( data ) {
      $('#wait').hide();
      var content = $(data).find("#success");
      $("#result").empty().append(content);
      $('#result').show();
  });
  return false;
  event.preventDefault();
});
</script>
	</div>
</cms:formatter>
