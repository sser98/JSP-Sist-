<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<%-- 필요한 클래스를 import 하려면 <%@ page %>  page directive(페이지 지시어)를 사용하여 import 를 한다. --%>  
<%@ page import="java.util.Date , java.text.SimpleDateFormat" %>  
    
<%
    //*** 현재시각을 알아오기 *** //
	Date now = new Date(); // 현재시각 
	
	SimpleDateFormat sdfrmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String today = sdfrmt.format(now);
	
	// === 또는 === 
	String currentTime = String.format("%tF %tT %tA",now,now,now); 
	/*
    <참고>
	   날짜 타입 format         설명
	  --------------------------------------------------
        %tF              날짜를 yyyy-mm-dd 형식으로 포맷해주는 것
		%tT              날짜의 시각을 HH:MM:SS 형식으로 포맷해주는 것  
        %tp              오전, 오후를 출력
		%tA              요일명 출력
		%tY              4자리 년도만 출력
        %tB              월의 이름(January, February ...)출력
		%tm              월의 01,02,03 ~~ 10,11,12 로 출력
		%td              일수를 1~31 로 출력
		%te              %td와 동일함
		%tk              시간을 0~23 으로 출력
        %tl              시간을 1~12 으로 출력
		%tM              분을 00~59 으로 출력
        %tS              초를 00~59 으로 출력
		%tZ              타임존을 출력(한국은 KST로 나옴).
	*/	
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>java 에서 날짜와 현재시각을 알아본다.</title>
</head>
<body>
	<ul>
		<li>오늘의 날짜 및 시각 : <%= today%></li>
		<li>오늘의 날짜 및 시각 및 요일명 : <%= currentTime%></li>
	</ul>
</body>
</html>