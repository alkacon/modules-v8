<%@page import="com.alkacon.opencms.v8.dialogs.CmsDialogActionElement"%><%
	CmsDialogActionElement dialog = new CmsDialogActionElement(pageContext, request, response);
%><!DOCTYPE html>
<html>
  <head>
  	<title><%= dialog.getTitle() %></title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <%= dialog.exportAll() %>
  </head>
  <body style="margin: 0px;">&nbsp;</body>
</html>
