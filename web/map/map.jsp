<%@ page import="model.Member" %>
<%@ page import="model.Map" %>
<%@ page import="database.MapDBAccess" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2019-02-19
  Time: 13:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    Member member = (Member) session.getAttribute("member");

    String floorStr = request.getParameter("floor");
    int floor = 0;
    if (floorStr != null) {
        try {
            floor = Integer.parseInt(floorStr);

            if (floor < 0 || floor > 4) {
                floor = 0;
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }

    MapDBAccess mdba = new MapDBAccess();
    Map map = mdba.getDB(floor);

%>
<!DOCTYPE HTML>
<html>
<head>
    <title>교실배치도</title>
    <meta charset="utf-8">
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
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/announce/announce.jsp">공지사항</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/schedule/schedule.jsp">시간표</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}/map/map.jsp">교실배치도 <span class="sr-only">(current)</span></a>
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
<div class="container shadow p-3 mb-5 bg-white"
     style="margin-top: 48px; min-width: 200px; max-width: 720px;">
    <ul class="nav nav-pills">
        <li class="nav-item">
            <a class="nav-link <% if (floor == 0) { %>active<% } %>"
               href="${pageContext.request.contextPath}/map/map.jsp?floor=0">지하</a>
        </li>
        <li class="nav-item">
            <a class="nav-link <% if (floor == 1) { %>active<% } %>"
               href="${pageContext.request.contextPath}/map/map.jsp?floor=1">1층</a>
        </li>
        <li class="nav-item">
            <a class="nav-link <% if (floor == 2) { %>active<% } %>"
               href="${pageContext.request.contextPath}/map/map.jsp?floor=2">2층</a>
        </li>
        <li class="nav-item">
            <a class="nav-link <% if (floor == 3) { %>active<% } %>"
               href="${pageContext.request.contextPath}/map/map.jsp?floor=3">3층</a>
        </li>
        <li class="nav-item">
            <a class="nav-link <% if (floor == 4) { %>active<% } %>"
               href="${pageContext.request.contextPath}/map/map.jsp?floor=4">4층</a>
        </li>
    </ul>
    <div class="container" style="margin-top: 48px;">
        <% if (map != null) { %>
        <a href="${pageContext.request.contextPath}/file/image_viewer.jsp?fileId=<%= map.getFileId() %>">
            <img src="<%= request.getContextPath() %><%= map.getPath() %>"
                 width="100%" alt="<%= map.getFloor() %>층"/>
        </a>
        <% } else { %>
        <div class="alert alert-primary" role="alert">
            등록된 <% if (floor == 0) { %>지하<% } else { %><%= floor %>층<% } %> 교실배치도가 없습니다.
        </div>
        <% } %>
    </div>
    <% if (member != null) { %>
    <div class="container" style="margin-top: 48px; min-width: 200px; max-width: 720px; height: 48px;">
        <button type="button" class="btn btn-outline-primary float-right"
        onclick="sendRedirect('${pageContext.request.contextPath}/map/map_manage.jsp')">수정</button>
    </div>
    <% } %>
</div>
</body>
</html>
