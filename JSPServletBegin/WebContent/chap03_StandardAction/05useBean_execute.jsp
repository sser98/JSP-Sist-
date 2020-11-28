<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%@ page import="chap03.MemberDTO" %>   
    
<%
	// == MemberDTO 객체 생성하기 == //
	MemberDTO mbrdto1 = new MemberDTO(); 
	mbrdto1.setName("일순신");
    mbrdto1.setJubun("9710201234567");
    
    String name1 = mbrdto1.getName();
    String jubun1 = mbrdto1.getJubun();
    String gender1 = mbrdto1.getGender();
    int age1 = mbrdto1.getAge(); 
    
    
    MemberDTO mbrdto2 = new MemberDTO("이미자","9209202234567"); 
    
    String name2 = mbrdto2.getName();
    String jubun2 = mbrdto2.getJubun();
    String gender2 = mbrdto2.getGender();
    int age2 = mbrdto2.getAge(); 
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 표준액션 중 useBean 에 대해서 알아봅니다. </title>

<style type="text/css">
	div {margin: 20px;}
</style>

</head>
<body>
	<div>
		<h2>스크립틀릿을 사용하여 MemberDTO 클래스의 객체정보 불러오기</h2>	
		
		<ul>
			<li>성명 : <%= name1%></li>
			<li>주민번호 : <%= jubun1%></li>
			<li>성별 : <%= gender1%></li>
			<li>나이 : <%= age1%></li>
		</ul>
		
		<br>
		
		<ul>
			<li>성명 : <%= name2%></li>
			<li>주민번호 : <%= jubun2%></li>
			<li>성별 : <%= gender2%></li>
			<li>나이 : <%= age2%></li>
		</ul>
		
	</div>
	
	<hr style="border: solid 1px red;">
	
	<div>
		<h2>JSP 표준액션중 useBean 을 사용하여 MemberDTO 클래스의 객체 정보를 불러오기</h2>
		<jsp:useBean id="mbrdto3" class="chap03.MemberDTO"/>
		<jsp:setProperty property="name" name="mbrdto3" value="엄정화" /> 
		<jsp:setProperty property="jubun" name="mbrdto3" value="9010202234567" /> 	
		 	
		<ul>
			<li>성명 : <jsp:getProperty property="name" name="mbrdto3"/></li>
			<li>주민번호 : <jsp:getProperty property="jubun" name="mbrdto3"/></li>
			<li>성별 : <jsp:getProperty property="gender" name="mbrdto3"/></li>
			<li>나이 : <jsp:getProperty property="age" name="mbrdto3"/></li>
		</ul>
	</div>
</body>
</html>






