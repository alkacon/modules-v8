<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<div class="row">
	<div class="col-md-12">

		<div class="headline">
            <h4>Your installed OpenCms version is: <cms:info property="opencms.version" /></h4>
        </div>

		<p class="text-info">
            Running on 
			<cms:info property="java.vm.vendor" /> 
			<cms:info property="java.vm.name" /> 
			<cms:info property="java.vm.version" /> 
			<cms:info property="java.vm.info" /> with
			<cms:info property="os.name" /> 
			<cms:info property="os.version" /> 
			(<cms:info property="os.arch" />)
		</p>

		<div class="row">
			<div class="col-md-6">
				<div class="alert alert-success">
        			<p><strong>To login to the OpenCms workplace, point your browser to the following URL:</strong></p>
        			<p><a href="<cms:link>/system/login/</cms:link>" target="_blank"><cms:link>/system/login/</cms:link></a></p>
        		</div>
			</div>

			<div class="col-md-6">
				<div class="alert alert-info pull-right">
					<p><strong>Use the following account information for your first login:</strong></p>
					<p>
						Username: <tt>Admin</tt><br/>
						Password: <tt>admin</tt>
					</p>
				</div>
			</div>
		</div>

		<p class="text-danger">
			<strong>Important:</strong> You should change this default password immediately,
			before someone else does it for you.
		</p>

	</div>
</div>