<%@ page import="model.Member" %>
<%@ page import="database.MapDBAccess" %>
<%@ page import="database.AttachmentDBAccess" %>
<%@ page import="model.Attachment" %>
<%@ page import="model.Map" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2019-03-18
  Time: 22:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    Member member = (Member) session.getAttribute("member");
%>
<html>
<head>
    <title>교실배치도 관리</title>
    <script type="text/javascript">
        <%
        String[] fileIdStr = new String[5];
        for (int i = 0; i < fileIdStr.length; i++) {
            fileIdStr[i] = request.getParameter("file_0" + i);
        }

        int[] fileIds = new int[5];
        for (int i = 0; i < fileIds.length; i++) {
            if (fileIdStr[i] != null && !fileIdStr[i].isEmpty()) {
                fileIds[i] = Integer.parseInt(fileIdStr[i]);
            } else {
                fileIds[i] = -1;
            }
        }

        MapDBAccess mdba = new MapDBAccess();
        AttachmentDBAccess adba = new AttachmentDBAccess();

        for (int i = 0; i < fileIds.length; i++) {
            if (fileIds[i] != -1) {
                Attachment attach = adba.getDB(fileIds[i]);
                if (attach != null) {
                    Map map = new Map();
                    map.setFloor(i);
                    map.setFileId(fileIds[i]);
                    map.setPath(attach.getPath());

                    mdba.deleteDB(map.getFloor());
                    mdba.insertDB(map);
                }
            }
        }
        %>

        alert("저장되었습니다.");
        sendRedirect("${pageContext.request.contextPath}/map/map.jsp");

        function sendRedirect(addr) {
            window.location = addr;
        }
    </script>
</head>
<body>

</body>
</html>
