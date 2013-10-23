<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<div class="row">
	<div class="col-md-12">
		<div class="headline">
			<h3>Congratulations!</h3>
		</div>

		<h4>You have setup OpenCms successfully.</h4>

		<p class="text-info">
			Your installed OpenCms version is: <cms:info property="opencms.version" /><br/>
			<small>Running on 
			<cms:info property="java.vm.vendor" /> 
			<cms:info property="java.vm.name" /> 
			<cms:info property="java.vm.version" /> 
			<cms:info property="java.vm.info" /> with
			<cms:info property="os.name" /> 
			<cms:info property="os.version" /> 
			(<cms:info property="os.arch" />)</small>
		</p>

		<p>
			As you may have guessed by now, this is the default OpenCms home page. 
			It can <em>not</em> be found on the local file system ;-) but in the OpenCms
			<em>virtual file system</em> or VFS, which is served from the connected database.
			You can access the VFS though the OpenCms workplace.
		</p>

		<div class="alert alert-success">
			<p>To login to the OpenCms workplace, point your browser to the following URL:</p>
			<p><a href="#" onclick="window.open('<cms:link>/system/login/</cms:link>');return false;"><cms:link>/system/login/</cms:link></a></p>
		</div>

		<div class="row">
			<div class="col-md-6">
				<blockquote>
					<div>
						<strong>You are currently identified as:</strong><br/>
						User: <tt><cms:user property="name" /></tt><br/>
						Description: <tt><cms:user property="description" /></tt>
					</div>
				</blockquote>
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