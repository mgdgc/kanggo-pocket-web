<%@ page import="model.Member" %>
<%@ page import="model.Announcement" %>
<%@ page import="database.AnnounceDBAccess" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2019-02-18
  Time: 17:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    Member member = (Member) session.getAttribute("member");

    String docIdStr = request.getParameter("docId");
    if (docIdStr == null) {
        docIdStr = "-1";
    }
    int docId;
    try {
        docId = Integer.parseInt(docIdStr);
    } catch (NumberFormatException e) {
        e.printStackTrace();
        docId = -1;
    }
%>
<html>
<head>
    <!DOCTYPE HTML>
    <title>공지 작성</title>
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

        function sendRedirect(addr) {
            window.location = addr;
        }
    </script>
</head>
<body>
<%
    int category = Integer.parseInt(request.getParameter("category"));
    String title = request.getParameter("title");
    String content = request.getParameter("content");
//    content.replaceAll("\n", "<br>");
    String images = request.getParameter("images");
    String files = request.getParameter("files");
    String isPrivateStr = request.getParameter("isPrivate");
    boolean isPrivate = isPrivateStr != null && isPrivateStr.equals("on");

    Announcement announce = new Announcement();
    announce.setUsrId(member.getId());
    announce.setCategory(category);
    announce.setTitle(title);
    announce.setContent(content);
    announce.setImgUrls(images);
    announce.setFileUrls(files);
    announce.setPrivate(isPrivate);

    AnnounceDBAccess dbAccess = new AnnounceDBAccess();

    if (docId != -1) {
        announce.setDocId(docId);
        dbAccess.updateDB(announce);
    } else {
        dbAccess.insertDB(announce);
    }

    response.sendRedirect("announce.jsp");

%>
</body>
</html>
