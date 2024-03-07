<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
<link rel="stylesheet" href="resources/css/css.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"
	integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
	crossorigin="anonymous"></script>
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
}

.login-container {
	text-align: center; /* 로그인 폼 가운데 정렬 */
}

.login-form input[type="text"], .login-form input[type="password"],
	.login-form input[type="submit"] {
	width: 314px;
	height: 53px;
	margin-bottom: 15px;
	border: 1px solid #ccc;
	border-radius: 5px;
	padding: 10px;
	box-sizing: border-box;
}

.login-form input[type="submit"] {
	background-color: #FFA800; /* 로그인 버튼 색상 */
	color: white;
	font-weight: bold;
	cursor: pointer;
}
</style>
</head>
<script>
	$(function() {
		let msg = "${msg}";
		if (msg != "") {
			alert(msg);
		}
	});
</script>
<body>

	<!-- 로고 추가 -->
	<img src="resources/images/1-removebg-preview.png"
		alt="이미지가 로드되지 않았습니다." width="70" height="80"margin-bottom: 60px;>
	<!-- 문구 추가 -->
	<h1 style="text-align: center; margin-bottom: 120px;">펑크난 자리, 검증된
		인원이 채워드립니다</h1>

	<!-- 로그인 폼 -->
	<div class="login-container">
		<form action="login" method="post" class="login-form">
			<input type="text" name="m_id" placeholder="아이디를 입력해주세요."><br>
			<input type="password" name="m_pass" placeholder="비밀번호를 입력해주세요."><br>
			<input type="submit" value="로그인">
			<h2>
				<a href="join" style="color: black; text-decoration: none;">회원가입</a>
			</h2>
		</form>


			
	</div>
</body>
</html>