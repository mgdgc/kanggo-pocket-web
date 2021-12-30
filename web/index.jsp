<%@ page import="model.Member" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2019-02-14
  Time: 16:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="error_page.jsp" %>
<%
    Member member = (Member) session.getAttribute("member");
%>
<!DOCTYPE HTML>
<html lang="ko" dir="ltr">
<head>
    <meta charset="utf-8">
    <title>강고 포켓<% if (member != null) { %> 관리자<% } %></title>
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
<%
    if (member == null) {
%>
<div class="container" style="margin-top: 48px; text-align: center;">
    <img src="res/ic_kp.png" width="120px" alt="">
    <br><br><br>강고 포켓에 오신 것을 환영합니다.
    <br><br>아래 버튼을 클릭하여 원하는 페이지로 이동하실 수 있습니다.
    <br><br>※ 일부 기능은 <b>관리자</b>만 이용하실 수 있습니다.
    <div class="container" style="margin-top: 48px;">
        <button type="button" class="btn btn-outline-primary"
                onclick="sendRedirect('${pageContext.request.contextPath}/announce/announce.jsp')">공지사항
        </button>
        <button type="button" class="btn btn-outline-primary"
                onclick="sendRedirect('${pageContext.request.contextPath}/schedule/schedule.jsp')">시간표
        </button>
        <button type="button" class="btn btn-outline-primary"
                onclick="sendRedirect('${pageContext.request.contextPath}/map/map.jsp')">교실배치도
        </button>
        <button type="button" class="btn btn-outline-primary"
                onclick="sendRedirect('${pageContext.request.contextPath}/login.jsp')">관리자 로그인
        </button>
    </div>
</div>
<%
} else {
%>
<div class="container" style="margin-top: 48px; text-align: center;">
    <img src="res/twotone-build-black-48/2x/twotone_build_black_48dp.png" width="64px" alt="">
    <br><br><br>강고 포켓 관리자에 오신 것을 환영합니다.
    <br><br>아래 버튼을 클릭하여 원하는 페이지로 이동하실 수 있습니다.
    <br><br>※ <b>권한 레벨</b>에 따라 이용할 수 있는 기능이 <b>제한</b>될 수 있습니다.
    <br>내 권한 레벨: <%
    switch (member.getLevel()) {
        case 0: %>미승인 (0)<%
        break;
    case 1: %>관리자 (1)<%
        break;
    case 2: %>선생님 (2)<%
        break;
    case 3: %>개발자 (3)<%
        break;
    default: %>비회원<%
    }
%>
    <small class="form-text text-muted">0: 미승인, 1: 관리자, 2: 선생님, 3: 개발자</small>
    <div class="container" style="margin-top: 48px;">
        <button type="button" class="btn btn-outline-primary"
                onclick="sendRedirect('${pageContext.request.contextPath}/announce/announce.jsp')">공지사항 관리
        </button>
        <button type="button" class="btn btn-outline-primary"
                onclick="sendRedirect('${pageContext.request.contextPath}/schedule/schedule.jsp')">시간표 관리
        </button>
        <button type="button" class="btn btn-outline-primary"
                onclick="sendRedirect('${pageContext.request.contextPath}/map/map.jsp')">교실배치도 관리
        </button>
        <button type="button" class="btn btn-outline-primary"
                onclick="sendRedirect('${pageContext.request.contextPath}/member/member.jsp')">회원 관리
        </button>
        <button type="button" class="btn btn-outline-primary"
                onclick="sendRedirect('${pageContext.request.contextPath}/developer/dev.jsp')">개발자 메뉴
        </button>
    </div>
</div>
<%
    }
%>
</body>
</html>
