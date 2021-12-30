<%@ page import="model.Member" %>
<%@ page import="database.AnnounceDBAccess" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Announcement" %>
<%@ page import="database.MemberDBAccess" %>
<%@ page import="database.AttachmentDBAccess" %>
<%@ page import="model.Attachment" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2019-03-05
  Time: 20:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    request.setCharacterEncoding("utf-8");
    Member member = (Member) session.getAttribute("member");
%>
<!DOCTYPE HTML>
<html>
<head>
    <title>강고 포켓</title>
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
        AttachmentDBAccess adba = new AttachmentDBAccess();

        String docIdStr = request.getParameter("docId");
        int docId = 0;
        if (docIdStr != null) {
            try {
                docId = Integer.parseInt(docIdStr);
            } catch (NumberFormatException e) {
                e.printStackTrace();
                %>
        alert("잘못된 접근입니다.");
        sendRedirect('${pageContext.request.contextPath}/index.jsp');
        <%
            }
        }
        String writerStr = "";

        AnnounceDBAccess dbAccess = new AnnounceDBAccess();
        Announcement data = dbAccess.getDB(docIdStr);

        if (data != null) {
        data.setViewed(data.getViewed() + 1);
        if (!dbAccess.updateDB(data)) {
            System.out.println("Failed to update data: " + data.getDocId());
        }

        MemberDBAccess mda = new MemberDBAccess();
        Member writer = mda.getDB(data.getUsrId());

        if (writer == null) {
            writerStr = "관리자";
        } else {
            switch (writer.getLevel()) {
                case 1: writerStr = "관리자";
                    break;
                    case 2: writerStr = "선생님";
                        break;
                        case 3: writerStr = "개발자";
                            break;
                                default: writerStr = "관리자";
                                    break;
                            }
                            writerStr += " (" + data.getUsrId() + ")";
        }

        if (data.isPrivate()) {
            if (member == null || member.getLevel() < 1) {
            %>
        alert("비공개된 게시글입니다.");
        history.go(-1);
        <%
            }
        }
        } else {
            %>
        alert("게시글이 없습니다.");
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
<%
    if (data != null) {
%>
<div class="container shadow p-3 mb-5 bg-white rounded" style="margin-top: 48px; min-width: 200px; max-width: 720px;">
    <div class="container card-body">
        <p class="h2"><%= data.getTitle() %>
        </p>
        <p class="h6">작성자: <%= writerStr %> | 작성일: <%= data.getWritten() %> | 조회: <%= data.getViewed() %>
        </p>
        <p style="white-space: pre-line; margin: 48px 24px;"><%= data.getContent() %>
        </p>
        <% if (data.getImgUrls() != null && !data.getImgUrls().trim().isEmpty()) { %>
        <div class="container" style="margin-top: 48px;">
            <%
                String[] ids = data.getImgUrls().trim().split(",");
                for (String id : ids) {
                    try {
                        int i = Integer.parseInt(id.trim());
                        Attachment img = adba.getDB(i);
                        if (img != null) {
            %>
            <a href="${pageContext.request.contextPath}/file/image_viewer.jsp?fileId=<%= img.getFileId() %> ">
                <img src="${pageContext.request.contextPath}<%= img.getPath() %>" width="100px" height="100px"
                     alt="image"/>
            </a>
            <%
                        }
                    } catch (NumberFormatException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </div>
        <% } %>
        <% if (data.getFileUrls() != null && !data.getFileUrls().trim().isEmpty()) { %>
        <div class="list-group" style="margin-top: 48px;">
            <%
                String[] ids = data.getFileUrls().trim().split(",");
                for (String id : ids) {
                    try {
                        int i = Integer.parseInt(id.trim());
                        Attachment attach = adba.getDB(i);
                        if (attach != null) {
                            String name = attach.getOriginalName();
            %>
            <button type="button" class="list-group-item list-group-item-action" onclick="
                    sendRedirect('${pageContext.request.contextPath}/file/file_download.jsp?fileId=' + <%= i %>)"><%= name %>
            </button>
            <%
                        }
                    } catch (NumberFormatException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </div>
        <% } %>
    </div>
    <% if (member != null) { %>
    <div class="btn-group" role="group" aria-label="Basic example">
        <% if (member.getLevel() > 1 || member.getId().equals(data.getUsrId())) { %>
        <button type="button" class="btn btn-outline-secondary" id="btnEdit"
                onclick="sendRedirect('${pageContext.request.contextPath}/announce/write.jsp?mode=edit&docId=<%= docId %>')">
            수정
        </button>
        <% } %>
        <% if (member.getLevel() > 0) { %>
        <button type="button" class="btn btn-outline-danger" id="btnDelete"
                onclick="if (confirm('정말로 삭제하시겠습니까?')) {
                        sendRedirect('${pageContext.request.contextPath}/announce/delete.jsp?docId=' + <%= data.getDocId() %>);}">
            삭제
        </button>
        <% } %>
    </div>
    <% } %>
</div>
</body>
<script type="text/javascript">
    var btnDelete = document.getElementById("btnDelete");
    btnDelete.addEventListener("onclick", function () {
        var confirm = confirm("정말로 삭제하시겠습니까?");
        if (confirm) {
            sendRedirect("${pageContext.request.contextPath}/announce/delete.jsp?docId=" + <%= data.getDocId() %>);
        }
    });

    function alertNoDocument() {

    }
</script>
<% } else {

}%>
</html>
