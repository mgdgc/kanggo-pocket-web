<%@ page import="database.MemberDBAccess" %>
<%@ page import="model.Member" %>
<%@ page import="worker.EncryptManager" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2019-02-14
  Time: 16:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
%>
<html>
<head>
    <title>로그인</title>
    <script type="text/javascript">
        <%
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");

    MemberDBAccess dbAccess = new MemberDBAccess();
    Member member = dbAccess.getDB("id", id);

    if (member != null) {
        if (EncryptManager.getHash(1000, pw, member.getSalt()).equals(member.getPw())) {
            session.setAttribute("member", member);
            response.sendRedirect("../index.jsp");
        } else {
%>
        alert("이메일 혹은 비밀번호가 올바르지 않습니다.");
        history.go(-1);
        <%
            }
        } else {
        %>
        alert("등록된 이메일 혹은 비밀번호가 없습니다.");
        history.go(-1);
        <%
            }
        %>
    </script>
</head>
<body>

</body>
</html>
