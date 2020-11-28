<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의 메뉴</title>

<link rel="stylesheet" type="text/css" href="css/style.css" />

</head>
<body>

	<h3>오늘의 메뉴</h3>
	<ol style="list-style-type: decimal-leading-zero;">
		<li>햄버거 5,000원</li>
		<li>짜장면 5,000원</li>
		<li>짬뽕    6,000원</li>
		<li>팔보채 8,000원</li>
	</ol>
	<div id="today">
		현재시각 : <%@ include file="04todayTime_1.jsp" %> 
		<%-- include 지시어인 <%@ include %> 을 사용하여 파일을 불러와서 파일의 결과값을 끼워넣는다. --%>
	</div>
</body>
</html>


