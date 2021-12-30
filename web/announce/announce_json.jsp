<%@ page import="database.AnnounceDBAccess" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Announcement" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="model.Member" %>
<%@ page import="database.MemberDBAccess" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2019-03-17
  Time: 15:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");

    AnnounceDBAccess dbAccess = new AnnounceDBAccess();
    ArrayList<Announcement> data = dbAccess.getDBList();
    ArrayList<String> gsons = new ArrayList<>();

    if (data != null && data.size() > 0) {

        for (Announcement announce : data) {
            if (!announce.isPrivate()) {
                announce.setContent("");
                gsons.add(new Gson().toJson(announce));
            }
        }

        String[] jsonArray = gsons.toArray(new String[gsons.size()]);
        String result = new Gson().toJson(jsonArray);
        %>
<%= result %>
<%
    } else {
        %>
<%= new Gson().toJson(null) %>
<%
    }
%>