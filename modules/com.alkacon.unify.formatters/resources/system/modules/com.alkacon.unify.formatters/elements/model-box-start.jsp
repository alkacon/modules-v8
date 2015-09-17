<c:if test="${modelGroupElement}">
	<c:set var="modelTitle">${content.value.Title}</c:set>
	<c:if test="${not empty cms.element.setting.model_group_title}">
		<c:set var="modelTitle">${cms.element.setting.model_group_title}</c:set>
	</c:if>
	<div class="oc-modelinfo">
	<div class="row">
	    <div class="col-xs-12">
	        <div class="alert alert-info" role="alert">
				<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<strong>Model:</strong> <em>${modelTitle}</em><br>
				<strong>Description:</strong> ${cms.element.setting.model_group_description}
	        </div>
	    </div>
	</div>
</c:if>