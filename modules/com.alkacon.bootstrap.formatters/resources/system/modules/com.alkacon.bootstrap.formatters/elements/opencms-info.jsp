<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>

<div class="row servive-block">
	<div class="col-md-12">
        <div class="servive-block-in">
            <div>
                <i class="icon-info-sign"></i>
            </div>
			
			<h4>You have installed OpenCms <cms:info property="opencms.version" /></h4>

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