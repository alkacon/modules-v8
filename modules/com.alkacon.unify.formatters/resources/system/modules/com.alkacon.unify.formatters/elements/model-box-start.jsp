<c:if test="${modelGroupElement}">
<div class="oc-modelinfo">
<div class="row">
    <div class="col-xs-12">
        <div class="alert alert-info" role="alert">
			<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			<strong>Model:</strong> <em>${content.value.Title}</em><br>
			<strong>Resource:</strong> ${content.filename}
        </div>
    </div>
</div>
</c:if>