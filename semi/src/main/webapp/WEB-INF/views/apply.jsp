<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>지원 리스트</title>
<link rel="stylesheet" href="resources/css/css.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"
	integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
	crossorigin="anonymous"></script>
</head>
<body>
	<jsp:include page="header.jsp" />
	
		<!-- 게시글 목록 출력 -->
		<c:if test="${empty aList}">
			<div class="content-item">
				<span class="none-content"> 지원한 업체가 없습니다</span>
			</div>
		</c:if>
		<c:if test="${!empty aList}">
			<c:forEach var="applyitem" items="${aList}">
				<div class="apply-item">
					<a href="applyList?c_id=${applyitem.c_id}"> 
					<c:if test="${empty applyitem.p_sysname}">
							<img src="resources/images/no_image.jpg"
								class="poster-pre">
						</c:if>
						<c:if test = "${!empty applyitem.p_sysname}">
							<img src = "resources/upload/${applyitem.s_sysname}"
							class = "poster-pre">
						</c:if>
					</a>
					<div class ="info-pre">
					<div class ="title-pre">
						<a href="mysellDetail?c_id=${apply.c_id}">
						${applyitem.c_name}
						</a>
					</div>
					<div class = "content-pre">${applyitem.c_storename}</div>
					</div>
				</div>
			</c:forEach>
		</c:if>
	
	<div class="paging-area">
		<div class="paging">${paging}</div>
	</div>
	
</body>
</html>
</html>