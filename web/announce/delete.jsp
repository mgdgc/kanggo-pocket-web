<%@ page import="model.Member" %>
<%@ page import="database.AnnounceDBAccess" %>
<%@ page import="model.Announcement" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2019-03-09
  Time: 11:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    Member member = (Member) session.getAttribute("member");

    String docIdStr = request.getParameter("docId");
%>
<html>
<head>
    <title>글 삭제</title>
    <script type="text/javascript">
        <% if (member == null || member.getLevel() < 1) { %>
        alert("권한이 없습니다.");
        history.go(-1);
        <% }

        if (docIdStr == null) { %>
        alert("잘못된 접근입니다.");
        history.go(-1);
        <% }

        AnnounceDBAccess dbAccess = new AnnounceDBAccess();
        dbAccess.deleteDB(docIdStr);
        %>
        sendRedirect("${pageContext.request.contextPath}/announce/announce.jsp");

        function sendRedirect(addr) {
            window.location = addr;
        }
    </script>
</head>
<body>

</body>
</html>
