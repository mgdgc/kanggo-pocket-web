<%@ page import="com.google.gson.Gson" %>
<%@ page import="model.Announcement" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="database.AnnounceDBAccess" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2019-03-24
  Time: 18:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");

    String docId = request.getParameter("docId");

    if (docId == null) {
%>
wrong access
<%
} else {

    AnnounceDBAccess dbAccess = new AnnounceDBAccess();
    Announcement announce = dbAccess.getDB(docId);

    if (announce != null) {
        announce.setViewed(announce.getViewed() + 1);
        dbAccess.updateDB(announce);

        String result = new Gson().toJson(announce);
%>
<%= result %>
<%
} else {
%>
<%= new Gson().toJson(null) %>
<%
        }
    }
%>