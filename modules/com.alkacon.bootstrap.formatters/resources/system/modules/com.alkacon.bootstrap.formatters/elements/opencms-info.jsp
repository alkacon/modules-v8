<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="servive-block servive-block-light">
    <div>
        <i class="icon-4x fa fa-info-circle"></i>
    </div>
    
    <h2>You have installed OpenCms <cms:info property="opencms.version" /></h2>
    
    <p>
    <% 
    boolean sec = false;
    for (String key : org.opencms.main.OpenCms.getSystemInfo().getBuildInfoKeys()) {
        if (sec) { out.print(" - "); } else { sec = true; }
        org.opencms.main.CmsSystemInfo.BuildInfoItem item = org.opencms.main.OpenCms.getSystemInfo().getBuildInfoItem(key);
        String label = item.getNiceName();
        String value = item.getValue();
        out.println("<span style=\"white-space: nowrap;\">" + label + ": " + value + "</span>");
    }
    %> 
    </p>
   
    <p>
        Running on 
        <cms:info property="java.vm.vendor" /> 
        <cms:info property="java.vm.name" /> with
        <cms:info property="os.name" /> 
        <cms:info property="os.version" />
    </p>
    
    
</div>