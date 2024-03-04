<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>Content Main</title>
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
<jsp:include page="header.jsp"/>
<div class = "wrap">

	<div class="content">
		<div class="list-title">
			<h2 class="form-header">구인 목록</h2>
			<button class="jf-btn" onclick="location.href='./jobFrm'">게시글등록</button>
		</div>
	
	<div class="data-area">
		<!-- 게시글 목록 출력 -->
		<c:if test="${empty sList}">
			<div class="content-item">
				<span class="none-content"> 등록된 게시글이 없습니다</span>
			</div>
		</c:if>
		<c:if test="${!empty sList}">
			<c:forEach var="contentitem" items="${sList}">
				<div class="content-item">
					<a href="detail?c_id=${contentitem.c_id}"> 
					<c:if test="${empty contentitem.p_sysname}">
							<img src="resources/images/no_image.jpg"
								class="poster-pre">
						</c:if>
						<c:if test = "${!empty contentitem.p_sysname}">
							<img src = "resources/upload/${contentitem.p_sysname}"
							class = "poster-pre">
						</c:if>
					</a>
					<div class ="info-pre">
					<div class ="title-pre">
						<a href="detail?c_id=${content.c_id}">
						${contentitem.c_name}
						</a>
					</div>
					<div class = "content-pre">${contentiteme.c_storename}</div>
					<div class = "content-pre">${contentiteme.c_day}</div>
					</div>
				</div>
			</c:forEach>
		</c:if>
	</div>
	<div class="paging-area">
		<div class="paging">${paging}</div>
	</div>
	</div>
	</div>
</body>
</html>
