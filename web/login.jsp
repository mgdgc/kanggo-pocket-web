<%@ page import="model.Member" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2019-03-11
  Time: 01:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Member member = (Member) session.getAttribute("member");
%>
<html>
<head>
    <meta charset="utf-8">
    <title>로그인</title>
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

        function sendRedirect(addr) {
            window.location = addr;
        }

        function checkValid() {
            var id = document.getElementById("id").value.trim();
            var pw = document.getElementById("pw").value.trim();

            if (id === "" || pw === "") {
                alert("아이디와 비밀번호를 입력하세요.");
                return false;
            } else {
                return true;
            }
        }
    </script>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">
        <img src="${pageContext.request.contextPath}/res/favicon/android-icon-192x192.png" width="30" height="30"
             class="d-inline-block align-top" alt="">
        강고 포켓<% if (member != null) { %> 관리자<% } %>
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown"
            aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavDropdown">
        <ul class="navbar-nav">
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/announce/announce.jsp">공지사항</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/schedule/schedule.jsp">시간표</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/map/map.jsp">교실배치도</a>
            </li>
            <% if (member != null) { %>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button"
                   data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    더보기
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/member/member.jsp">회원 관리</a>
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/developer/dev.jsp">개발자 메뉴</a>
                    <hr>
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/member/edit_info.jsp">정보 수정</a>
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/auth/logout.jsp">로그아웃</a>
                </div>
            </li>
            <% } %>
        </ul>
    </div>
</nav>
<div class="container" style="margin-top: 24px; margin-bottom: 48px; text-align: center">
    <div class="alert alert-primary d-inline-flex p-2 bd-highlight" role="alert">
        강고 포켓 관리자는 로그인을 필요로 합니다.
    </div>
</div>
<div class="div_login">
    <form action="${pageContext.request.contextPath}/auth/login.jsp" method="post" onsubmit="return checkValid()">
        <div class="container shadow shadow-lg p-3 mb-5 bg-white rounded"
             style="padding: 16px 16px; min-width: 240px; max-width: 400px;">
            <div class="form-group">
                <label for="id">아이디</label>
                <input type="text" class="form-control" name="id" id="id" placeholder="아이디" aria-describedby="idHelp">
                <small id="idHelp" class="form-text text-muted">회원 가입시 사용한 아이디를 사용해 주십시오.</small>
            </div>
            <div class="form-group">
                <label for="pw">비밀번호</label>
                <input type="password" class="form-control" name="pw" id="pw" placeholder="비밀번호">
            </div>
            <button type="submit" class="btn btn-primary">로그인</button>
            <div class="btn-group" role="group">
                <button class="btn btn-secondary" type="button"
                        onclick="sendRedirect('${pageContext.request.contextPath}/auth/register.jsp')">회원 가입
                </button>
                <button class="btn btn-secondary" type="button"
                        onclick="sendRedirect('${pageContext.request.contextPath}/auth/register.jsp')">아이디 찾기
                </button>
                <button class="btn btn-secondary" type="button"
                        onclick="sendRedirect('${pageContext.request.contextPath}/auth/register.jsp')">비밀번호 찾기
                </button>
            </div>
        </div>
    </form>
</div>
</body>
</html>
