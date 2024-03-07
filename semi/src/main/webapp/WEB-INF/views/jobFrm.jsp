<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구인 글 작성 페이지</title>
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
	<jsp:include page="header.jsp" />
	<div class="wrap">
		<div class="content">
			<form action="jobProc" method="post" enctype="multipart/form-data">
				<h2 class="form-header">구인 등록</h2>
				<div class="filebox">
					<!-- 파일 입력 처리 영억 -->
					<label for="file">사진</label> <input type="file" name="files"
						id="file"> <input type="text" class="upload-name"
						value="파일선택" readonly>
				</div>
				<input type="text" class="write-input" name="c_name" autofocus
					placeholder="제목" required><br> <input type="text"
					class="write-input" name="c_storename" autofocus placeholder="상호명"
					required> <br> <input type="text" class="write-input"
					name="c_money" autofocus placeholder="시급" required><br>
				<input type="text" class="write-input" name="c_address" autofocus
					placeholder="주소" required> <br> <input type="text"
					class="write-input" name="c_day" autofocus placeholder="날짜"
					required> <br> <input type="text" class="write-input"
					name="c_time" autofocus placeholder="시간" required><br>
				<textarea rows="10" class="write-input ta" name="c_content"
					placeholder="상세내용"></textarea>

				<input type="hidden" class="write-input"
					value="${sessionScope.member.m_id}" name="m_id" autofocus
					placeholder="작성자">
				<div class="btn-area">
					<input type="submit" class="btn-write" value="등록"> <input
						type="reset" class="btn-write" value="수정"> <input
						type="button" class="btn-write" value="뒤로" id="backbtn">
				</div>
			</form>
		</div>
	</div>
</body>
<script>
	$("#backbtn").click(function() {
		location.href = `main?pageNum=${pageNum}`;
	});
</script>
</html>