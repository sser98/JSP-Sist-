package myshop.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import my.util.MyUtil;
import myshop.model.*;

public class CommentRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String fk_userid = request.getParameter("fk_userid");
		String fk_pnum = request.getParameter("fk_pnum");
		String contents = request.getParameter("contents");
		
		// **** 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어 코드) 작성하기 **** // 
		contents = MyUtil.secureCode(contents);
		
		contents = contents.replaceAll("\r\n", "<br>");
		
		PurchaseReviewsVO reviewsvo = new PurchaseReviewsVO();
		reviewsvo.setFk_userid(fk_userid);
		reviewsvo.setFk_pnum(Integer.parseInt(fk_pnum));
		reviewsvo.setContents(contents);
		
		InterProductDAO pdao = new ProductDAO();
		pdao.addComment(reviewsvo);
		
	}

}
