<%@ page import="model.Member" %><%--
  Created by IntelliJ IDEA.
  User: RiD
  Date: 2019-02-22
  Time: 14:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Member member = (Member) session.getAttribute("member");

    String type = request.getParameter("type");
    if (type == null) {
        type = "file";
    }

    int maxImgSize = 5;
    int maxFileSize = 10;
%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
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

        function checkFileSize(file) {
            var fileUpload = file.files;

            fileChecked = true;

            if (file.id === "fileUpload") {
                if (fileUpload.length > 2) {
                    alert("파일은 2개까지 첨부할 수 있습니다.");
                    file.value = null;
                    setFileLabel(file);
                    return false;
                }
            } else {
                if (fileUpload.length > 5) {
                    alert("이미지는 5개까지 첨부할 수 있습니다.");
                    file.value = null;
                    setFileLabel(file);
                    return false;
                }
            }

            // 업로드 용량 확인
            for (var j = 0; j < fileUpload.length; j++) {
                if (file.id === "fileUpload") {
                    if (fileUpload[j].size / 1024 / 1024 > <%=maxFileSize%>) {
                        alert("파일의 용량은 <%=maxFileSize%>MB를 초과할 수 없습니다.");
                        file.value = null;
                        setFileLabel(file);
                        return false;
                    }
                } else {
                    if (fileUpload[j].size / 1024 / 1024 > <%=maxImgSize%>) {
                        alert("사진의 용량은 <%=maxImgSize%>MB를 초과할 수 없습니다.");
                        file.value = null;
                        setFileLabel(file);
                        return false;
                    }
                }
            }

            setFileLabel(file);

            return true;
        }

        function setFileLabel(file) {
            var filenames = "파일 선택";

            for (var a = 0; a < file.files.length; a++) {
                if (a === 0) filenames = "";
                if (filenames.length > 30) {
                    filenames += "...";
                    break
                }
                if (a > 0 && (a - 1) < file.files.length) {
                    filenames += ", ";
                }
                filenames += file.files[a].name;
            }

            if (file.id === "fileUpload") {
                document.getElementById("label_file").innerHTML = filenames;
            } else {
                document.getElementById("label_img").innerHTML = filenames;
            }
        }
    </script>
</head>
<body>

<div class="container shadow p-3 mb-5 bg-white rounded" style="min-width: 200px; max-width: 720px;">
    <div class="container card-body">
        <form action="${pageContext.request.contextPath}/file/file_upload.jsp" method="post"
              onsubmit="return checkValid()" enctype="multipart/form-data">
            <div class="card card-body">
                <% if (type.equals("img")) {%>
                <label for="inputGroupImgAddon">이미지 첨부</label>
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="inputGroupImgAddon">업로드</span>
                    </div>
                    <div class="custom-file">
                        <input type="file" class="custom-file-input" id="imgUpload" name="img"
                               aria-describedby="inputGroupImgAddon01" onchange="checkFileSize(this)"
                               size="<%=maxImgSize%>" accept="image/*">
                        <label id="label_img" class="custom-file-label" for="imgUpload">파일 선택</label>
                    </div>
                </div>
                <small id="imgHelp" class="form-text text-muted">이미지는 <%=maxImgSize%>MB까지 업로드가 가능합니다.</small>
                <% } else { %>
                <label for="inputGroupFileAddon">파일 첨부</label>
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="inputGroupFileAddon">업로드</span>
                    </div>
                    <div class="custom-file">
                        <input type="file" class="custom-file-input" id="fileUpload" name="file"
                               aria-describedby="inputGroupFileAddon01" onchange="checkFileSize(this)"
                               size="<%=maxFileSize%>">
                        <label id="label_file" class="custom-file-label" for="fileUpload">파일 선택</label>
                    </div>
                </div>
                <small id="fileHelp" class="form-text text-muted">파일은 <%=maxFileSize%>MB까지 업로드가 가능합니다.</small>
                <% } %>
            </div>

            <button type="submit" class="btn btn-outline-primary w-100 p-3"
                    style="margin-top: 24px;">업로드
            </button>
        </form>
    </div>
</div>

</body>
</html>
