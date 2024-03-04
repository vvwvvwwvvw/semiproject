<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Select Page</title>
    <style>
        body {
            background-color: #FFDEDE; /* 배경색 설정 */
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column; /* 컨테이너의 주축 방향을 세로로 변경 */
            align-items: center;
            justify-content: center; /* 화면 수직 중앙 정렬 */
            height: 100vh;

    </style>
</head>
<body>

<!-- 로고 추가 -->
<img src="resources/images/1-removebg-preview.png" alt="이미지가 로드되지 않았습니다." width="70" height="80" margin-bottom: 60px;>
<!-- 문구 추가 -->
<h1 style="text-align: center; margin-bottom: 120px;">펑크난 자리, 검증된 인원이 채워드립니다</h1>


<!--  회원 로그인  -->
<div style="position: fixed; bottom: 30%; width: 100%; text-align: center;">
    <h2><a href="./login" style="color: black; text-decoration: none;">로그인</a></h2>
</div>
<!-- 회원가입으로 가는 하이퍼링크 -->
<div style="position: fixed; bottom: 25%; width: 100%; text-align: center;">
    <h2><a href="./join" style="color: black; text-decoration: none;">회원가입</a></h2>
</div>

</body>
</html>