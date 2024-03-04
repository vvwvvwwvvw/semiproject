<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이력서 보기</title>
<link rel="stylesheet" href="resources/css/css.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"
	integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
	crossorigin="anonymous"></script>
</head>
<jsp:include page="header.jsp" />
<body>
	<div class="mysell-info">
		<h1>이 력 서</h1>
	</div>
	<div class="detail">
		<div class="detail-sub">
			<div class="mysell-title">
				<c:if test="${empty myDto.s_sysname }">
					<img class="poster" src="resources/images/no_image.jpg">
				</c:if>
				<c:if test="${!empty myDto.s_sysname}">
					<img class="poto" src="resources/upload/${myDto.s_sysname}">
				</c:if>
			</div>
			<div>
				이름:<span class="s_name">${myDto.s_name}</span><br> 나이:<span
					class="m_age"></span>
			</div>
			<div class="m_comment"></div>
			<div class="form-control" style="width: 1000px; height: 500px;">${myDto.s_contents}</div>
			거주지:
			<sapn class="s_address">${myDto.s_address}</sapn>
		</div>
	</div>



	<button type="button" id="updatebtn" class="btn btn-primary">수정</button>
	<button type="button" id="backbtn" class="btn btn-primary">뒤로가기</button>
</body>
<script>
	$("#backbtn").click(function() {
		location.href = `./mysell?pageNum=${pageNum}`;
	});

	$("#updatebtn").click(function() {
		location.href = `./mysellFrm?s_name=${myDto.s_name}`;
	});
</script>
</html>
