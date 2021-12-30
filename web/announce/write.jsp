<%@ page import="model.Member" %>
<%@ page import="model.Announcement" %>
<%@ page import="database.AnnounceDBAccess" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2019-02-18
  Time: 17:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");

    Member member = (Member) session.getAttribute("member");

    int maxContent = 2000;
    int maxImgSize = 5;
    int maxFileSize = 10;

    // mode edit
    String mode = request.getParameter("mode");
    if (mode == null) mode = "write";

    AnnounceDBAccess dbAccess = new AnnounceDBAccess();
    Announcement doc = null;
    if (mode.equals("edit")) {
        try {
            int docId = Integer.parseInt(request.getParameter("docId"));
            doc = dbAccess.getDB(String.valueOf(docId));
        } catch (NumberFormatException | NullPointerException e) {
            e.printStackTrace();
%>
<script type="text/javascript">
    alert("잘못된 접근입니다.");
    history.go(-1);
</script>
<%
        }
    }
%>
<!DOCTYPE HTML>
<html>
<head>
    <title>공지 작성</title>
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
        alert("접속 권한이 없습니다.\n\n최소 권한: <%=minLevel%> (관리자)\n내 권한: <%=member.getLevel()%>");
        sendRedirect("${pageContext.request.contextPath}/index.jsp");
        <%
                       }
                   }
               %>

        var fileChecked = true;

        function sendRedirect(addr) {
            window.location = addr;
        }

        function openWindow(addr) {
            var win = window.open(addr, "_blank");
            win.focus();
        }

        function checkValid() {
            var title = document.getElementById("title").value.trim();
            var content = document.getElementById("content").value.trim();

            // 파일 용량 확인
            if (!fileChecked) {
                alert("첨부한 파일에 문제가 있습니다. 다시 한번 확인해 주십시오.");
            }

            // 제목과 본문에 앞 뒤 공백을 제거
            document.getElementById("title").value = title;
            document.getElementById("content").value = content;

            if (title.trim().length <= 0) {
                alert("제목을 입력해 주세요.");
                return false;
            } else {
                if (title.length > 60) {
                    alert("제목은 60자를 초과할 수 없습니다.");
                    return false;
                }
            }

            if (content.length <= 0) {
                alert("내용을 입력해 주세요.");
                return false;
            } else {
                if (content.length > <%=maxContent%>) {
                    alert("본문은 <%=maxContent%>자를 넘을 수 없습니다.");
                    return false;
                }
            }

            var img = document.getElementById("imgUpload");
            if (img.value !== null && img.value.trim() !== "") {
                var imgs = img.split(",");
                for (image in imgs) {
                    if (isNaN(image.trim())) {
                        alert("숫자로 구성된 파일 ID값을 넣어주십시오.");
                        return false;
                    }
                }
            }

            var file = document.getElementById("fileUpload");
            if (file.value !== null && file.value.trim() !== "") {
                var files = file.split(",");
                for (f in files) {
                    if (isNaN(f.trim())) {
                        alert("숫자로 구성된 파일 ID값을 넣어주십시오.");
                        return false;
                    }
                }
            }

            var imgs = img.split(",");
            if (imgs.length > 5) {
                alert("이미지는 5개까지 첨부가 가능합니다.");
                return false;
            }

            var files = file.split(",");
            if (files.length > 2) {
                alert("파일은 2개까지 첨부가 가능합니다.");
                return false;
            }

            return true;
        }

        // https://zinee-world.tistory.com/237
        $(function () {
            var content = $('#content');
            content.keyup(function (e) {
                var content = $(this).val();
                $(this).height(((content.split('\n').length + 1) * 1.5) + 'em');
                $('#badge_count').html(content.length + '/<%=maxContent%>');
            });
            content.keyup();
        });
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
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}/announce/announce.jsp">공지사항 <span
                        class="sr-only">(current)</span></a>
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
<div class="container shadow-sm p-3 mb-5 bg-light rounded text-secondary"
     style="min-width: 200px; max-width: 720px; margin-top: 48px; font-size: 24px; text-align: center">
    공지사항 작성
</div>
<div class="container shadow p-3 mb-5 bg-white rounded" style="min-width: 200px; max-width: 720px;">
    <div class="container card-body">
        <form action="write_action.jsp" method="post" onsubmit="return checkValid()">
            <div class="form-group">
                <label for="category">카테고리</label>
                <select name="category" id="category" class="form-control">
                    <option value="1" <% if (doc == null || doc.getCategory() == 1) { %>selected<% } %>>일반공지
                    </option>
                    <option value="2" <% if (doc != null && doc.getCategory() == 2) { %>selected<% } %>>학적공지</option>
                    <option value="3" <% if (doc != null && doc.getCategory() == 3) { %>selected<% } %>>행사안내</option>
                    <option value="4" <% if (doc != null && doc.getCategory() == 4) { %>selected<% } %>>업데이트 알림 (시간표,
                        앱)
                    </option>
                </select>
            </div>
            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" name="title" id="title" class="form-control" placeholder="글 제목" maxlength="60"
                       <% if (doc != null) { %>value="<%= doc.getTitle() %>"<% } %>>
            </div>
            <div class="form-group">
                <label for="content">내용</label>
                <textarea class="form-control" name="content" id="content" placeholder="글 내용"
                          maxlength="<%=maxContent%>"
                          style="min-height: 360px; max-height: 720px;"><% if (doc != null) { %><%= doc.getContent() %><% } %></textarea>
                <small id="contentHelp" class="form-text text-muted">
                    본문은 <%=maxContent%>자까지 입력이 가능합니다.
                    <span id="badge_count" class="badge badge-secondary float-right">New</span>
                </small>
            </div>
            <div class="form-group">
                <p>
                    <button class="btn btn-primary" type="button" data-toggle="collapse"
                            data-target="#imgUploadCollapse"
                            aria-expanded="false" aria-controls="imgUploadCollapse">
                        이미지 첨부
                    </button>
                    <button class="btn btn-primary" type="button" data-toggle="collapse"
                            data-target="#fileUploadCollapse"
                            aria-expanded="false" aria-controls="fileUploadCollapse">
                        파일 첨부
                    </button>
                </p>
                <div class="collapse" id="imgUploadCollapse">
                    <div class="card card-body">
                        <label>이미지 첨부</label>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <button class="btn btn-outline-secondary" type="button" id="img_upload"
                                        onclick="openWindow('${pageContext.request.contextPath}/file/upload.jsp?type=img')">
                                    업로드
                                </button>
                            </div>
                            <input type="text" name="images" class="form-control"
                                   placeholder="이미지 업로드 후 여기에 파일 ID를 입력하세요."
                                   aria-label="Example text with button addon" aria-describedby="button-addon1">
                        </div>
                        <% if (doc != null && doc.getImgUrls() != null && !doc.getImgUrls().trim().equals("")) { %>
                        <small class="form-text text-muted">글 수정시 첨부파일을 다시 설정해야 합니다.
                            <br>기존 첨부파일 ID: <%= doc.getImgUrls() %>
                        </small>
                        <% } %>
                        <small id="imgHelp" class="form-text text-muted">이미지는 <%=maxImgSize%>MB씩 5장까지 첨부가 가능합니다. 콤마(,)로
                            구분하세요.
                        </small>
                    </div>
                </div>
                <div class="collapse" id="fileUploadCollapse" style="margin-top: 16px;">
                    <div class="card card-body">
                        <label>파일 첨부</label>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <button class="btn btn-outline-secondary" type="button" id="file_upload"
                                        onclick="openWindow('${pageContext.request.contextPath}/file/upload.jsp?type=file')">
                                    업로드
                                </button>
                            </div>
                            <input type="text" name="files" class="form-control"
                                   placeholder="파일 업로드 후 여기에 파일 ID를 입력하세요."
                                   aria-label="Example text with button addon" aria-describedby="button-addon1">
                        </div>
                        <% if (doc != null && doc.getFileUrls() != null && !doc.getFileUrls().trim().equals("")) { %>
                        <small class="form-text text-muted">글 수정시 첨부파일을 다시 설정해야 합니다.
                            <br>기존 첨부파일 ID: <%= doc.getFileUrls() %>
                        </small>
                        <% } %>
                        <small id="fileHelp" class="form-text text-muted">파일은 <%=maxFileSize%>MB씩 2개까지 첨부가 가능합니다. 콤마(,)로
                            구분하세요.
                        </small>
                    </div>
                </div>
            </div>
            <input type="hidden" name="docId"
                   value="<% if (doc != null) { %><%= doc.getDocId() %><% } else { %>-1<% } %>">
            <div class="form-group form-check">
                <input type="checkbox" class="form-check-input" id="cb_private" name="isPrivate"
                       <% if (doc != null && doc.isPrivate()) { %>checked<% } %>>
                <label class="form-check-label" for="cb_private">비공개로 게시</label>
            </div>
            <button type="submit" class="btn btn-outline-primary w-100 p-3">작성</button>
        </form>
    </div>
</div>
<div class="footerw-100 p-3" style="height: 240px;">

</div>
</body>
</html>
