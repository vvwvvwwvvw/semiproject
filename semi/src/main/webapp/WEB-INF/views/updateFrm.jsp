<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정페이지</title>
<link rel="stylesheet" href="resources/css/css.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"
	integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
	crossorigin="anonymous"></script>
<script>
	$(function() {
		let m = "${msg}";
		if (m != "") {
			alert(m);
		}

		//파일 업로드 시 선택한 파일명 출력
		$("#file").on("change", function() {
			//파일 입력창(input type=file)에서 파일 목록 가져오기
			let files = $("#file")[0].files;
			console.log(files);

			let fileName = "";

			if (files.length == 1) {
				fileName = files[0].name;
			} else {//파일 선택 창에서 '취소' 버튼을 클릭
				fileName = "파일선택";
			}

			$(".upload-name").val(fileName);
		});
	});
</script>
</head>
<body>
	<div class="wrap">
		<jsp:include page="header.jsp" />
		<div class="content">
			<form action="updateProc" method="post" enctype="multipart/form-data">
				<h2 class="form-header">구인 정보 수정</h2>
				<input type="hidden" name="c_id" value="${content.c_id}"><br> <input
					type="text" class="write-input" value="${content.c_name}"
					name="c_name" autofocus placeholder="제목" required> <br><input
					type="text" class="write-input" value="${content.c_storename}"
					name="c_storename" placeholder="상호명" required><br> <input
					type="text" class="write-input" value="${content.c_money}"
					name="c_money" placeholder="시급" required><br><input
					type="text" class="write-input" value="${content.c_address}"
					name="c_address" placeholder="주소" required><br> <input
					type="text" class="write-input" value="${content.c_day}"
					name="c_day" placeholder="날짜" required><br> <input type="text"
					class="write-input" value="${content.c_time}" name="c_time"
					placeholder="시간" required><br>
				<textarea rows="10" class="write-input ta" name="c_content"
					placeholder="상세내용">${content.c_content}</textarea><br>
				<input type="hidden" value="${content.p_sysname}" name="p_sysname">
				<div class="daetail">
					<div class="detail-sub">
						<div class="detail-title">업체 사진</div>
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
				<div class="filebox">
					<!-- 수정파일 입력 처리 영역 -->
					<label for="file">업로드</label> <input type="file" name="files"
						id="file" multiple>
				</div>
				<div class="btn-area">
					<input type="submit" class="btn-write" value="업로드"> <input
						type="reset" class="btn-write" value="삭제"> <input
						type="button" class="btn-write" value="뒤로" id="backbtn">
				</div>
			</form>
		</div>
	</div>
</body>
<script>
	$("#backbtn").click(function() {
		location.href = `./detail?c_id=${content.c_id}`;
	});
</script>

</html>