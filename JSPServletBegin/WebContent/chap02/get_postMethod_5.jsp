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
<title>GET/POST방식으로 데이터전송하기</title>

<style type="text/css">
	ul {list-style: none;}
	li {line-height: 200%;}
</style>

</head>
<body>

<%-- 
<form name="memberFrm" action="/JSPServletBegin/getpostMethod_5.do" method="get">
  또는
<form name="memberFrm" action="<%= request.getContextPath()%>/getpostMethod_5.do" method="get"> 
  또는
--%>
<form name="memberFrm" action="<%= ctxPath%>/getpostMethod_5.do" method="post">
<%-- 
     submit 을 하면 <%= ctxPath%>/getpostMethod_5.do 로 보내어서 처리를 요청한다.
         이번에는 /JSPServletBegin/getpostMethod_5.do 을 처리해주는 매핑작업을 배치서술자인 web.xml 을 사용하지 않고 
     @WebServlet 어노테이션을 사용하여 매핑되도록 한다.     
--%>
	<fieldset>
		<legend>개인성향 테스트(GET/POST method)</legend>
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