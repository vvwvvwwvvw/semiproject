<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이력서 수정</title>
			<link rel="stylesheet" href="resources/css/css.css">
			<script src="https://code.jquery.com/jquery-3.6.1.min.js"
			integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
			crossorigin="anonymous"></script>
			<script>
			    $(function () {
            let m = "${msg}";
            if(m != ""){
                alert(m);
            }
            
          	//파일 업로드 시 선택한 파일명 출력
            $("#file").on("change", function () {
                //파일 입력창(input type=file)에서 파일 목록 가져오기
                let files = $("#file")[0].files;
                console.log(files);

                let fileName = "";

                if(files.length == 1) {
                    fileName = files[0].name;
                }
                else {//파일 선택 창에서 '취소' 버튼을 클릭
                    fileName = "파일선택";
                }

                $(".upload-name").val(fileName);
            });
        });
		</script>
</head>
<body>
	<jsp:include page="header.jsp" />

          <h1>이력서 수정<h1>      
	<form action="myUpdate" method="post" enctype="multipart/form-data">
          <div class="form-group">
            <input type="text"  class="write-input" id="s_name" name="s_name" value="${myDto.s_name}"
            style="width: 450px;" placeholder="사장님들에게 노출될 이름을 입력해주세요" readonly>
          </div>
          <div class="form-group">
            <textarea class="write-input ta" id="s_contents" name="s_contents" rows="3"
            style="width: 1000px; height: 500px;" rows="10" cols="50" placeholder="본인 어필" required>${myDto.s_contents}</textarea>
          </div>
          <div class="form-group">
            <input type="text"  class="write-input" id="s_address" name="s_address" value="${myDto.s_address}" 
            style="width: 450px;" placeholder="거주지를 입력해 주세요" required>
            </div>
            	<div class="filebox">
					<!-- 파일 입력 처리 영억 -->
					<label for="file">사진</label>
					 <input type="file" name="files" id="file">
						 <input type="text" class="upload-name"
						value="파일선택" style="width: 450px;" readonly>
				</div>
          <input type="submit" class="btn-write" id="updatebtn" value="수정완료">
          <button class="btn-write"  id="backbtn">뒤로가기</button>
      	</form>
      	
</body>
</html>
