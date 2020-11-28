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
<title>form 태그를 사용한 데이터 전송시 useBean 사용하기</title>

<style type="text/css">
	ul {list-style: none;}
	li {line-height: 200%;}
</style>

<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>

<script type="text/javascript">

	$(document).ready(function() {
		
		$("form[name=memberFrm]").submit(function(){
			
			// 1. 성명은 필수입력 검사
			var nameLength = $("input:text[id=name]").val().trim().length;
			// alert(nameLength);
			
			if(nameLength == 0) {
				alert("성명을 입력하세요!!");
				return false; // submit 을 하지 않고 종료한다.
			}
			
			// 2. 학력도 필수입력 검사
			var schoolVal = $("select[id=school]").val();
			if(schoolVal == "") {
				alert("학력을 선택하세요!!");
				return false; // submit 을 하지 않고 종료한다.
			}
			
			// 3. 색상도 필수입력 검사
			var colorLength = $("input:radio[name=color]:checked").length;
			if( colorLength == 0 ) {
				alert("색상을 선택하세요!!");
				return false; // submit 을 하지 않고 종료한다.
			}
			
			// 4. 음식도 필수입력 검사
			var foodLength = $("input:checkbox[name=food]:checked").length;
			if( foodLength == 0 ) {
				alert("선호하는 음식을 최소한 1개 이상 선택하세요!!");
				return false; // submit 을 하지 않고 종료한다.
			}
			
		});
		
	});// end of $(document).ready(function(){})-----------------------

</script>

</head>
<body>

<form name="memberFrm" action="<%= ctxPath%>/chap03_StandardAction/06useBeanRegister.jsp" method="get">
	<fieldset>
		<legend>개인성향 테스트</legend>
		<ul>
			<li>
				<label for="name">성명</label>
				<input type="text" name="name" id="name" placeholder="성명입력"/> 
			</li>
			<li>
				<label for="school">학력</label>
				<select name="school" id="school">
				    <option value="">선택하세요</option>
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