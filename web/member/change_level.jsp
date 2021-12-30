<%@ page import="model.Member" %>
<%@ page import="database.MemberDBAccess" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2019-02-24
  Time: 18:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
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
    <title>회원 관리</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:300,700" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
            integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
            crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
            integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
            crossorigin="anonymous"></script>
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

<div class="container shadow p-3 mb-5 bg-white rounded" style="min-width: 200px; max-width: 720px;">
    <div class="container card-body">
        <h3>회원 권한 레벨 변경</h3>
        <p class="text-center" style="margin-top: 48px;">
            <%= target.getName() %>(<%= target.getId() %>) 회원의 권한 레벨을 변경합니다.
            <br><br>현재: <%= target.getLevel() %>
            <br>
            <small class="form-text text-muted">0: 미승인, 1: 관리자, 2: 선생님, 3: 개발자</small>
        </p>
        <form action="set_level.jsp" method="post">
            <div class="form-group">
                <label for="level_select">권한 레벨 선택</label>
                <select class="form-control" id="level_select" name="level_select">
                    <% switch (member.getLevel()) {
                        case 3: %>
                    <option value="3">3: 개발자</option>
                    <% case 2: %>
                    <option value="2">2: 선생님</option>
                    <% case 1: %>
                    <option value="1">1: 관리자</option>
                    <% case 0: %>
                    <option value="0" selected>0: 미승인</option>
                    <% default:%>
                    <% } %>
                </select>
            </div>
            <input type="hidden" name="targetId" value="<%= target.getId() %>">
            <div class="btn-group w-100" role="group" aria-label="Basic example">
                <button type="button" class="btn btn-outline-secondary w-50 p-3" onclick="history.go(-1);">취소</button>
                <button type="submit" class="btn btn-outline-primary w-50 p-3">변경</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
