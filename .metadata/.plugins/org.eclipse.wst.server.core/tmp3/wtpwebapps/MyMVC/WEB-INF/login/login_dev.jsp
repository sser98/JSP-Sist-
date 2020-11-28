<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.Random" %>

<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>

<%
//	String ctxPath = request.getContextPath(); // 오류 발생함.!! ctxPath 지역변수가 중복되었다는 오류메시지임.
	//      /MyMVC

	// 카카오 로그인에 사용될 사용자의 비밀번호를 랜덤하게 생성하도록 한다.
	Random rnd = new Random();

	String pwd = "";
	// 비밀번호 영문소문자 5글자 + 숫자 7글자 로 만들겠습니다.
    // 예: pwd ==> dngrn4745003

	char randchar = ' ';
	for(int i=0; i<5; i++) {
		/*
		    min 부터 max 사이의 값으로 랜덤한 정수를 얻으려면 
		    int rndnum = rnd.nextInt(max - min + 1) + min;
		       영문 소문자 'a' 부터 'z' 까지 랜덤하게 1개를 만든다.  	
		 */	
		
		randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
		pwd += randchar;
	}// end of for----------------------------

	int randnum = 0;
	for(int i=0; i<7; i++) {
		randnum = rnd.nextInt(9 - 0 + 1) + 0;
		pwd += randnum;
	}// end of for----------------------------

	// System.out.println("~~~~ 확인용 pwd => " + pwd);
	// ~~~~ 확인용 pwd => bpjfz4641015
	
%>

<style>
	table#loginTbl , table#snsloginTbl{
		width: 95%;
		border: solid 1px gray;
		border-collapse: collapse;
		margin-top: 20px;
	}
	
	table#loginTbl #th {
		background-color: silver;
		font-size: 14pt;
		text-align: center;
	}
	
	table#loginTbl td {
		border: solid 1px gray;
	}
</style>

<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		$("button#btnSubmit").click(function(){
			goLogin(); // 로그인 시도한다.
		});
		
		$("input#loginPwd").keyup(function(event){
			if(event.keyCode == 13) { // 암호입력란에 엔터를 했을 경우 
				goLogin(); // 로그인 시도한다.
			}
		});

	});// end of $(document).ready()--------------------------------------

	
	// === 로그인 처리 함수 === //
	function goLogin() {
	//	alert("로그인 시도함");
	
	    var loginUserid = $("input#loginUserid").val().trim();
	    var loginPwd = $("input#loginPwd").val().trim();
	    
	    if(loginUserid == "") {
	    	alert("아이디를 입력하세요!!");
	    	$("input#loginUserid").val("");
	    	$("input#loginUserid").focus();
	    	return;  // goLogin() 함수 종료 
	    }
	    
	    if(loginPwd == "") {
	    	alert("암호를 입력하세요!!");
	    	$("input#loginPwd").val("");
	    	$("input#loginPwd").focus();
	    	return;  // goLogin() 함수 종료 
	    }
	    
	    
	/*
		>> 로컬 스토리지(localStorage)와 세션 스토리지(sessionStorage) << 
		      로컬 스토리지와 세션 스토리지는 HTML5에서 추가된 저장소이다.
		      간단한 키와 값을 저장할 수 있다. 키-밸류 스토리지의 형태이다.
		    
		    ※ 로컬 스토리지와 세션 스토리지의 차이점은 데이터의 영구성이다. 
		       로컬 스토리지의 데이터는 사용자가 지우지 않는 이상 계속 브라우저에 남아 있게 된다. 
		       만료 기간을 설정할 수 없다.
		       하지만 세션 스토리지의 데이터는 윈도우나 브라우저 탭을 닫을 경우 자동적으로 제거된다.
		       지속적으로 필요한 데이터(자동 로그인 등)는 로컬 스토리지에 저장하고, 
		       잠깐 동안 필요한 정보(일회성 로그인 정보라든가)는 세션 스토리지에 저장하도록 한다. 
		       그러나 비밀번호같은 중요한 정보는 절대로 저장하면 안된다.
		       왜냐하면  클라이언트 컴퓨터 브라우저에 저장하는 것이기 때문에 타인에 의해 도용당할 수 있기 때문이다.
		
		       로컬 스토리지랑 세션 스토리지가 나오기 이전에도 브라우저에 저장소 역할을 하는 게 있었다.
		       바로 쿠키인데 쿠키는 만료 기한이 있는 키-값 저장소이다.
		
		       쿠키는 4kb 용량 제한이 있고, 매번 서버 요청마다 서버로 쿠키가 같이 전송된다.
		       만약 4kb 용량 제한을 거의 다 채운 쿠키가 있다면, 요청을 할 때마다 기본 4kb의 데이터를 사용한다. 
		    4kb 중에는 서버에 필요하지 않은 데이터들도 있을 수 있다. 
		       그러므로 데이터 낭비가 발생할 수 있게 된다. 
		       바로 그런 데이터들을 이제 로컬 스토리지와 세션 스토리지에 저장할 수 있다. 
		       이 두 저장소의 데이터는 서버로 자동 전송되지 않는다.
		
		   >> 로컬 스토리지(localStorage) <<
		      로컬 스토리지는 window.localStorage에 위치한다. 
		      키 밸류 저장소이기 때문에 키와 밸류를 순서대로 저장하면 된다. 
		      값으로는 문자열, boolean, 숫자, null, undefined 등을 저장할 수 있지만, 
		      모두 문자열로 변환된다. 키도 문자열로 변환된다.
		
		      localStorage.setItem('name', '이순신');
		      localStorage.setItem('birth', 1994);
		
		      localStorage.getItem('name');        // 이순신
		      localStorage.getItem('birth');         // 1994 (문자열)
		
		      localStorage.removeItem('birth');   // birth 삭제
		      localStorage.getItem('birth');         // null (삭제됨)
		
		      localStorage.clear();                    // 전체 삭제
		
		      localStorage.setItem(키, 값)으로 로컬스토리지에 저장함.
		      localStorage.getItem(키)로 조회함. 
		      localStorage.removeItem(키)하면 해당 키가 지워지고, 
		      localStorage.clear()하면 스토리지 전체가 비워진다.
		
		      localStorage.setItem('object', { userid : 'leess', name : '이순신' });
		      localStorage.getItem('object');   // [object Object]
		            객체는 제대로 저장되지 않고 toString 메소드가 호출된 형태로 저장된다. 
		      [object 생성자]형으로 저장되는 것이다. 
		            객체를 저장하려면 두 가지 방법이 있다. 
		            그냥 키-값 형식으로 풀어서 여러 개를 저장할 수도 있다. 
		            한 번에 한 객체를 통째로 저장하려면 JSON.stringify를 해야된다. 
		            객체 형식 그대로 문자열로 변환하는 것이다. 받을 때는 JSON.parse하면 된다.
		
		      localStorage.setItem('object', JSON.stringify({ userid : 'leess', name : '이순신' }));
		      JSON.parse(localStorage.getItem('object')); // { userid : 'leess', name : '이순신' }
		     
		            이와같이 데이터를 지우기 전까지는 계속 저장되어 있기 때문에 
		            사용자의 설정(보안에 민감하지 않은)이나 데이터들을 넣어두면 된다.  
		
		   >> 세션 스토리지(sessionStorage) <<
		            세션 스토리지는 window.sessionStorage에 위치한다. 
		      clear, getItem, setItem, removeItem, key 등 
		            모든 메소드가 로컬 스토리지(localStorage)와 같다. 
		            단지 로컬스토리지와는 다르게 데이터가 영구적으로 보관되지는 않을 뿐이다. 
		            
		   >> 로컬 스토리지(localStorage)와 세션 스토리지(sessionStorage) 에 저장된 데이터를 보는 방법 << 
		            크롬인 경우 F12(개발자도구) Application 탭에 가면 Storage - LocalStorage 와 SessionStorage 가 보여진다.
		            거기에 들어가서 보면 Key 와 Value 값이 보여진다.
	*/		
	    
		if( $("input:checkbox[id=saveid]").prop("checked") ) {
			// alert("아이디저장 체크를 하셨네요");
			
			localStorage.setItem('saveid', $("input#loginUserid").val());
		}
		else {
			// alert("아이디저장 체크를 안 하셨네요");
			
			localStorage.removeItem('saveid');
		}   
			
	    
	    var frm = document.loginFrm;
	    frm.action = "<%= request.getContextPath()%>/login/login.up";
	    frm.method = "post";
	    frm.submit();
	
	}// end of function goLogin()-----------------------------------------
	
	
	function goLogOut() {
		
		/*
		   === 카카오 로그아웃 하기 ===
	            카카오 로그아웃(Kakao.Auth.logout())은 카카오 계정의 로그아웃과는 다릅니다.
		    카카오 로그아웃(Kakao.Auth.logout())은 사용자 토큰을 만료 시키는 역할을 하고 있습니다.
		    기본적으로 카카오 인증 API는 persistAccessToken 값을 true로 지정할 시 
		    토큰이 만료될때 까지 세션을 유지하고 있습니다.
		  Kakao.Auth.getAccessToken()을 사용하여 액세스 토큰이 존재하는지 체크할 수 있고
		    액세스 토큰이 존재한다면 로그아웃을 시키면 됩니다.
		    로그아웃은 Kakao.Auth.logout 함수를 사용하여 구현합니다.
		*/
				
		if(Kakao.Auth.getAccessToken()) {
			
			alert('카카오 사용자에 접근할 수 있는 인증 토큰이 있습니다.\n'+ Kakao.Auth.getAccessToken());
			
			Kakao.Auth.logout(function(){
				alert('카카오 사용자에 접근할 수 있는 인증 토큰을 로그아웃 시켰습니다.\n'+ Kakao.Auth.getAccessToken());
				// 로그아웃을 처리해주는 페이지로 이동
				location.href="<%= request.getContextPath()%>/login/logout.up"; 
			});
		}
		
		else {
			// 로그아웃을 처리해주는 페이지로 이동
			location.href="<%= request.getContextPath()%>/login/logout.up"; 
		}
	}// end of function goLogOut()-----------------------------------------
	
	
 // ============= 카카오로 로그인 하기 시작 ============= 
	// 설명이 잘 나온 사이트 : https://webruden.tistory.com/272 
	//                   https://devtalk.kakao.com/t/topic/98626/2
	
 // Kakao.init('카카오에서 인증 받은 자바스크립트 키 값');
	Kakao.init('b08e58f1f59cfbc4b2e5d75b0ce193c5');
	function loginWithKakao() {

		Kakao.Auth.login({  // 카카오 로그인은  Kakao.Auth.login() 함수를 사용한다.
			success: function(authObj) { // 카카오 아이디와 비밀번호가 일치하여 카카오 사이트에 로그인이 성공할 경우 사용자 인증 토큰을 받으려고 시도하는 콜백함수 
				
				 Kakao.API.request({
				      url: "/v2/user/me",
				      success: function(res) {
				    	  alert('카카오 사용자에 접근할 수 있는 인증 토큰을 발급받았습니다.\n'+ Kakao.Auth.getAccessToken());   
				      //  console.log(JSON.stringify(res));
				    	    /*
				    	    {"id":1482908006,"connected_at":"2020-09-20T12:03:50Z","properties":{"nickname":"서영학","profile_image":"http://k.kakaocdn.net/dn/Mx1o7/btqHK3NNgZm/bJD0Aii7SE8wJp1UjUtdyk/img_640x640.jpg","thumbnail_image":"http://k.kakaocdn.net/dn/Mx1o7/btqHK3NNgZm/bJD0Aii7SE8wJp1UjUtdyk/img_110x110.jpg"},"kakao_account":{"profile_needs_agreement":false,"profile":{"nickname":"서영학","thumbnail_image_url":"http://k.kakaocdn.net/dn/Mx1o7/btqHK3NNgZm/bJD0Aii7SE8wJp1UjUtdyk/img_110x110.jpg","profile_image_url":"http://k.kakaocdn.net/dn/Mx1o7/btqHK3NNgZm/bJD0Aii7SE8wJp1UjUtdyk/img_640x640.jpg"},"has_email":true,"email_needs_agreement":false,"is_email_valid":true,"is_email_verified":true,"email":"hanmailrg@naver.com"}}
				    	      id => 사용자의 카카오 고유 id
				    	      connected_at => http://localhost:9090/MyMVC/index.up 사이트에 카카오 인증으로 최초로 접속한 날짜 시간(표준시간 이므로 -9시간을 더함. 즉 9시간을 뺌)
				    	           일단 한번 카카오로 로그인 접속을 한 후 다시 카카오로 로그인을 하면 그 이후로는 카카오 로그인 팝업창이 떳다가 자동으로 사라진다.
				    	           그래서 카카오 로그인 팝업창을 계속 보려면 크롬 웹브라우저를 껏다가 다시 크롬 웹브라우저를 켜면 된다.
				    	    */
				    	  	/*
				    	  	{"id":1525063274,"connected_at":"2020-11-07T09:58:15Z","properties":{"nickname":"조정화","profile_image":"http://k.kakaocdn.net/dn/2p3i9/btqK6eAtade/pGDVtkyCX3J9CKfyYmKkK1/img_640x640.jpg","thumbnail_image":"http://k.kakaocdn.net/dn/2p3i9/btqK6eAtade/pGDVtkyCX3J9CKfyYmKkK1/img_110x110.jpg"},"kakao_account":{"profile_needs_agreement":false,"profile":{"nickname":"조정화","thumbnail_image_url":"http://k.kakaocdn.net/dn/2p3i9/btqK6eAtade/pGDVtkyCX3J9CKfyYmKkK1/img_110x110.jpg","profile_image_url":"http://k.kakaocdn.net/dn/2p3i9/btqK6eAtade/pGDVtkyCX3J9CKfyYmKkK1/img_640x640.jpg"},"has_email":true,"email_needs_agreement":false,"is_email_valid":true,"is_email_verified":true,"email":"jjherim@gmail.com"}}
				    	  	*/
			        		var id = res.id; // 사용자의 카카오 고유 id를 얻어온다.
				    	  	var nickname = res.kakao_account.profile.nickname; // 사용자의 닉네임을 얻어온다.
				    	    var email = res.kakao_account.email; // 사용자의 이메일을 얻어온다.
				    	    
				    	//  console.log(id);       // 1482908006            1525063274    
				    	//  console.log(nickname); // 서영학                               조정화
				    	//  console.log(email);    // hanmailrg@naver.com   jjherim@gmail.com
				    	    
				    	    var userid = id;       // 사용자의 카카오 고유 id를 userid로 사용하도록 함.
				    	    var pwd = "<%= pwd%>"; // 암호는 랜덤하게 소문자 5자리 + 숫자 7자리로 만들어 사용하도록 함.
				    	    var name = nickname;   // 회원명은 닉네임으로 함.
				    	    var email = email;     // 카카오에서 사용하는 이메일
				    	    var hp1 = '010';       // 이하 나머지는 사업자 등록번호를 제출해야만 주는 것이기에 우리는 제공받지 못하므로 임의로 적었음.  
				    	    var hp2 = '2345';
				    	    var hp3 = '6789';
				    	    var postcode = '15864'
				    	    var address = '경기 군포시 오금로 15-35';
				    	    var detailAddress = '789동 1234호'
				    	    var extraAddress = ' (금정동)';
				    	    var gender = '1';
				    	    var birthyyyy = '1991';
				    	    var birthmm = '05';
				    	    var birthdd = '01';
				    	    
				    	    $.ajax({
				        		url:"/MyMVC/member/emailDuplicateCheck.up",
				        		data:{"email":email}, // data 는 /MyMVC/member/emailDuplicateCheck.up 로 전송해야할 데이터를 말한다. 
				        		type:"post",
				        		dataType:"json",      // Javascript Standard Object Notation.  dataType은  /MyMVC/member/emailDuplicateCheck.up 로 부터 실행되어진 결과물을 받아오는 데이터타입을 말한다. 
				        		success:function(json){
				        			if(json.isExists) {
				        				// 입력한 email 이 존재하는 경우라면 
				        				
				        				// alert("카카오로 로그인 할께요."); 
				        				var frm = document.kakaoLoginFrm;
			      		        		frm.userid.value=userid;
			      		        		frm.snstype.value="kakao";
			      		        		frm.action="/MyMVC/login/login.up";
			      		        		frm.method="POST";
			      		        		frm.submit();	
				        			}
				        			else {
				        				// 입력한 email 이 DB 테이블에 존재하지 않는 경우라면 
				        				if(confirm(nickname+"님 환영합니다.\n 저희 홈페이지에 회원으로 가입하시겠습니까?") == true){       		        		
				      		        		  
				      		        		  $.ajax({
				      		        			  url:"/MyMVC/member/memberRegister.up",
				      		        			  type:"POST",
				      		        			  data:{"snstype":"kakao"
				      		        				   ,"name":name
				      		        				   ,"userid":userid
				      		        				   ,"pwd":pwd
				      		        				   ,"email":email
				      		        				   ,"hp1":hp1
				      		        				   ,"hp2":hp2
				      		        				   ,"hp3":hp3
				      		        				   ,"postcode":postcode
				      		        				   ,"address":address
				      		        				   ,"detailAddress":detailAddress
				      		        				   ,"extraAddress":extraAddress
				      		        				   ,"gender":gender
				      		        				   ,"birthyyyy":birthyyyy
				      		        				   ,"birthmm":birthmm
				      		        				   ,"birthdd":birthdd},
				      		        			  dataType:"json",
				      		        			  success:function(json){
				      		        				   if(json.n == 1) {
				      		        					   alert("가입에 성공하셨습니다.");
				      		        					   
				      		        					   var frm = document.kakaoLoginFrm;
				 			      		        		   frm.userid.value=userid;
				 			      		        		   frm.snstype.value="kakao";
				 			      		        		   frm.action="/MyMVC/login/login.up";
				 			      		        		   frm.method="POST";
				 			      		        		   frm.submit();
				      		        				   }
				      		        				   else {
				      		        					   alert("가입에 실패하셨습니다."); 
				      		        				   }
				      		        			  },
				      		        			  error: function(request, status, error){
							    					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
							    				  }
				      		        		  });
				      		        		  
				      		        		}
				        				
				        				    else { // 저희 홈페이지에 회원으로 가입하지 않는 경우
				      		        			return;
				      		        		}
				        			}
				        		},
				        		error: function(request, status, error){
				    				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				    			}
				        	});	

					   },
					   fail: function(error) {
					       alert(JSON.stringify(error));
					   }
				 });
				
	    	},
			fail: function(err) {
				alert(JSON.stringify(err));
	    	}
		});
	}; // end of function loginWithKakao() {} --------------------------------------
	// ============= 카카오로 로그인 하기 끝 ============= 	
	
</script>

<%-- *** 로그인을 하기 위한 폼을 생성 *** --%>
<%-- 
<c:if test="${sessionScope.loginuser == null}">
또는
--%>
<c:if test="${empty sessionScope.loginuser}">
	<form name="loginFrm">
    	<table id="loginTbl">
			<thead>
				<tr>
					<th colspan="2" id="th">LOGIN</th>
				</tr>
			</thead>
			
			<tbody>
				<tr>
					<td style="width: 30%; border-bottom: hidden; border-right: hidden; padding: 10px;">ID</td>
					<td style="width: 70%; border-bottom: hidden; border-left: hidden; padding: 10px;"><input type="text" id="loginUserid" name="userid" size="13" class="box" /></td>
				</tr>	
				<tr>
					<td style="width: 30%; border-top: hidden; border-bottom: hidden; border-right: hidden; padding: 10px;">암호</td>
					<td style="width: 70%; border-top: hidden; border-bottom: hidden; border-left: hidden; padding: 10px;"><input type="password" id="loginPwd" name="pwd" size="13" class="box" /></td>
				</tr>
				
				<%-- 아이디 찾기, 비밀번호 찾기 --%>
				<tr>
					<td colspan="2" align="center">
						<a style="cursor: pointer;" data-toggle="modal" data-target="#userIdfind" data-dismiss="modal">아이디찾기</a> /
						<a style="cursor: pointer;" data-toggle="modal" data-target="#passwdFind" data-dismiss="modal" data-backdrop="static">비밀번호찾기</a>
					</td>
				</tr>
				
				<tr>
					<td colspan="2" align="center" style="padding: 10px;">
						<input type="checkbox" id="saveid" name="saveid" style="vertical-align: text-top;" /><label for="saveid" style="margin-right: 20px; vertical-align: middle;">아이디저장</label>
						<button type="button" id="btnSubmit" style="width: 67px; height: 27px; background-image: url('<%= request.getContextPath()%>/images/login.png'); vertical-align: middle; border: none;"></button>
					</td>
				</tr>
			</tbody>
    	</table>
    	
	<%-- ===== SNS 카카오 로그인 시작 ===== --%>
    	<table id="snsloginTbl">
			<thead>
				<tr>
					<th>SNS 간편 로그인</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><a href="javascript:loginWithKakao()"><img src="<%= request.getContextPath()%>/images/kakao_login.png"/></a></td>
				</tr>	
			</tbody>
    	</table>
    <%-- ===== SNS 카카오 로그인 끝 ===== --%>	
    
	</form>
</c:if>


<%-- *** 로그인 되어진 화면 *** --%>
<%-- 
<c:if test="${sessionScope.loginuser != null}">
또는
--%>
<c:if test="${not empty sessionScope.loginuser}">
	<table style="width: 95%; height: 130px;">
    		<tr style="background-color: pink;">
    			<td align="center">
    				<span style="color: blue; font-weight: bold;">${(sessionScope.loginuser).name}</span>
    				[<span style="color: red; font-weight: bold;">${(sessionScope.loginuser).userid}</span>]님
    				<br/><br/>
    				<div align="left" style="padding-left: 20px; line-height: 150%;">
    					<span style="font-weight: bold;">코인액&nbsp;:</span>&nbsp;&nbsp; <fmt:formatNumber value="${(sessionScope.loginuser).coin}" pattern="###,###" /> 원
    					<br/>
    					<span style="font-weight: bold;">포인트&nbsp;:</span>&nbsp;&nbsp; <fmt:formatNumber value="${(sessionScope.loginuser).point}" pattern="###,###" /> POINT
    				</div>
    				<br/>로그인 중...<br/><br/>
    				[<a href="javascript:goEditPersonal('${(sessionScope.loginuser).userid}');">나의정보</a>]&nbsp;&nbsp;
				  	[<a href="javascript:goCoinPurchaseTypeChoice('${(sessionScope.loginuser).userid}');">코인충전</a>] 
				  	<br/><br/>
    				<button type="button" onclick="goLogOut();">로그아웃</button>
    			</td>
    		</tr>
    	</table> 
</c:if>

<%-- 카카오 로그인 --%>
<form name="kakaoLoginFrm">
	<input type="hidden" name="userid"/>
	<input type="hidden" name="snstype"/>
</form>






    