<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 표준액션 중 include 에 대해서 알아봅니다.</title>
</head>
<body>
	<h3>책소개</h3>
	도서명 : 삼국지<br/>
	저자 : 이순신<br/>
	페이지: 300페이지<br/>
	<div>
		<%@ include file="01includeContent.jsp" %>
	</div>
	<div>
		<jsp:include page="01includeContent.jsp" />
	</div>
	가격: 20,000원<br/>
</body>
</html>