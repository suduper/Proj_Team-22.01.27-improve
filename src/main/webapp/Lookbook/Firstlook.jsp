<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로파이</title>
<link rel="stylesheet" href="../style/style_index.css">
<style>

img {
 max-width: 100%;
}
</style>
</head>
<body>

<%@include file="../Main/Main_Top.jsp" %>
    <div id="wrap">
    <!-- HTML템플릿(Template, Templet) 헤더 시작 -->

           <%=uID %>
    <%=authority %>

<!-- HTML템플릿(Template, Templet) 헤더 끝 -->

        <main id="main">
        <h1 style="text-align: center;">21FW LOOKBOOK</h1>
        <br><br>
            <div style="text-align: center;">
            <p><img src="../Lookbook/firstimg/1.jpg" alt=""></p>
            <p><img src="../Lookbook/firstimg/2.jpg" alt=""></p>
            <p><img src="../Lookbook/firstimg/3.jpg" alt=""></p>
            <p><img src="../Lookbook/firstimg/4.jpg" alt=""></p>
            <p><img src="../Lookbook/firstimg/5.jpg" alt=""></p>
            <p><img src="../Lookbook/firstimg/6.jpg" alt=""></p>
            <p><img src="../Lookbook/firstimg/7.jpg" alt=""></p>
            <p><img src="../Lookbook/firstimg/8.jpg" alt=""></p>
            <p><img src="../Lookbook/firstimg/9.jpg" alt=""></p>
            <p><img src="../Lookbook/firstimg/10.jpg" alt=""></p>
            </div>
        </main>

<!-- HTML템플릿(Template, Templet) 푸터 시작 -->
        
    <!-- HTML템플릿(Template, Templet) 푸터 끝 -->
    </div>
 <%@include file="../Main/Main_Bottom.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../script/jquery-3.6.0.min.js"></script>
<script src="../script/script_main.js"></script>
</body>
</html>