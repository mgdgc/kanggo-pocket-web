<%@ page import="model.Member" %>
<%@ page import="database.MapDBAccess" %>
<%@ page import="model.Map" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2019-03-18
  Time: 19:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    Member member = (Member) session.getAttribute("member");

    MapDBAccess mdba = new MapDBAccess();
    Map[] maps = new Map[5];
    for (int i = 0; i < maps.length; i++) {
        maps[i] = mdba.getDB(i);
    }
%>
<html>
<head>
    <title>교실배치도 관리</title>
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
        <%
        // 기능에 맞게 접속 권한을 변경
        int minLevel = 1;
            if (member == null) {
                %>
        alert("로그인이 필요합니다.");
        sendRedirect("${pageContext.request.contextPath}/index.jsp");
        <%
                   } else {
                       if (member.getLevel() < minLevel) {
                           %>
        alert("접속 권한이 없습니다.\n\n최소 권한: ${minLevel} (관리자)\n내 권한: ${member.getLevel()}");
        sendRedirect("${pageContext.request.contextPath}/index.jsp");
        <%
                       }
                   }
               %>

        function isValid(fileId) {
            if (fileId === "") {
                alert("파일 ID를 입력하세요.");
                return false;
            }

            if (isNaN(fileId)) {
                alert("올바른 파일 ID를 입력해 주세요.");
                return false;
            }

            return true;
        }

        function checkValid() {
            for (var i = 0; i < 5; i++) {
                if (isNaN(document.getElementById("file_0" + i).value.trim())) {
                    if (i === 0) {
                        alert("지하의 교실배치도의 파일 ID를 확인해 주세요.");
                    } else {
                        alert(i + "층의 교실배치도의 파일 ID를 확인해 주세요.");
                    }
                    return false;
                }
            }

            return true;
        }

        function sendRedirect(addr) {
            window.location = addr;
        }

        function openWindow(addr) {
            var win = window.open(addr, "_blank");
            win.focus();
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
<div class="container shadow p-3 mb-5 bg-white rounded"
     style="margin-top: 48px; min-width: 200px; max-width: 720px;">
    <div class="container">
        <p class="h2">교실배치도 수정</p>
        <p style="margin-top: 36px;">
            <b>관리자(1)이상</b> 권한부터 교실배치도를 수정할 수 있습니다.
            <br>교실배치도 이미지 파일을 업로드 후
            <mark>파일 ID</mark>
            값을 첨부하십시오.
            <br><br>어려움을 겪고 계신다면 개발자에게 연락바랍니다.
        </p>
    </div>

    <form action="map_register.jsp" method="post" onsubmit="return checkValid()">
        <div class="container card card-body" style="margin-top: 48px;">
            <%--지하--%>
            <div class="container">
                <p class="h5">지하</p>
                <div class="input-group mb-3" style="margin-top: 16px;">
                    <div class="input-group-prepend">
                        <button class="btn btn-outline-secondary" type="button"
                                onclick="openWindow('${pageContext.request.contextPath}/file/upload.jsp?type=img')">
                            업로드
                        </button>
                    </div>
                    <input type="text" name="file_00" class="form-control" id="file_00"
                           <% if (maps[0] != null) { %>value="<%= maps[0].getFileId() %>"<% } %>
                           placeholder="교실배치도 이미지 업로드 후 여기에 파일 ID를 입력하세요.">
                    <div class="input-group-append">
                        <button class="btn btn-secondary" type="button"
                                onclick="openCheckWindow(0)">
                            이미지 확인
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div class="container card card-body" style="margin-top: 16px;">
            <%--1층--%>
            <div class="container">
                <p class="h5">1층</p>
                <div class="input-group mb-3" style="margin-top: 16px;">
                    <div class="input-group-prepend">
                        <button class="btn btn-outline-secondary" type="button"
                                onclick="openWindow('${pageContext.request.contextPath}/file/upload.jsp?type=img')">
                            업로드
                        </button>
                    </div>
                    <input type="text" name="file_01" class="form-control" id="file_01"
                           <% if (maps[1] != null) { %>value="<%= maps[1].getFileId() %>"<% } %>
                           placeholder="교실배치도 이미지 업로드 후 여기에 파일 ID를 입력하세요.">
                    <div class="input-group-append">
                        <button class="btn btn-secondary" type="button"
                                onclick="openCheckWindow(1)">
                            이미지 확인
                        </button>
                    </div>
                </div>
            </div>

        </div>

        <div class="container card card-body" style="margin-top: 16px;">
            <%--2층--%>
            <div class="container">
                <p class="h5">2층</p>
                <div class="input-group mb-3" style="margin-top: 16px;">
                    <div class="input-group-prepend">
                        <button class="btn btn-outline-secondary" type="button"
                                onclick="openWindow('${pageContext.request.contextPath}/file/upload.jsp?type=img')">
                            업로드
                        </button>
                    </div>
                    <input type="text" name="file_02" class="form-control" id="file_02"
                           <% if (maps[2] != null) { %>value="<%= maps[2].getFileId() %>"<% } %>
                           placeholder="교실배치도 이미지 업로드 후 여기에 파일 ID를 입력하세요.">
                    <div class="input-group-append">
                        <button class="btn btn-secondary" type="button"
                                onclick="openCheckWindow(2)">
                            이미지 확인
                        </button>
                    </div>
                </div>
            </div>

        </div>

        <div class="container card card-body" style="margin-top: 16px;">
            <%--3층--%>
            <div class="container">
                <p class="h5">3층</p>
                <div class="input-group mb-3" style="margin-top: 16px;">
                    <div class="input-group-prepend">
                        <button class="btn btn-outline-secondary" type="button"
                                onclick="openWindow('${pageContext.request.contextPath}/file/upload.jsp?type=img')">
                            업로드
                        </button>
                    </div>
                    <input type="text" name="file_03" class="form-control" id="file_03"
                           <% if (maps[3] != null) { %>value="<%= maps[3].getFileId() %>"<% } %>
                           placeholder="교실배치도 이미지 업로드 후 여기에 파일 ID를 입력하세요.">
                    <div class="input-group-append">
                        <button class="btn btn-secondary" type="button"
                                onclick="openCheckWindow(3)">
                            이미지 확인
                        </button>
                    </div>
                </div>
            </div>

        </div>

        <div class="container card card-body" style="margin-top: 16px;">
            <%--4층--%>
            <div class="container">
                <p class="h5">4층</p>
                <div class="input-group mb-3" style="margin-top: 16px;">
                    <div class="input-group-prepend">
                        <button class="btn btn-outline-secondary" type="button"
                                onclick="openWindow('${pageContext.request.contextPath}/file/upload.jsp?type=img')">
                            업로드
                        </button>
                    </div>
                    <input type="text" name="file_04" class="form-control" id="file_04"
                           <% if (maps[4] != null) { %>value="<%= maps[4].getFileId() %>"<% } %>
                           placeholder="교실배치도 이미지 업로드 후 여기에 파일 ID를 입력하세요.">
                    <div class="input-group-append">
                        <button class="btn btn-secondary" type="button"
                                onclick="openCheckWindow(4)">
                            이미지 확인
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <button type="submit" class="btn btn-outline-primary w-100 p-3"
                style="margin-top: 48px;">저장
        </button>
    </form>
</div>
</body>
<script type="text/javascript">
    function openCheckWindow(floor) {
        var fileId = document.getElementById("file_0" + floor).value;
        if (isValid(fileId.trim())) {
            openWindow('${pageContext.request.contextPath}/file/image_viewer.jsp?fileId=' + fileId.trim());
        }
    }
</script>
</html>
