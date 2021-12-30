<%@ page import="model.Member" %><%--
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
%>
<html>
<head>
    <title>시간표</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <script type="text/javascript">
        <%
        if (member != null) {
            %>
        window.open("https://docs.google.com/spreadsheets/d/11Z7WOjdm55dGIlArLlPHXdTlE1dwweJE13xYyUenkeY/edit#gid=1681720519", "_blank");
        history.go(-1);
        <%
                } else {
            %>
        window.open("https://docs.google.com/spreadsheets/d/e/2PACX-1vTwqkcmlYXVK7vk9CFlzybOt3rGMvH4nZl-F6_17J0sOpupucyVNCmS9vpogyyJDkm8ePbV3-hvKpqg/pubhtml", "_blank");
        history.go(-1);
        <%
                }
                %>

        function sendRedirect(addr) {
            window.location = addr;
        }
    </script>
</head>
</html>
