<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>
 
<!DOCTYPE html>
<html>
<head>
<title>:::회원정보수정:::</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/style.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<style>
   table#tblMemberUpdate {
   	    width: 93%;
   	    
   	    /* 선을 숨기는 것 */
   	    border: hidden;
   	    
   	    margin: 10px;
   }  
   
   table#tblMemberUpdate #th {
   		height: 40px;
   		text-align: center;
   		background-color: silver;
   		font-size: 14pt;
   }
   
   table#tblMemberUpdate td {
   		/* border: solid 1px gray;  */
   		line-height: 30px;
   		padding-top: 8px;
   		padding-bottom: 8px;
   }
   
   .star { color: red;
           font-weight: bold;
           font-size: 13pt;
   }
   
   div .head {
		width: 90%;
		height: 50px;
		border: 1px solid gray;
		margin-top: 10px;
		margin-bottom: 30px;
		padding-top: 10px;
		padding-bottom: 50px;
		background-color: #ffffe6;
		font-size: 18pt;
	}
   
</style> 

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 
<script type="text/javascript">
	
	$(document).ready(function(){
		
		$(".error").hide();
		
		$("#pwd").blur(function() {
			var passwd = $(this).val();
			
		//	var regExp_PW = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
			// 또는
			var regExp_PW = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g); 
			// 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성
			
			var bool = regExp_PW.test(passwd);
			
			if(!bool) { // 암호가 정규표현식에 위배된 경우 
				$(this).parent().find(".error").show();
				$(":input").prop("disabled",true).addClass("bgcol"); 
				$(this).prop("disabled",false).removeClass("bgcol");
				$(this).focus();
			}
			else { // 암호가 정규표현식에 맞는 경우 
				$(this).parent().find(".error").hide();
				$(":input").prop("disabled",false).removeClass("bgcol"); 
				
				$("#pwdcheck").focus();
			} 
		});// end of $("#pwd").blur()-------------------
		
		
		$("#pwdcheck").blur(function(){
			var passwd = $("#pwd").val();
			var passwdCheck = $(this).val();
			
			if(passwd != passwdCheck) { // 암호와 암호확인값이 틀린 경우 
				$(this).parent().find(".error").show();
				$(":input").prop("disabled",true).addClass("bgcol");
				$(this).prop("disabled",false).removeClass("bgcol");
				$("#pwd").prop("disabled",false).removeClass("bgcol");
				$("#pwd").focus();
			}
			else { // 암호와 암호확인값이 같은 경우 
				$(this).parent().find(".error").hide();
				$(":input").prop("disabled",false).removeClass("bgcol");
			}
			
		});// end of $("#pwdcheck").blur()--------------		

		
		$("#email").blur(function(){
			
			var email = $(this).val();
			
			var regExp_EMAIL = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;  
			
			var bool = regExp_EMAIL.test(email);
			
			if(!bool) { // 이메일이 정규표현식에 위배된 경우
				$(this).parent().find(".error").show();
				$(":input").prop("disabled",true).addClass("bgcol");
				$(this).prop("disabled",false).removeClass("bgcol"); 
				$(this).focus();
			}
			else { // 이메일이 정규표현식에 맞는 경우
				$(this).parent().find(".error").hide();
				$(":input").prop("disabled",false).removeClass("bgcol");
			}
			
		});// end of $("#email").blur()--------------

		
		$("#hp2").blur(function(){
			var hp2 = $(this).val();
			
			var regExp_HP2 = /^[1-9][0-9]{2,3}$/g;
			// 숫자 3자리 또는 4자리만 들어오도록 검사해주는 정규표현식
			
			var bool = regExp_HP2.test(hp2);
			
			if(!bool) {
				$(this).parent().find(".error").show();
				$(":input").prop("disabled", true).addClass("bgcol");
				$(this).prop("disabled", false).removeClass("bgcol");
			}
			else {
				$(this).parent().find(".error").hide();
				$(":input").prop("disabled", false).removeClass("bgcol");
			}	
		});// end of $("#hp2").blur()-------------
		
		
		$("#hp3").blur(function(){
			var hp3 = $(this).val();
			
			var regExp_HP3 = /^\d{4}$/g;
			// 숫자 4자리만 들어오도록 검사해주는 정규표현식
			
			var bool = regExp_HP3.test(hp3);
			
			if(!bool) {
				$(this).parent().find(".error").show();
				$(":input").prop("disabled", true).addClass("bgcol");
				$(this).prop("disabled", false).removeClass("bgcol");
			}
			else {
				$(this).parent().find(".error").hide();
				$(":input").prop("disabled", false).removeClass("bgcol");
			}	
		});// end of $("#hp3").blur()-------------

		
		$("#zipcodeSearch").click(function(){
			new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수

	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }

	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("extraAddress").value = '';
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('postcode').value = data.zonecode;
	                document.getElementById("address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("detailAddress").focus();
	            }
	        }).open();				
		});
		
		// 아래의 작업은 휴대폰 번호가 하나로 되어져 있으므로 이것을 국번과 번호로 나누고자 하는 것이다.
		var mobile = "${sessionScope.loginuser.mobile}";
		
		$("input#hp2").val( mobile.substring(3,7) );
		$("input#hp3").val( mobile.substring(7) );
		
	});// end of $(document).ready()--------------------
	
	
	function goEdit() {
		
		var flagBool = false;
		
		$(".requiredInfo").each(function(){
			var data = $(this).val().trim();
			if(data == "") {
				flagBool = true;
				return false;
				/*
				   for문에서의 continue; 와 동일한 기능을 하는것이 
				   each(); 내에서는 return true; 이고,
				   for문에서의 break; 와 동일한 기능을 하는것이 
				   each(); 내에서는 return false; 이다.
				*/
			}
		});
		
		if(flagBool) {
			alert("필수입력란은 모두 입력하셔야 합니다.");
			return;
		}
		else {
			var frm = document.editFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/member/memberEditEnd.up";
			frm.submit();
		}
		
	}// end of goEdit(event)------------------

</script>
</head>

<body>
<div class="row" align="center">
	<div class="col-md-12">
		<form name="editFrm">
		<div class="head" align="center">
			::: 회원수정 (<span style="font-size: 10pt; font-style: italic;"><span class="star">*</span>표시는 필수입력사항</span>) :::
		</div>
		<table id="tblMemberUpdate">
			<tr>
				<td style="width: 20%; font-weight: bold;">성명&nbsp;<span class="star">*</span></td>
				<td style="width: 80%; text-align: left;">
				    <input type="hidden" name="userid" value="${sessionScope.loginuser.userid}" readonly />
				    <input type="text" name="name" id="name" value="${sessionScope.loginuser.name}" class="requiredInfo" required /> 
					<span class="error">성명은 필수입력 사항입니다.</span>
				</td>
			</tr>
			<tr>
				<td style="width: 20%; font-weight: bold;">비밀번호&nbsp;<span class="star">*</span></td>
				<td style="width: 80%; text-align: left;"><input type="password" name="pwd" id="pwd" class="requiredInfo" required />
					<span class="error">암호는 영문자,숫자,특수기호가 혼합된 8~15 글자로만 입력가능합니다.</span>
				</td>
			</tr>
			<tr>
				<td style="width: 20%; font-weight: bold;">비밀번호확인&nbsp;<span class="star">*</span></td>
				<td style="width: 80%; text-align: left;"><input type="password" id="pwdcheck" class="requiredInfo" required /> 
					<span class="error">암호가 일치하지 않습니다.</span>
				</td>
			</tr>
			<tr>
				<td style="width: 20%; font-weight: bold;">이메일&nbsp;<span class="star">*</span></td>
				<td style="width: 80%; text-align: left;"><input type="text" name="email" id="email" value="${sessionScope.loginuser.email}" class="requiredInfo" placeholder="abc@def.com" /> 
				    <span class="error">이메일 형식에 맞지 않습니다.</span>
				</td>
			</tr>
			<tr>
				<td style="width: 20%; font-weight: bold;">연락처</td>
				<td style="width: 80%; text-align: left;">
				    <input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp;
			    	<input type="text" id="hp2" name="hp2" size="6" maxlength="4" />&nbsp;-&nbsp;
			    	<input type="text" id="hp3" name="hp3" size="6" maxlength="4" />
				    
				  <%-- <input type="text" name="mobile" id="mobile" value="${sessionScope.loginuser.mobile}" size="20" maxlength="20" /> --%>  
				    <span class="error">휴대폰 형식이 아닙니다.</span>
				</td>
			</tr>
			<tr>
				<td style="width: 20%; font-weight: bold;">우편번호</td>
				<td style="width: 80%; text-align: left;">
				   <input type="text" id="postcode" name="postcode" value="${sessionScope.loginuser.postcode}" size="6" maxlength="5" />&nbsp;&nbsp;
				   <!-- 우편번호 찾기 -->
				   <img id="zipcodeSearch" src="<%= ctxPath %>/images/b_zipcode.gif" style="vertical-align: middle;" />
				   <span class="error">우편번호 형식이 아닙니다.</span>
				</td>
			</tr>
			<tr>
				<td style="width: 20%; font-weight: bold;">주소</td>
				<td style="width: 80%; text-align: left;">
				   <input type="text" id="address" name="address" value="${sessionScope.loginuser.address}" size="40" /><br/>
			       <input type="text" id="detailAddress" name="detailAddress" value="${sessionScope.loginuser.detailaddress}" size="40" />&nbsp;<input type="text" id="extraAddress" name="extraAddress" value="${sessionScope.loginuser.extraaddress}" size="40" /> 
			       <span class="error">주소를 입력하세요</span>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="button" id="btnUpdate" style="margin-left: 40%; margin-top: 2%; width: 80px; height: 40px;" onClick="goEdit();"><span style="font-size: 15pt;">확인</span></button>
				</td>
			</tr>
		</table>
		</form>
	</div>
</div>
</body>
</html>
