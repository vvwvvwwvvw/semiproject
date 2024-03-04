<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<link rel="stylesheet" href="resources/css/css.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"
	integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
	crossorigin="anonymous"></script>
</head>
<body>
<div class = "wrap">
<jsp:include page="header-log.jsp"/>
<h1>회원가입</h1>
<form id="joinForm" action="join" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <div class="form-group">
        
            <input type="text" id="m_id" name="m_id" placeholder="아이디 (4~15자 영문,숫자)" required>
            <button type="button" id="checkIdBtn">중복확인</button>
            <span id="id-error-message">${error}</span>
        </div>
        <div class="form-group">
            <input type="password" id="m_pass" name="m_pass" placeholder="비밀번호 (8~15자 영문/숫자 또는 특수문자 조합)" required>
            <span id="pw-error-message"></span>
        </div>
        <div class="form-group">
            <input type="password" id="m_passConfirm" name="m_passConfirm" placeholder="비밀번호 재입력" required>
            <span id="pw-confirm-error-message"></span>
        </div>
        <div class="form-group">
            <input type="text" id="m_name" name="m_name" placeholder="이름" required>
        </div>
        <div class="form-group">
            <input type="text" id="m_birth" name="m_birth" placeholder="생년월일" required>
        </div>
        <button type="submit" id="joinSubmitBtn" disabled>가입하기</button>
    </form>
</div>
</body>
<script>
function validateMemberId() {
	  const m_id = document.getElementById("m_id").value;
	  const regExp = /^[a-zA-Z0-9]{4,15}$/;

	  if (!regExp.test(m_id)) {
	    m_idError.innerText = "아이디 형식이 올바르지 않습니다.";
	    return false;
	  }

	  return true;
	}
$(function() {
    // 아이디 중복 확인
    $("#checkIdBtn").on("click", function() {
        let m_id = $("#m_id").val();
        if (m_id === "") {
            alert("아이디를 입력해주세요 !");
            return;
        }

        $.ajax({
            url: "checkDuplicateId",
            method: "POST",
            data: { "m_id": m_id },
            success: function(data) {
                console.log(data);
                if (data == "fail") {
                    $("#id-error-message").text("이미 사용 중인 아이디입니다.");
                    $("#joinSubmitBtn").prop("disabled", true);
                } else {
                    $("#id-error-message").text("사용가능한 아이디입니다.");
                    $("#joinSubmitBtn").prop("disabled", false);
                }
            },
            error: function(error) {
                console.log(error); 
            }
        });
    });

    // 비밀번호 일치 여부 확인
    $("#m_pass, #m_passConfirm").on("keyup", function() {
        let password = $("#m_pass").val();
        let confirmPassword = $("#m_passConfirm").val();

        if (password !== confirmPassword) {
            $("#pw-confirm-error-message").text("비밀번호가 일치하지 않습니다.");
            $("#joinSubmitBtn").prop("disabled", true);
        } else {
            $("#pw-confirm-error-message").text("비밀 번호가 일치합니다!");
            $("#joinSubmitBtn").prop("disabled", false);
        }
    });
});
</script>
</html>
