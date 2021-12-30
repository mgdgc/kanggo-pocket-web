<%@ page import="model.Member" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2019-02-14
  Time: 19:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Member member = (Member) session.getAttribute("member");
%>
<!DOCTYPE HTML>
<html lang="ko" dir="ltr">
<head>
    <meta charset="utf-8">
    <title>회원 가입</title>
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
        <% if (member != null) { %>
        alert("이미 로그인 된 상태입니다.");
        history.go(-1);
        <% } %>

        function checkValid() {
            var name = document.getElementById("name").value;
            var id = document.getElementById("id").value;
            var pw = document.getElementById("pw").value;
            var pwCheck = document.getElementById("pwCheck").value;
            var email = document.getElementById("email").value;

            if (name === "" || id === "" || pw === "" || pwCheck === "" || email === "") {
                alert("양식을 모두 작성해주시기 바랍니다.");
                return false;
            } else {
                if (name.length > 10) {
                    alert("이름은 10자를 초과할 수 없습니다.");
                    return false
                }
                if (id.length > 20) {
                    alert("아이디는 20자를 초과할 수 없습니다.");
                    return false;
                }
                if (pw.length > 20) {
                    alert("비밀번호는 20자를 초과할 수 없습니다.");
                    return false;
                }
                if (pw !== pwCheck) {
                    alert("비밀번호가 다릅니다. 다시 확인해 주세요.");
                    return false;
                }
                return true;
            }
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
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/announce/announce.jsp">공지사항</a>
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
<div class="container shadow p-3 mb-5 bg-white rounded" style="margin-top: 60px; min-width: 200px; max-width: 720px;">
    <div class="container card-body">
        <p style="text-align: center; margin: 36px 8px;">
            강고 포켓 관리자는 오직 <b>개발자, 선생님, 그리고 인증된 관리 학생</b>만 가입 후 이용이 가능합니다.
            <br><br>아래 양식을 작성하고 회원 가입을 누르면 개발자 혹은 선생님께서 가입자의 신원을 확인 후 승인하게 됩니다.
            <br><br>이후 관리자 권한 레벨(1~3)에 따라 강고 포켓 관리자를 이용하실 수 있습니다.
        </p>
        <form method="post" action="${pageContext.request.contextPath}/auth/registration.jsp"
              onsubmit="return checkValid()">
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" class="form-control" name="name" id="name" aria-describedby="nameHelp"
                       placeholder="실명 기입">
                <small id="nameHelp" class="form-text text-muted">실명을 정확하게 기입하셔야 개발자나 선생님이 승인 요청을 허가할 수 있습니다.</small>
            </div>
            <div class="form-group">
                <label for="id">아이디</label>
                <input type="text" class="form-control" name="id" id="id">
            </div>
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="text" class="form-control" name="email" id="email" placeholder="예) example@email.com">
            </div>
            <div class="form-group">
                <label for="pw">비밀번호</label>
                <input type="password" class="form-control" name="pw" id="pw" placeholder="숫자, 영문자(대/ 소), 특수문자"
                       aria-describedby="pwHelp">
                <small id="pwHelp" class="form-text text-muted">비밀번호는 숫자, 영대/ 소문자, 특수문자를 모두 사용하여 예측할 수 없는 비밀번호를 사용하십시오.
                </small>
            </div>
            <div class="form-group">
                <label for="pwCheck">비밀번호</label>
                <input type="password" class="form-control" name="pwCheck" id="pwCheck" placeholder="비밀번호 다시 입력"
                       aria-describedby="pwCheckHelp">
            </div>
            <button type="submit" class="btn btn-outline-primary w-100 p-3" style="margin-top: 48px;">회원 가입</button>
        </form>
    </div>
</div>
</body>
</html>
