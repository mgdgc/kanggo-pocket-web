<%@ page import="model.Member" %>
<%@ page import="database.AnnounceDBAccess" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Announcement" %>
<%@ page import="database.MemberDBAccess" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2019-02-14
  Time: 16:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    Member member = (Member) session.getAttribute("member");

    String pageStr = request.getParameter("page");
    int pageNum = 0;
    if (pageStr != null) {
        try {
            pageNum = Integer.parseInt(pageStr);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }

    String viewModeStr = request.getParameter("viewMode");
    int viewMode = 0;
    if (viewModeStr != null) {
        try {
            viewMode = Integer.parseInt(viewModeStr);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }
%>
<!DOCTYPE HTML>
<html>
<head>
    <title>공지사항</title>
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
<div class="container wrap">
    <div class="container shadow p-3 mb-5 bg-white rounded"
         style="margin-top: 48px; min-width: 200px; max-width: 720px;">
        <div class="container card-body">
            <p class="h2">공지사항</p>
            <% if (member != null && member.getLevel() > 0) { %>
            <button type="button" class="btn btn-primary" onclick="sendRedirect('write.jsp')">글쓰기</button>
            <% } %>
            <ul class="nav nav-tabs" style="margin-top: 24px;">
                <li class="nav-item">
                    <a class="nav-link <% if (viewMode == 0){ %>active<% } %>" href="announce.jsp?viewMode=0">전체</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link <% if (viewMode == 1) { %>active<% } %>" href="announce.jsp?viewMode=1">일반공지</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link <% if (viewMode == 2) { %>active<% } %>" href="announce.jsp?viewMode=2">학적공지</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link <% if (viewMode == 3) { %>active<% } %>" href="announce.jsp?viewMode=3">행사안내</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link <% if (viewMode == 4) { %>active<% } %>" href="announce.jsp?viewMode=4">업데이트
                        알림</a>
                </li>
            </ul>
            <%
                AnnounceDBAccess dbAccess = new AnnounceDBAccess();
                ArrayList<Announcement> data = dbAccess.getDBList();
                if (data != null && data.size() > 0) {
            %>
            <div class="list-group">
                <%
                    MemberDBAccess mda = new MemberDBAccess();
                    boolean hasNextPage = false;
                    boolean hasPrevPage = false;
                    for (int i = pageNum * 10; i < data.size() && i - pageNum * 10 < 10; i++) {
                        if (data.size() - pageNum * 10 > 10) {
                            hasNextPage = true;
                        }
                        if (pageNum > 0) {
                            hasPrevPage = true;
                        }
                        if (((member != null && member.getLevel() > 0) || !data.get(i).isPrivate())
                                && (viewMode == 0 || viewMode == data.get(i).getCategory())) {
                %>
                <a href="view.jsp?docId=<%= data.get(i).getDocId() %>" class="list-group-item list-group-item-action">
                    <div class="d-flex w-100 justify-content-between">
                        <h5 class="mb-1"><%= data.get(i).getTitle() %>
                        </h5>
                        <small><%= data.get(i).getWritten() %>
                        </small>
                    </div>
                    <p class="mb-1">
                        <%
                            if (data.get(i).getContent().length() > 20) {
                        %>
                        <%= data.get(i).getContent().substring(0, 20) %>......
                        <%
                        } else {
                        %>
                        <%= data.get(i).getContent() %>
                        <%
                            }
                        %>
                    </p>
                    <small>
                        <%
                            Member writer = mda.getDB(data.get(i).getUsrId());
                            if (writer == null) {
                        %>
                        <%= data.get(i).getUsrId() %> 관리자
                        <%
                        } else {
                            switch (writer.getLevel()) {
                                case 1: %>관리자<%
                            break;
                        case 2: %>선생님<%
                            break;
                        case 3: %>개발자<%
                                    break;
                                default: %>관리자<%
                                    break;
                            }
                        }
                    %>
                    </small>
                </a>
                <%
                        }
                    }

                    if (hasPrevPage) {
                %>
                <button type="button" class="btn btn-secondary"
                        onclick="sendRedirect('announce.jsp?page=<%=pageNum - 1%>&viewMode=<%=viewMode%>')">이전
                </button>
                <%
                    }

                    if (hasNextPage) {
                %>
                <button type="button" class="btn btn-primary"
                        onclick="sendRedirect('announce.jsp?page=<%=pageNum + 1%>&viewMode=<%=viewMode%>')">다음
                </button>
                <%
                    }
                %>
            </div>
            <%
            } else {
            %>
            <a href="#" class="list-group-item list-group-item-action disabled" tabindex="-1"
               aria-disabled="true">글이 없습니다.</a>
            <%
                }
            %>
        </div>
    </div>
</div>
</body>
</html>
