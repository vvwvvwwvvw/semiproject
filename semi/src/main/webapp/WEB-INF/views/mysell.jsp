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
					<button value="${sessionScope.member.m_id}">이력서보기</button>
				</div>
				<div class="detail-sub">
					<a href="mysellWrite">이력서작성</a>
				</div>
				<div class="detail-sub">
					<a href="mysellFrm">이력서수정</a>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
$("#mysellbtn").click(function() {
	location.href = `mysellDetail?s_id=${myDto.s_id} & m_id = ${sessionScope.member.m_id}`;
});
</script>
</html>
