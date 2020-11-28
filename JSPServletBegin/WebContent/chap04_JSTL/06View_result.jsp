<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- ===== JSTL(JSP Standard Tag Library) 사용하기 ===== --%>       
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>      
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>친구명단 출력하기</title>
</head>
<body>

	<h2>친구명단</h2>
	
	<c:if test="${empty myfriends}">
		<span>친구가 없으시군요~~^_____^</span>
	</c:if>
	
	<c:if test="${not empty myfriends}">
		<c:set var="arrFriends" value="${ fn:split(myfriends, ',') }" />
		
		<ol>
			<c:forEach var="name" items="${arrFriends}">
				<li>${name}</li>
			</c:forEach>
		</ol>
	</c:if>
	
	<hr style="border: solid 1px red;" >
	
	<c:if test="${empty mymembers}">
		<span>등록된 회원이 없습니다</span>
	</c:if>
	
	<c:if test="${not empty mymembers}">
		<ul>
			<c:forTokens var="name" items="${mymembers}" delims=",">
				<li>${name}</li>
			</c:forTokens>
		</ul>
	</c:if>
	
	<hr style="border: solid 1px blue;" >
	
	<c:if test="${empty myheowons}">
		<span>등록된 회원이 없습니다</span>
	</c:if>
	
	<c:if test="${not empty myheowons}">
		<ul>
			<c:forTokens var="name" items="${myheowons}" delims=",./">
			<%-- ${myheowons} 은 하나의 문자열인데 구분자를 , 또는 . 또는 / 를 사용하여 하나하나씩 잘라서 배열로 나타내어줌 --%> 
				<li>${name}</li>
			</c:forTokens>
		</ul>
	</c:if>
	
</body>
</html>



