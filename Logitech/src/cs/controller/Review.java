package cs.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import review.modul.InterReviewDAO;
import review.modul.ReviewDAO;
import review.modul.ReviewVO;



public class Review extends AbstractController {

	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
			
		String productid= request.getParameter("productid");
		HttpSession session =request.getSession();
		MemberVO mvo=  (MemberVO) (session.getAttribute("loginuser") );
		String userid=mvo.getUserid();
		
		InterReviewDAO rdao = new ReviewDAO();
		
		List<ReviewVO> reviewlist = rdao.getReviewlist(productid);
		
		request.setAttribute("reviewlist", reviewlist);

		// view 단으로 넘겨줌.
		
		super.setViewPage("/WEB-INF/customCenter/review.jsp");
		
		
		
	}

}
