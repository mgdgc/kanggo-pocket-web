<%@ page import="model.Member" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.File" %>
<%@ page import="database.AttachmentDBAccess" %>
<%@ page import="model.Attachment" %>
<%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2019-02-19
  Time: 00:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="../error_page.jsp" %>
<%
    request.setCharacterEncoding("utf-8");
    Member member = (Member) session.getAttribute("member");

    int maxSize; // 파일은 10MB, 이미지는 5MB까지 업로드
    try {
        maxSize = Integer.parseInt(request.getParameter("maxSize")) * 1024 * 1024;
    } catch (Exception e) {
        e.printStackTrace();
        maxSize = 10 * 1024 * 1024;
    }

    String type = request.getParameter("type");
    if (type == null) type = "file";
%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8"/>
    <title>파일 업로드</title>
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

        function sendRedirect(addr) {
            window.location = addr;
        }

        function copy() {
            var copyText = document.getElementById("inputFileId");
            copyText.select();
            document.execCommand("Copy");
        }
    </script>
</head>
<body>
<%

    AttachmentDBAccess dbAccess = new AttachmentDBAccess();

    String uploadPath;
    String shortenPath;
    if (type.equals("img")) {
        shortenPath = "/upload/images/" + member.getId();
        uploadPath = request.getSession().getServletContext().getRealPath(shortenPath);
    } else {
        shortenPath = "/upload/files/" + member.getId();
        uploadPath = request.getSession().getServletContext().getRealPath(shortenPath);
    }

    File fileDir = new File(uploadPath);
    fileDir.mkdirs();

    System.out.println("실제 업로드 폴더 경로: " + uploadPath);

    String name = "";

    // 인코딩 타입
    String encoding = "utf-8";
    // 중복처리된 이름
    String fileName = "";
    // 중복 처리전 실제 원본 이름
    String originalName = "";
    // 파일 사이즈
    long fileSize = 0;
    // 파일 타입
    String fileType = "";

    MultipartRequest multi;

    try {
        // request,파일저장경로,용량,인코딩타입,중복파일명에 대한 기본 정책
        multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());

        // form내의 input name="name" 인 녀석 value를 가져옴
        name = multi.getParameter("name");

        // 전송한 전체 파일이름들을 가져옴
        Enumeration files = multi.getFileNames();

        if (files.hasMoreElements()) {
            // 파일 input에 지정한 이름을 가져옴
            String file1 = (String) files.nextElement();

            // 그에 해당하는 실재 파일 이름을 가져옴
            originalName = multi.getOriginalFileName(file1);
            fileName = multi.getFilesystemName(file1);

            // input file name에 해당하는 실재 파일을 가져옴
            File file = multi.getFile(file1);

            // 그 파일 객체의 크기를 알아냄
            fileSize = file.length();

            Attachment attachment = new Attachment(0, fileName, originalName, shortenPath + "/" + fileName, member.getId(), (type.equals("image")));

            dbAccess.insertDB(attachment);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

%>
<div class="container shadow p-3 mb-5 bg-white rounded" style="min-width: 200px; max-width: 720px;">
    <div class="container card-body">
        <%
            Attachment a = dbAccess.getDB(member.getId(), fileName);
            if (a == null) {
        %>오류 발생. 관리자에게 문의해 주십시오.<%
    } else {
    %>
        <p>아래 파일 ID(숫자)를 복사하여 첨부파일에 입력하십시오.</p>
        <div class="input-group mb-3">
            <input type="text" class="form-control" id="inputFileId" aria-describedby="btnCopy"
                   value="<%= a.getFileId() %>" disabled>
            <div class="input-group-append">
                <button class="btn btn-outline-secondary" type="button" id="btnCopy" onclick="copy()">복사</button>
            </div>
        </div>
        <%
            }
        %>
    </div>
</div>
</body>
</html>
