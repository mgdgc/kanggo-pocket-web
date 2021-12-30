<%@ page import="database.AttachmentDBAccess" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2019-03-10
  Time: 03:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    String fileIdStr = request.getParameter("fileId");

    AttachmentDBAccess abda = new AttachmentDBAccess();

    int fileId = -1;
    try {
        fileId = Integer.parseInt(fileIdStr);
    } catch (Exception e) {
        e.printStackTrace();
    }

%>
<html>
<head>
    <title>이미지 뷰어</title>
    <script type="text/javascript">
        <% if (fileId == -1) { %>
        alert("파일이 존재하지 않습니다.");
        history.go(-1);
        <% } %>
    </script>
</head>
<body>
<img src="<%= request.getContextPath() %><%= abda.getDB(fileId).getPath() %>"
     width="80%">
</body>
</html>
