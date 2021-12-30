<%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2019-02-17
  Time: 16:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 가입 완료</title>
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:300,700" rel="stylesheet">
    <link href="../css/style.css" type="text/css" rel="stylesheet"/>
    <style>
        * {
            text-align: center;
        }
    </style>
</head>
<body>
<header>
    <h1>회원 가입 완료</h1>
</header>
<div class="wrap">
    <p>
        회원 가입이 완료되었습니다.
        <br><br>선생님이나 개발자가 관리자 등록을 승인하면 서비스를 이용하실 수 있습니다.
        <br><br>관리자 등록 승인이 늦어진다면 개발자 혹은 선생님께 문의해 주십시오.
        <br>빠르게 확인 후 대처해드리겠습니다.
    </p>
    <a href="${pageContext.request.contextPath}/index.jsp">홈으로 이동</a>
</div>
</body>
</html>
