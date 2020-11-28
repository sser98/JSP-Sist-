<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%>    
    
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/style.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<style>
	#div_pwd {
		width: 70%;
		height: 15%;
		margin-bottom: 5%;
		margin-left: 10%;
		position: relative;
	}
	
	#div_pwd2 {
		width: 70%;
		height: 15%;
		margin-bottom: 5%;
		margin-left: 10%;
		position: relative;
	}
	
	#div_updateResult {
		width: 70%;
		height: 15%;
		margin-bottom: 5%;
		margin-left: 10%;		
		position: relative;
	}
	
	#div_btnUpdate {
		width: 70%;
		height: 15%;
		margin-bottom: 5%;
		margin-left: 10%;
		position: relative;
	}
</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("button#btnUpdate").click(function(){
			
		    var pwd = $("input#pwd").val();
		    var pwd2 = $("input#pwd2").val();
		    
		 // var regExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
		 // 또는
			var regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
			// 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성
			
			var bool = regExp.test(pwd);
			
			if(!bool) {
				alert("암호는 8글자 이상 15글자 이하에 영문자,숫자,특수기호가 혼합되어야만 합니다.");
				$("input#pwd").val("");
				$("input#pwd2").val("");
				return; // 종료
			}
			else if(bool && pwd != pwd2) {
				alert("암호가 일치하지 않습니다.");
				$("input#pwd").val("");
				$("input#pwd2").val("");
				return; // 종료
			}
			else {
				var frm = document.pwdUpdateEndFrm;
				frm.action = "<%= ctxPath%>/login/pwdUpdateEnd.up";
				frm.method = "POST";
				frm.submit();
			}
		});
		
	});// end of $(document).ready(function(){})---------------
	
</script>

<form name="pwdUpdateEndFrm">
   <div id="div_pwd" align="center">
      <span style="color: blue; font-size: 12pt;">새암호</span><br/> 
      <input type="password" name="pwd" id="pwd" size="15" placeholder="PASSWORD" required />
   </div>
   
   <div id="div_pwd2" align="center">
   	  <span style="color: blue; font-size: 12pt;">새암호확인</span><br/>
      <input type="password" id="pwd2" size="15" placeholder="PASSWORD" required />
   </div>
   
   <input type="hidden" name="userid" value="${userid}" />
   
   <c:if test="${method == 'POST' && n == 1}">
	   <div id="div_updateResult" align="center">
	   	  사용자 ID가 ${userid}님의 암호가 새로이 변경되었습니다.<br>
	   </div> 
   </c:if> 
    
   <c:if test="${method == 'GET'}">
	   <div id="div_btnUpdate" align="center">
	   	  <button type="button" class="btn btn-success" id="btnUpdate">암호변경하기</button>
	   </div> 
   </c:if> 
   
</form>
    