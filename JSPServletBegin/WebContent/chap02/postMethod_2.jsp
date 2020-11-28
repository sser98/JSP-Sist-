<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 컨텍스트명(context name)을 알아오고자 한다.
    String ctxPath = request.getContextPath();

 // System.out.println("ctxPath => " + ctxPath);
                     // ctxPath => /JSPServletBegin
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>POST방식으로 데이터전송하기</title>

<style type="text/css">
	ul {list-style: none;}
	li {line-height: 200%;}
</style>

</head>
<body>

<%-- 
<form name="memberFrm" action="/JSPServletBegin/postMethod_2.do" method="post">
  또는
<form name="memberFrm" action="<%= request.getContextPath()%>/postMethod_2.do" method="post"> 
  또는
--%>
<form name="memberFrm" action="<%= ctxPath%>/postMethod_2.do" method="post">
<%-- 
     submit 을 하면 <%= ctxPath%>/postMethod_2.do 로 보내어서 처리를 요청한다.
     /JSPServletBegin/postMethod_2.do 은 누가 처리를 해주는지 배치서술자인 web.xml 에 기술되어져 있어야 한다.
	 web.xml 에 가보면 <servlet-mapping>에 URL 패턴으로 /postMethod_2.do 가 기술되어져 있고,
	  이어서 실제로 처리를 해주는 <servlet-class>에 클래스명이 기술되어져 있다.
	  바로 이렇게 기술되어진 <servlet-class>클래스명이 action 일처리를 해주게 된다.
	     
	 !!! 아주 중요한 것은 web.xml은 언제 읽어들이는냐? 하면
	 WAS가 구동되어질때 딱 1번만 읽어들여서 WAS가 web.xml에 기술된 내용을 기억하도록 되어있다.
	  그러므로 web.xml에 내용을 추가하거나 삭제하는 등 변경되어지면 변경된 내용대로 작동하기 위해서는 반드시 WAS를 껐다가 켜야만 한다. !!!    
--%>
	<fieldset>
		<legend>개인성향 테스트(POST method)</legend>
		<ul>
			<li>
				<label for="name">성명</label>
				<input type="text" name="name" id="name" placeholder="성명입력"/> 
			</li>
			<li>
				<label for="school">학력</label>
				<select name="school" id="school">
					<option value="고졸">고졸</option>
					<option value="초대졸">초대졸</option>
					<option value="대졸">대졸</option>
					<option value="대학원졸">대학원졸</option>
				</select>
			</li>
			<li>
				<label for="">좋아하는 색상</label>
				<div>
					<label for="red">빨강</label>
					<input type="radio" name="color" id="red" value="red" />
					
					<label for="blue">파랑</label>
					<input type="radio" name="color" id="blue" value="blue" />
					
					<label for="green">초록</label>
					<input type="radio" name="color" id="green" value="green" />
					
					<label for="yellow">노랑</label>
					<input type="radio" name="color" id="yellow" value="yellow" />
				</div>
			</li>
			<li>
				<label for="">좋아하는 음식(다중선택)</label>
				<div>
				    <label for="food1">짜짱면</label>
					<input type="checkbox" name="food" id="food1" value="짜짱면" />
					&nbsp;
					
					<label for="food2">짬뽕</label>
					<input type="checkbox" name="food" id="food2" value="짬뽕" />
					&nbsp;
					
					<label for="food3">탕수육</label>
					<input type="checkbox" name="food" id="food3" value="탕수육" />
					&nbsp;
					
					<label for="food4">양장피</label>
					<input type="checkbox" name="food" id="food4" value="양장피" />
					&nbsp;
					
					<label for="food5">팔보채</label>
					<input type="checkbox" name="food" id="food5" value="팔보채" />
				</div>
			</li>
			<li>
				<input type="submit" value="전송" />
				<input type="reset" value="취소" />
			</li>
		</ul>
	</fieldset>
</form>

</body>
</html>