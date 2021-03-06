<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="header.jsp" />

<%
	String ctxPath = request.getContextPath();
%>




<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/common">



<script type="text/javascript">
	
	
	$(document).ready(function () {
		

		$('.starRev span').click(function(){
			  $(this).parent().children('span').removeClass('on');
			  $(this).addClass('on').prevAll('span').addClass('on');
			  return false;
			});
		
		
	}); // end of $(document).ready(function () {}
	
	
	

</script>


<div id="wrap">



	                <%--
							<div class="starRev">
								<span class="starR1 on">별1_왼쪽</span> <span class="starR2">별1_오른쪽</span>
								<span class="starR1">별2_왼쪽</span> <span class="starR2">별2_오른쪽</span>
								<span class="starR1">별3_왼쪽</span> <span class="starR2">별3_오른쪽</span>
								<span class="starR1">별4_왼쪽</span> <span class="starR2">별4_오른쪽</span>
								<span class="starR1">별5_왼쪽</span> <span class="starR2">별5_오른쪽</span>
							</div>
					--%>
	<%-- 
					
	<!-- reviewSection -->
	<div class="productContent reviewSection" data-id="reviewSection">
		<div class="infoBox" id="productReview"></div>
	</div>
	<!-- // reviewSection -->
	

	<div class="productContent reviewSection" data-id="reviewSection">
         	<div class="infoBox" id="productReview">
	<div class="infoBox">
 		<div class="infoHeader">
       			<h2> 상품리뷰(<em>7</em>) </h2>
     	</div>
     	<div class="infoContent">
       		<!-- reviewSummary -->
       		<div class="reviewSummary">
	 			<dl class="totalAverage">
	   				<dt>총점</dt>
		   			<dd>
		     			<span class="summaryValue">
		       				<em>9.7</em>
		    			</span>
		     			<span class="summaryText">11명 참여</span>
		     			<span class="starRateWrap">
		       				<span class="starRate" style="width: 97%">9.7</span>
		     			</span>
		   			</dd>
		 		</dl>
	 			<dl class="recommend">
	   				<dt>추천</dt>
	   				<dd>
						<i></i>
	     				<span class="summaryValue">
	       					<em>97</em>
	       					<span class="unit">%</span>
	     				</span>
	     				<span class="gaugeWrap">
	       					<span class="gauge" style="width: 97%">97%</span>
	     				</span>
	   				</dd>
	 			</dl>
	 			<dl class="delivery">
	   				<dt>배송</dt>
	   				<dd>
						<i></i>
		     			<span class="summaryValue">
				       		<em>97</em>
				       		<span class="unit">%</span>
				     	</span>
				     	<span class="gaugeWrap">
				       		<span class="gauge" style="width: 97%">97%</span>
				     	</span>
				   	</dd>
			 	</dl>
				<dl class="costBenefit">
			  		<dt>가성비</dt>
			   		<dd>
						<i></i>
			     		<span class="summaryValue">
			       			<em>97</em>
			       			<span class="unit">%</span>
			     		</span>
			     		<span class="gaugeWrap">
			       			<span class="gauge" style="width: 97%">97%</span>
			     		</span>
			   		</dd>
			 	</dl>
       		</div>

       		<!-- // reviewSummary -->
            <!-- reviewListHeader -->
            <div class="reviewListHeader">
                <div class="headerLeft">
                    <ul class="orderBtn">
                        <li class="current">
                            <a href="#" data-sort="01" name="btnReviewSort">최신순</a>
                        </li>
                        <li class="">
                            <a href="#" data-sort="02" name="btnReviewSort">추천순</a>
                        </li>
                    </ul>
                </div>
                <div class="headerRight">
                    <label>
                        <input type="checkbox" class="iCheckbox" id="photoReviewCheck" onclick="$is.product.review.checkPhotoReview(this)">
                        <i class="icon"></i>
						<span>포토리뷰만 보기</span>
                    </label>
                </div>
            </div>
            <!-- // reviewListHeader -->
			<div class="reviewList" id="reviewList">
	 			<ul>
	   				<li data-usedwrittenno="106087352">
				     <!-- reviewHeader -->
				     	<div class="reviewHeader">
				       		<div class="headerLeft">
					 			<span class="starRateWrap">
					   				<span class="starRate" style="width: 100%">10.0</span>
					 			</span>
											<dfn>구매옵션 :</dfn>
		                      				<span class="option">색상 / 초코브라운</span>
				       		</div>
				       		<div class="headerRight">
					 			<span class="user">
	                        		tpi***
								</span>
								<span class="stat"></span>
					 			<span class="date" title="2020.10.13">2020.10.13</span>
				       		</div>
				     	</div>
				     	<!-- // reviewHeader -->
				     	<!-- reviewBody -->
				     	<div class="reviewBody">
				       		<h1>상품평</h1>
				       		<p class="reviewContent">
									가격도 착하고 할부로 구입하여 부담 없습니다
							</p>
							<div class="userUploadImages">
                                <ol>
                                    <li>
                                      	<a href="#" onclick="return false;">
                                        	<img src="http://openimage.interpark.com/milti/usedwritten/2020/10/202010132154527831.jpg" alt="" onerror="javascript:this.src='http://openimage.interpark.com/_nip_ui/openlist/noimage_130.gif'">
										</a>
                                    </li>
                                </ol>
                            </div>
				     	</div>
				     	
				     	<!-- // reviewBody -->
				     	<!-- reviewFoot -->
				     	<div class="reviewFoot">
				       		<div class="commentWrap">
					 			<div class="commentToggle">
					    			<a href="#">댓글
										<span class="commentCount"></span>
										<i class="icon"></i>
									</a>
					 			</div>

				     	</div>
				     <!-- // reviewFoot -->
				   	</li>
	 			</ul>
	 			<div class="pagination" id="reviewPage"><a href="javascript:;" class="arrow prev" onclick="$is.product.review.getList(1);return false;"><span>이전</span></a><ol class="numWrap"><li class="current"><a href="#" class="pageNumber" onclick="$is.product.review.getList(1);return false;"><span>1</span></a></li></ol><a href="javascript:;" class="arrow next" onclick="$is.product.review.getList(1);return false;"><span>다음</span></a></div>
				<div class="reviewImageModal">
                    <div class="reviewModalBG"></div>
                    <div class="reviewImageWrap">
                        <div class="reviewImage">
                            <div class="reviewModal">
                                <span class="imgWrap">
                                   	<img src="//openimage.interpark.com/.ui/interparkMain/2017/main/common/blank.png" alt="">
                                </span>
                                <div class="modalClose">
                                    <button type="button">닫기</button>
                                </div>
                                <div class="modalControl">
                                   	<button type="button" class="prev">이전</button>
                                    <button type="button" class="next">다음</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
</div>
     	</div>
   </div>
</div>
         </div>


</div>
		
--%>


	


<jsp:include page="footer.jsp"/>