<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>자기 소개 페이지</title>
<link rel="stylesheet" href="resources/css/css.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"
	integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
	crossorigin="anonymous"></script>
</head>
<script>
$(function() {
	let m = "${msg}";
	if (m != "") {
		alert(m);
	}</script>
<body>
	<jsp:include page="header.jsp" />
	<div class="wrap">
		<div class="mysell-home">
			<div class="detail">
				<div class="detail-sub" id = "mysellbtn">
				<form action="submit" method="get">
					<a href = "mysellDetail?s_id=${s_id}">이력서보기</a>
					<input type="hidden" name="s_id" value="${sessionScope.member.m_id}">
				</form>
				</div>
				<div class="detail-sub">
					<button class="btn-write" onclick="location.href='./mysellWrite'">이력서작성</button>
				</div>
				<div class="detail-sub">
					<button class="btn-write" onclick='location.href="./mysellFrm?s_id=${s_id}"'>이력서수정</button>
				</div>
			</div>
		</div>
	</div>
</body>

</html>
