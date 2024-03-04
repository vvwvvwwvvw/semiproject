<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=IBM+Plex+Sans+KR&display=swap"
	rel="stylesheet">
<meta charset="UTF-8">
<title>구직정보 상세보기</title>
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
		}
	});
</script>
<body>
	<jsp:include page="header.jsp" />
	<div class="wrap">
		<!-- 게시글 상세 내용 출력(div) -->
		<div class="detail">
			<div class="detail-sub">
				<div class="detail-content">
					<c:if test="${empty content.p_sysname}">
						<img class="poster" src="resources/images/no_image.jpg">
					</c:if>
					<c:if test="${!empty content.p_sysname}">
						<img class="poster" src="resources/upload/${content.p_sysname}">
					</c:if>
				</div>
			</div>
		</div>
		<div class="detail">
			<div class="detail-sub">
				<div class="detail-title">제목</div>
				<div class="detail-content">${content.c_name}</div>
			</div>
			<div class="detail-sub">
				<div class="detail-title">상호</div>
				<div class="detail-content">${content.c_storename}</div>
			</div>
			<div class="detail-sub">
				<div class="detail-title">내용</div>
				<div class="detail-content">${content.c_content}</div>
			</div>
			<div class="detail-sub">
				<div class="detail-title">시급</div>
				<div class="detail-content">${content.c_money}</div>
			</div>
			<div class="detail-sub">
				<div class="detail-title">주소</div>
				<div class="detail-content">${content.c_address}</div>
			</div>
			<div class="detail-sub">
				<div class="detail-title">날짜</div>
				<div class="detail-content">${content.c_day}</div>
			</div>
			<div class="detail-sub">
				<div class="detail-title">시간</div>
				<div class="detail-content">${content.c_time}</div>
			</div>
			<div class="btn-area">
				<button class="btn-write" id="upbtn">수정</button>
				<button class="btn-write" id="delbtn">삭제</button>
				<button class="btn-sub" id="backbtn">뒤로</button>
				<form action="apply" method="post">
				<button class="btn-write" id="applybtn">지원하기</button>
				</form>
				
				<button class="btn-write" id="applyContactbtn">지원자 확인</button>
				
			</div>

		</div>
	</div>
</body>
<script>
	$("#upbtn").hide();
	$("#delbtn").hide();
	$("#applybtn").hide();
	$("#applyContactbtn").hide();
	
	let mid = '${member.m_id}';
	let cid = '${content.m_id}';
	
	
	
	if(mid == cid){
		$("#upbtn").show();
		$("#delbtn").show();
		$("#applyContactbtn").show();	
	}else{
		$("#applybtn").show();
	}

	
	
	$("#backbtn").click(function() {
		location.href = `main?pageNum=${pageNum}`;
	});

	$("#upbtn").click(function() {
		location.href = `./updateFrm?c_id=${content.c_id}`;
	});

	//게시글 삭제
	$("#delbtn").click(function() {
		let conf = confirm("삭제할까요?");
		if (conf) {
			location.href = `./delete?c_id=${content.c_id}`;
		}	
	});

	// 지원자 확인 페이지로 이동
	$("#applyContactbtn").click(function() {
		location.href = `./applyList?pageNum=${pageNum}`;
	});
	
	$("#applybtn").click(function(){
		location.href = `./apply?c_id=${content.c_id}&c_storename=${content.c_storename}&m_id=${member.m_id}`
	});
</script>
</html>