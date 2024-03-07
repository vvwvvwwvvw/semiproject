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
<script>
	$(function() {
		let msg = "${msg}";
		if (msg != "") {
			alert(msg);
		}
	});
</script>
<body>
	<jsp:include page="header.jsp" />
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
					class="s_age">${myDto.s_age}</span><br> 거주지:<span
					class="s_address">${myDto.s_address}</span>
				<div class="s_comment">
					내용:
					<div class="form-control" style="width: 40%; height: 80%;">${myDto.s_contents}</div>

				</div>
			</div>
		</div>
	</div>

	<button type="button" id="updatebtn" class="btn-write">수정</button>
	<button type="button" id="backbtn" class="btn-write">뒤로가기</button>
	<button type="button" id="Writebtn" class="btn-write" onclick="location.href='./mysellWrite'">이력서 작성</button>
</body>
<script>
	$("#Writebtn").hide();
	
	if(${myDto.s_id} == null){
		
		$("#Writebtn").show();
	}

	$("#backbtn").click(function() {
		location.href = `./mysell?pageNum=${pageNum}`;
	});

	$("#updatebtn").click(function() {
		location.href = `./mysellFrm?s_id=${myDto.s_id}`;
	});
</script>
</html>
