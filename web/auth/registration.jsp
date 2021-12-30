<%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2019-02-14
  Time: 20:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="database.MemberDBAccess" %>
<%@ page import="worker.EncryptManager" %>
<%@ page import="model.Member" %>
<%
    request.setCharacterEncoding("utf-8");
    Member member = null;

    String id = request.getParameter("id");
    String pw = request.getParameter("pw");
    String name = request.getParameter("name");
    String email = request.getParameter("email");

    if (id != null && pw != null && name != null && email != null) {
        member = new Member(name, id, pw, "", email, 0);
    }
%>
<html>
<head>
    <title>회원 가입</title>
    <script type="text/javascript">
        <% if (member == null) {
            %>
        alert("오류가 발생했습니다.");
        history.go(-1);
        <%
    } else {
        String salt = EncryptManager.createSalt();
        String encryptedPw = EncryptManager.getHash(1000, member.getPw(), salt);
        member.setSalt(salt);
        member.setPw(encryptedPw);

        MemberDBAccess dbAccess = new MemberDBAccess();
        if (dbAccess.getDB(member.getId()) == null) {
            if (dbAccess.getDB("email", member.getEmail()) == null) {
                if (dbAccess.insertDB(member)) {
                    response.sendRedirect("done_registration.jsp");
                } else {
        %>
        alert("회원가입을 할 수 없습니다.");
        history.go(-1);
        <%
                }
            } else {
                %>
        alert("중복되는 이메일이 있습니다. 다른 이메일을 시도하세요.");
        history.go(-1);
        <%
            }
        } else {
            %>
        alert("중복되는 아이디가 있습니다. 다른 아이디를 시도하세요.");
        history.go(-1);
        <%
        }
        }
        %>
    </script>
</head>
<body>

</body>
</html>
