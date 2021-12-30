<%@ page import="java.io.File" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="database.AttachmentDBAccess" %>
<%@ page import="model.Attachment" %>
<%@ page import="java.nio.charset.StandardCharsets" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2019-02-25
  Time: 23:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
%>
<html>
<head>
    <title>파일 다운로드</title>
</head>
<body>
<%
    //https://rongscodinghistory.tistory.com/77

    AttachmentDBAccess dbAccess = new AttachmentDBAccess();
    int fileId = Integer.parseInt(request.getParameter("fileId"));
    Attachment attachment = dbAccess.getDB(fileId);
    String downPath = request.getServletContext().getRealPath(attachment.getPath());

    File outputFile = new File(downPath);
    byte[] temp = new byte[1024*1024*10]; // 10M

    FileInputStream in = new FileInputStream(outputFile);

    String sMimeType = request.getServletContext().getMimeType(downPath);

    System.out.println("유형 : " + sMimeType);

    if ( sMimeType == null ){
        sMimeType = "application.octec-stream";
    }

    response.setContentType(sMimeType);

    String encoded = new String(attachment.getFilename().getBytes(StandardCharsets.UTF_8),"8859_1");

    String AA = "Content-Disposition";
    String BB = "attachment;filename="+ encoded;
    response.setHeader(AA,BB);

    ServletOutputStream out2 = response.getOutputStream();

    int numRead = 0;

    while((numRead = in.read(temp,0,temp.length)) != -1){
        out2.write(temp,0,numRead);
    }

    out2.flush();
    out2.close();
    in.close();

%>
</body>
</html>
