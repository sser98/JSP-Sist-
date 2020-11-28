<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String ctxPath = request.getContextPath();
    //     /MyMVC 
%>    
    
<!DOCTYPE html>
<html>
<head>
<title>코인충전 결제하기</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/style.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<style type="text/css">

	span {margin-right: 10px;}
						 
	.stylePoint {background-color: red; 
	             color: white;}
	             
	.purchase {cursor: pointer;
	           color: red;}             
	
</style>

<script type="text/javascript">
	<%--
		jQuery 를 이용하여 radio 버튼의 체크 유무 및 체크된 값을 검사한다.
		jQuery 의 selector 부분이 중요 포인트로 4개의 구문으로 나눠 볼 수 있다.
		 
		1. :input
		    - Selects all input, textarea, select and button elements.
		2. [name=animal]
		    - Selects elements that have the specified attribute with a value exactly equal to a certain value.
		3. :radio
		    - Selects all elements of type radio.
		4. :checked
		    - Matches all elements that are checked.
	--%>

	$(document).ready(function(){
		
		$("#error").hide();
		
		var coinmoney = 0;
		
		$("input:radio[name=coinmoney]").bind("click", function(){
			
			coinmoney = $(this).val();
			
			var index = $("input:radio[name=coinmoney]").index(this);
		//	alert("확인용 index : " + index);
		
			$("td span").removeClass("stylePoint");
			$("td span").eq(index).addClass("stylePoint");
			// $("td span").eq(index); ==> $("td span")중에  index 번째의 요소인 엘리먼트를 선택자로 보는 것이다.
			//                             $("td span")은 마치 배열로 보면 된다. $("td span").eq(index) 은 배열중에서 특정 요소를 끄집어 오는 것으로 보면 된다. 예를 들면 arr[i] 와 비슷한 뜻이다.
			
			$("#error").hide();
		});	
		
		
		$("#purchase").hover(function(){
								$(this).addClass("purchase");
							}, function(){
								$(this).removeClass("purchase");
							});
		
		
		$("#purchase").click(function(){
			
			var checkedCnt = $("input:radio[name=coinmoney]:checked").length;
			
			if(checkedCnt == 0) {
				// 결제금액을 선택하지 않았을 경우
				$("#error").show();
				return;
			}
			else {
				// 결제하러 들어간다.
				
			/* === 팝업창에서 부모창 함수 호출 방법 3가지 ===
			    1-1. 일반적인 방법
				opener.location.href = "javascript:부모창스크립트 함수명();";
									
				1-2. 일반적인 방법
				window.opener.부모창스크립트 함수명();

				2. jQuery를 이용한 방법
				$(opener.location).attr("href", "javascript:부모창스크립트 함수명();");
			*/
			
			//	opener.location.href = "javascript:goCoinPurchaseEnd('${sessionScope.loginuser.userid}' , "+coinmoney+");";
			//  window.opener.goCoinPurchaseEnd('${sessionScope.loginuser.userid}' , coinmoney);
			    $(opener.location).attr("href", "javascript:goCoinPurchaseEnd('${sessionScope.loginuser.userid}' , "+coinmoney+");");
				
				self.close(); // 팝업창을 닫는 것이다.
			}
		});
		
		
	});// end of $(document).ready()----------------

</script>
</head>

<body>
	<div class="container">
	  <h2>코인충천 결제방식 선택</h2>
	  <p>코인충전 금액 높을수록 POINT를 무료로 많이 드립니다.</p> 
	  
	  <div class="table-responsive" style="margin-top: 30px;">           
		  <table class="table">
		    <thead>
		      <tr>
		        <th>금액</th>
		        <th>POINT</th>
		      </tr>
		    </thead>
		    <tbody>
		      <tr>
		        <td>
			        <label class="radio-inline"><input type="radio" name="coinmoney" value="300000" />300,000원</label>
				</td>
		        <td>
					<span>3,000</span>
				</td>
		      </tr>
		      <tr>
		        <td>
					<label class="radio-inline"><input type="radio" name="coinmoney" value="200000" />200,000원</label>
		        </td>
		        <td>
		        	<span>2,000</span>
				</td>
		      </tr>
		      <tr>
		        <td>
					<label class="radio-inline"><input type="radio" name="coinmoney" value="100000" />100,000원</label>
		        </td>
		        <td>
		        	<span>1,000</span>
				</td>
		      </tr>
		      <tr>
		      	<td id="error" colspan="3" align="center" style="height: 50px; vertical-align: middle; color: red;">결제종류에 따른 금액을 선택하세요!!</td>
		      </tr>
		      <tr>
		        <td id="purchase" colspan="3" align="center" style="height: 100px; vertical-align: middle;">[충전결제하기]</td>
		      </tr>
		    </tbody>
		  </table>
	  </div>
	</div>
</body>
</html>