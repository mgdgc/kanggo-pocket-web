<%@ page import="model.Member" %>
<%@ page import="database.MemberDBAccess" %>
<%@ page import="worker.EncryptManager" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2019-03-16
  Time: 19:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    Member member = (Member) session.getAttribute("member");

    String pw = request.getParameter("pw");
    String email = request.getParameter("email");
%>
<html>
<head>
    <meta charset="utf-8">
    <title>회원 정보 수정</title>
    <script type="text/javascript">
        <%
        // 기능에 맞게 접속 권한을 변경
        int minLevel = 0;
            if (member == null) {
                %>
        alert("로그인이 필요합니다.");
        sendRedirect("${pageContext.request.contextPath}/index.jsp");
        <%
                   } else {
                       if (member.getLevel() < minLevel) {
                           %>
        alert("접속 권한이 없습니다.\n\n최소 권한: <%=minLevel%> (관리자)\n내 권한: <%=member.getLevel()%>");
        sendRedirect("${pageContext.request.contextPath}/index.jsp");
        <%
                       }
                   }
               %>

        // 회원 정보 수정
        <%
        if (pw != null && !pw.trim().isEmpty()) {
            String salt = EncryptManager.createSalt();
            String encryptedPw = EncryptManager.getHash(1000, pw, salt);
            member.setSalt(salt);
            member.setPw(encryptedPw);
        }

            MemberDBAccess dbAccess = new MemberDBAccess();
            if (email.trim().equals(member.getEmail()) || dbAccess.getDB("email", email) == null) {
                member.setEmail(email);
            if (dbAccess.updateDB(member)) {
                %>
        alert("회원 정보가 수정되었습니다.");
        sendRedirect("${pageContext.request.contextPath}/index.jsp");
        <%
            } else {
                %>
        alert("오류가 발생했습니다.");
        sendRedirect("${pageContext.request.contextPath}/index.jsp");
        <%
            }
            } else {
                %>
        alert("이미 등록된 email 입니다.");
        history.go(-1);
        <%
            }
        %>

        function sendRedirect(addr) {
            window.location = addr;
        }
    </script>
</head>
<body>

</body>
</html>
