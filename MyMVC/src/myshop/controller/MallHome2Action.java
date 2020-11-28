package myshop.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import myshop.model.*;

public class MallHome2Action extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 카테고리 목록을 조회해오기
		super.getCategoryList(request);
		
		// 로그인을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임. 
		super.goBackURL(request);
		
		// === Ajax(JSON)를 사용하여 HIT 상품목록을 "스크롤" 방식으로 페이징처리해서 보여주겠다. === // 
		InterProductDAO pdao = new ProductDAO();
		
		int totalHITCount = pdao.totalPspecCount("1");  // HIT 상품의 전체개수를 알아온다.
		
	//	System.out.println("~~~~ 확인용 totalHITCount : " + totalHITCount);
		// ~~~~ 확인용 totalHITCount : 36
		
		request.setAttribute("totalHITCount", totalHITCount);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/myshop/mallHome2.jsp");
	}

}




