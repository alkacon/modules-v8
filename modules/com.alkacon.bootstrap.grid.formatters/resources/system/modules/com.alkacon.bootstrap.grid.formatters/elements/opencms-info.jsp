<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>

<div class="row ">
	<div class="col-md-12">
        <div class="servive-block servive-block-colored servive-block-default">
            <div>
                <i class="icon-4x fa fa-info-circle"></i>
            </div>
			
			<h2>You have installed OpenCms <cms:info property="opencms.version" /></h2>

    		<p>
                Running on 
    			<cms:info property="java.vm.vendor" /> 
    			<cms:info property="java.vm.name" /> 
    			<cms:info property="java.vm.version" /> 
    			<cms:info property="java.vm.info" /> with
    			<cms:info property="os.name" /> 
    			<cms:info property="os.version" /> 
    			(<cms:info property="os.arch" />)
    		</p>
        </div>
	</div>
</div>