<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<jsp:include page="../header.jsp" />

<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" /> 
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>

<style type="text/css">
	.line {border: 0px solid red;
	       border-collapse: collapse;
	       margin-top: 20px;
	       margin-bottom: 20px; }
	       
	li {margin-bottom: 10px;} 
	
	.customHeight {height: 100px;}
	
	button.btnCommentOK {position: relative; 
			             top:-105px; 
			             left:410px;
			             width: 100px; 
			             background-color: #4d4dff; 
			             color: #fff; 
			             border-style: none;
			             cursor: pointer;
	}
	
	textarea#commentContents {font-size: 12pt;}
	
	div#viewComments {width: 80%;
	           		  margin: 3% 0 0 0; 
	                  text-align: left;
	                  max-height: 300px;
	                  overflow: auto;
	                  /* border: solid 1px red; */
	}
	
	span.markColor {color: #ff0000; }
	
	div.customDisplay {display: inline-block;
	                   margin: 1% 3% 0 0;
	}
	                
	div.commentDel {margin-bottom: 5%;
	                font-size: 8pt;
	                font-style: italic;
	                cursor: pointer;
	}	      
</style>

<script type="text/javascript">
   $(document).ready(function() {
	   
	  func_height();  // footer.jsp 에 있는 것임.
	  
	  goCommentListView();  // 제품 구매후기를 보여주는 것.
	  
 //   goLikeDislikeCount(); // 좋아요, 싫어요 갯수를 보여주도록 하는 것이다.
	  

	  $("input#spinner").spinner( {
		   spin: function(event, ui) {
			   if(ui.value > 100) {
				   $(this).spinner("value", 100);
				   return false;
			   }
			   else if(ui.value < 1) {
				   $(this).spinner("value", 1);
				   return false;
			   }
		   }
	   } );// end of $("input#spinner").spinner({});----------------	 
	   
	   
	   // **** 제품후기 쓰기 ****// 
    
	   $("button.btnCommentOK").click(function(){
		   
		   if(${empty sessionScope.loginuser}) {
			   alert("제품사용 후기를 작성하시려면 먼저 로그인 하셔야 합니다.");
			   return;
		   }
		   
		   var commentContents = $("textarea#commentContents").val().trim();
		   
		   if(commentContents == "") {
			   alert("제품후기 내용을 입력하세요!!");
			   return; 
		   }
		   
		  
		   // 보내야할 데이터를 선정하는 첫번째 방법
	  <%-- 
		   var queryString = {"fk_userid":'${sessionScope.loginuser.userd}', 
				              "fk_pnum" : ${pvo.pnum},
				              "contents" : $("textarea#commentContents").val()};
	  --%>
		   // 보내야할 데이터를 선정하는 두번째 방법
		   // jQuery에서 사용하는 것으로써,
		   // form태그의 선택자.serialize(); 을 해주면 form 태그내의 모든 값들을 name값을 키값으로 만들어서 보내준다. 
		   var queryString = $("form[name=commentFrm]").serialize();
		   //  console.log(queryString); // commentContents=Good&pnum=3
		   
		   $.ajax({
			   url:"/MyMVC/shop/commentRegister.up",
			   type:"POST",
			   data:queryString,
			   success:function(){
				// alert("확인용 : 제품후기 글쓰기 성공!!");
				   goCommentListView(); // 제품후기글을 보여주는 함수호출하기 
				   $("textarea#commentContents").val("").focus();
			   },
			   error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			   }
		   });
		 
		   
	   });
   
	   
   }); // end of $(document).ready();------------------------------
   
   
   // 특정 제품의 제품후기글들을 보여주는 함수
   function goCommentListView() {

	   $.ajax({
		   url:"/MyMVC/shop/commentList.up",
		   type:"GET",
		   data:{"fk_pnum":${pvo.pnum}},
		   dataType:"JSON",
		   success:function(json) {
			   // [{"contents":"제품후기내용물", "name":"작성자이름", "writeDate":"작성일자"},{"contents":"제품후기내용물2", "name":"작성자이름2", "writeDate":"작성일자2"}] 
			    var html = "";
				
				if (json.length > 0) {    
					$.each(json, function(index, item){
					  html +=  "<div> <span class='markColor'>▶</span> "+item.contents+"</div>"
					         + "<div class='customDisplay'>"+item.name+"</div>"      
					         + "<div class='customDisplay'>"+item.writeDate+"</div>"
					         + "<div class='customDisplay commentDel'>후기삭제</div>";
					       
					} ); 
				}// end of if -----------------------
				
				else {
					html += "<div>등록된 상품후기가 없습니다.</div>";
				}// end of else ---------------------
				
				$("div#viewComments").html(html);	   		   
		   		
				// == "#sideinfo" 의 height 값 설정해주기 == 
				var contentHeight =	$("#content").height();
				//	alert(contentHeight);
				$("#sideinfo").height(contentHeight);
		   },
		   error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		   }
	   });	   
	   
   }
   
   
   // **** 특정제품에 대한 좋아요 등록하기 **** // 
  // pnum이 어디서 들어옴.? => html 바디안에 버튼요소에서 이전페이지에서 request에 넘겨주었던 값을 스크립트로 옮김.
		  
   function golikeAdd(pnum) {
		
	   $.ajax({
		   url:"/MyMVC/shop/likeAdd.up",
		   type:"POST",
		   data:{"pnum":pnum,
			     "userid":"${sessionScope.loginuser.userid}"},
		   dataType:"JSON", 
		   success:function(json) {
			   //alert(json.msg);
			     swal(json.msg);
			     goLikeDislikeCount();
		   },
		   error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		   }
	   });
	   
   }// end of golikeAdd(pnum)---------------
   
   
   // **** 특정제품에 대한 싫어요 등록하기 **** //
   function godisLikeAdd(pnum) {
 
	   $.ajax({
		   url:"/MyMVC/shop/dislikeAdd.up",
		   type:"POST",
		   data:{"pnum":pnum,
			     "userid":"${sessionScope.loginuser.userid}"},
		   dataType:"JSON", 
		   success:function(json) {
			   //alert(json.msg);
			     swal(json.msg);
			     goLikeDislikeCount();
		   },
		   error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		   }
	   });	 
	   
   }// end of golikeAdd(pnum)---------------
   
   
   // **** 특정 제품에 대한 좋아요, 싫어요 갯수를 보여주기 **** //
   function goLikeDislikeCount() {

	   $.ajax({
		   url:"/MyMVC/shop/likeDislikeCount.up",
		// type:"GET",
		   data:{"pnum":"${pvo.pnum}"},
		   dataType:"JSON", 
		   success:function(json) {
			   $("div#likeCnt").html(json.likecnt);
			   $("div#dislikeCnt").html(json.dislikecnt);
		   },
		   error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		   }
	   });	   
	   
   }// end of function goLikeDislikeCount()-------------------
   
   
   <%--
   function goCart(pnum) {
	   // pnum 은 장바구니에 담을 제품번호 이다.
	   
	   // === 주문량에 대한 유효성 검사하기 === //
	   var frm = document.cartOrderFrm;
	   
	   var regExp = /^[0-9]+$/;  // 숫자만 체크하는 정규표현식
	   var oqty = frm.oqty.value;
	   var bool = regExp.test(oqty);
	   
	   if(!bool) {
		   // 숫자 이외의 값이 들어온 경우 
		   alert("주문갯수는 1개 이상이어야 합니다.");
		   frm.oqty.value = "1";
		   frm.oqty.focus();
		   return;
	   }
	   
	   // 문자로 숫자가 들어온 경우
	   oqty = parseInt(oqty);
	   if(oqty < 1) {
		   alert("주문갯수는 1개 이상이어야 합니다.");
		   frm.oqty.value = "1";
		   frm.oqty.focus();
		   return;
	   }
	   
	   // 주문개수가 1개 이상인 경우
	   frm.method = "POST";
	   frm.action = "/MyMVC/shop/cartAdd.up";
	   frm.submit();
   }
   --%>
   
   
</script>

<div style="width: 95%;">
	<div class="row">
	  <div class="col-md-12 line">
	      <span style="font-size: 15pt; font-weight: bold;">::: 제품 상세 정보 :::</span>
	  </div>
	</div>
	
	<div class="row">
		<div class="col-md-3 line">
			<img src="/MyMVC/images/${pvo.pimage1}" style="width: 200px; height: 170px;" />
		</div>
		
		<div class="col-md-9 line" align="left">
		    <ul style="list-style-type: none;">
				<li><span style="color: red; font-size: 12pt; font-weight: bold;">${pvo.spvo.sname}</span></li>
				<li>제품번호: ${pvo.pnum}</li>
				<li>제품이름: ${pvo.pname}</li>
				<li>제조회사: ${pvo.pcompany}</li>
		        <li>제품정가: <span style="text-decoration: line-through;"><fmt:formatNumber value="${pvo.price}" pattern="###,###" />원</span></li>
		        <li>제품판매가: <span style="color: blue; font-weight: bold;"><fmt:formatNumber value="${pvo.saleprice}" pattern="###,###" />원</span></li>
		        <li>할인율: <span style="color: maroon; font-weight: bold;">[${pvo.discountPercent}% 할인]</span></li>
		        <li>포인트: <span style="color: green; font-weight: bold;">${pvo.point} POINT</span></li>
		        <li>잔고갯수: <span style="color: maroon; font-weight: bold;">${pvo.pqty} 개</span></li>		    
		    </ul>
		    
		 <%-- ==== 장바구니 담기 및 바로주문하기 폼 ==== --%>
	     <form name="cartOrderFrm">	    
		    <ul style="list-style-type: none; margin-top: 50px;">
		    	<li style="margin-bottom: 40px;">
		        	<label for="spinner">주문개수:</label>
  					<input id="spinner" name="oqty" value="1" style="width: 30px; height: 20px;">
				</li>
				<li>
					<button type="button" class="btn btn-info" onClick="goCart('${pvo.pnum}');" style="margin-right: 10px;">장바구니담기</button>
					<button type="button" class="btn btn-warning" onClick="goOrder('${pvo.pnum}');">바로주문하기</button>
				</li>
			</ul>
			
			<input type="hidden" name="pnum" value="${pvo.pnum}" />
			<input type="hidden" name="saleprice" value="${pvo.saleprice}" />
			
			<input type="hidden" name="sumtotalprice" />
			<input type="hidden" name="sumtotalpoint" />
			
			<input type="hidden" name="goBackURL" value="${goBackURL}" size="200" /> 
		  </form>		    
		    
		</div>
	</div>
	
	<div class="row">
	  <div class="col-md-12 line">
	  	<img src="/MyMVC/images/${pvo.pimage2}" style="width: 400px; height: 340px;" />
	  </div>
	</div>
	
	<div class="row">
		<c:if test="${not empty imgList}">
			<c:forEach var="imgfilename" items="${imgList}">
				<div class="col-md-3 line">
				   <img src="/MyMVC/images/${imgfilename}" style="width: 200px; height: 170px;" />
				</div>
			</c:forEach>
		</c:if>
	</div>
	
	<div class="row">
	  <div class="col-md-12 line">
	  	<span style="color: white; font-weight: bold; font-size: 14pt; background-color: navy;">제품설명</span>
	  	<p>${pvo.pcontent}</p>	
	  </div>
	</div>
	
	<div class="row" style="margin-bottom: 50px;">
	   <div class="col-md-2 col-md-offset-2">
		   <img src="<%=request.getContextPath()%>/images/like.png" style="cursor: pointer;" onClick="golikeAdd('${pvo.pnum}');"/>
	   </div>
	   <div class="col-md-1" id="likeCnt" align="left" style="color: blue; font-size: 16pt;">
	   </div>
	   <div class="col-md-2 col-md-offset-2">
		   <img src="<%=request.getContextPath()%>/images/dislike.png" style="cursor: pointer;" onClick="godisLikeAdd('${pvo.pnum}');"/>
	   </div>
	   <div class="col-md-1" id="dislikeCnt" align="left" style="color: red; font-size: 16pt;">
	   </div>    	
	</div>
	
    <span style="font-size: 16pt; color: orange">제품사용 후기</span>
    <div id="viewComments">
    	<%-- 여기가 제품사용 후기 내용이 들어오는 곳이다. --%>
    </div> 
    <form name="commentFrm">
    	<div>
    		<textarea cols="100" class="customHeight" name="contents" id="commentContents"></textarea>
    	</div>
    	<div>
    		<button type="button" class="customHeight btnCommentOK">후기등록</button>
    	</div>
    	<input type="hidden" name="fk_userid" value="${sessionScope.loginuser.userid}" />
    	<input type="hidden" name="fk_pnum" value="${pvo.pnum}" />
    </form>
	
</div>

<jsp:include page="../footer.jsp" />
