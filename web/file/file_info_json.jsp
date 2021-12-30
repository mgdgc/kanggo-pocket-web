<%@ page import="database.AttachmentDBAccess" %>
<%@ page import="model.Attachment" %>
<%@ page import="com.google.gson.Gson" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2019-03-30
  Time: 23:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");

    String fileIdStr = request.getParameter("fileId");

    if (fileIdStr == null) {
%>
wrong access
<%
} else {
    try {
        int fileId = Integer.parseInt(fileIdStr);

        AttachmentDBAccess dbAccess = new AttachmentDBAccess();
        Attachment attach = dbAccess.getDB(fileId);

        if (attach != null) {
            String result = new Gson().toJson(attach);
%>
<%= result %>
<%
} else {
%>
<%= new Gson().toJson(null) %>
<%
    }
} catch (NumberFormatException e) {
    e.printStackTrace();
%>wrong access<%
        }
    }
%>