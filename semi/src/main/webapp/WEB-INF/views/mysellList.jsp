<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>이력서 리스트</title>
<link rel="stylesheet" href="resources/css/css.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"
	integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
	crossorigin="anonymous"></script>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class = "wrap">
	<div class="content">
		<div class="list-title">
			<h2 class="form-header">이력서 목록</h2>
			<button class="jf-btn" onclick="location.href='./mysellWrite'">이력서 등록</button>
		</div>
		<div class="data-area">
		<!-- 게시글 목록 출력 -->
		<c:if test="${empty mList}">
			<div class="content-item">
				<span class="none-content"> 등록된 이력서가 없습니다</span>
			</div>
		</c:if>
		<c:if test ="${sessionScope.member.m_id eq myDto.m_id}">
		<c:if test="${!empty mList}">
			<c:forEach var="myDtoitem" items="${mList}">

				<div class="content-item">
					<a href="mysellDetail?s_id=${myDtoitem.s_id}"> 
					<c:if test="${empty myDtoitem.s_sysname}">
							<img src="resources/images/no_image.jpg"
								class="poster-pre">
						</c:if>
						<c:if test = "${!empty myDtoitem.s_sysname}">
							<img src = "resources/upload/${myDtoitem.s_sysname}"
							class = "poster-pre">
						</c:if>
					</a>
					<div class ="info-pre">
					<div class ="title-pre">
						<a href="mysellDetail?s_id=${myDto.s_id}">
						${myDtoitem.s_name}
						</a>
					</div>
					</div>
				</div>
			</c:forEach>
			</c:if>
		</c:if>
	</div>
	</div>
	
	<div class="paging-area">
		<div class="paging">${paging}</div>
	</div>
	</div>
</body>


</html>
