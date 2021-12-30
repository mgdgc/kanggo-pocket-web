<%@ page import="model.Member" %>
<%@ page import="database.MemberDBAccess" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2019-02-24
  Time: 19:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %><%
    request.setCharacterEncoding("utf-8");
    Member member = (Member) session.getAttribute("member");

    String targetId = request.getParameter("targetId");
    MemberDBAccess mda = new MemberDBAccess();
    Member target = mda.getDB(targetId);
%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <title>회원 권한 레벨 변경</title>
    <script type="text/javascript">
        <%
        // 기능에 맞게 접속 권한을 변경
        int minLevel = 2;
            if (member == null) {
                %>
        alert("로그인이 필요합니다.");
        sendRedirect("${pageContext.request.contextPath}/index.jsp");
        <%
                   } else {
                       if (member.getLevel() < minLevel) {
                           %>
        alert("접속 권한이 없습니다.\n\n최소 권한: <%= minLevel %> (관리자)\n내 권한: <%= member.getLevel() %>");
        sendRedirect("${pageContext.request.contextPath}/index.jsp");
        <%
                       }
                   }
        %>

        <% if (member.getLevel() <= target.getLevel()) { %>
        alert("자신보다 높거나 같은 권한 레벨을 가진 회원은 변경할 수 없습니다.");
        history.go(-1);
        <% } %>

        function sendRedirect(addr) {
            window.location = addr;
        }

    </script>
</head>
<body>
<%
    String level = request.getParameter("level_select");
    target.setLevel(Integer.parseInt(level));

    mda.updateDB(target);

    response.sendRedirect("member.jsp");
%>
</body>
</html>
