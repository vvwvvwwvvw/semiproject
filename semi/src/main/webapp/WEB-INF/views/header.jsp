<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="resources/css/css.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"
	integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
	crossorigin="anonymous"></script>
<div class="top-bar">
	<img onclick="location.href='./main'" alt="로고"
		src="resources/images/1-removebg-preview.png" class="logo">
</div>
<div class="top-bar" id="main">
	<h4 class="title">소소한 심부름</h4>
	<div class="select-form" id="login_session">
		<div class="logout-btn">
			<h5>${member.m_name} 님 환영합니다</h5>
			<form action="logout" method="post">
				<input type="submit" value="로그아웃">
		</form>
		</div>
	</div>
</div>
<ul>
	<li><a href="mysell">자기소개 하기</a></li>
</ul>

<script>
	$(function() {
		let msg = "${msg}";
		if (msg != "") {
			alert(msg);
		}
	});

	$(document).ready(function() {
		// 로그인 여부 확인
		var isLoggedIn = $
		{
			sessionScope.member
		}
		;

		if (isLoggedIn != null) {
			$("#login_session").show();
		} else {
			$("#login_session").hide();
		}
		console.log(isLoggedIn)
		// 로그아웃 버튼 클릭 이벤트 처리
		$("#logout").click(function(event) {
			event.preventDefault();

			// 로그아웃 요청을 보내는 코드
			$.ajax({
				url : "/logout",
				method : "POST",
				success : function(response) {
					if (response.success) {
						// 로그아웃 성공 시 처리
						window.location.href = "/login";
					} else {
						// 로그아웃 실패 시 처리
						alert(response.message);
					}
				}
			});
		});
	});
	function ${m_name}() {
		const nowUser = sessionScope.member(m_name);
		if(nowUser != null){
			nowUser.show
	}
</script>



