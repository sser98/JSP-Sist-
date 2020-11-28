package member.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;

public class CoinUpdateLoginUserAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String userid = request.getParameter("userid");
		String coinmoney = request.getParameter("coinmoney");
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("coinmoney", coinmoney);
		
		InterMemberDAO mdao = new MemberDAO();
		int n = mdao.coinUpdate(paraMap); // DB에 코인 및 포인트 변경하기 
		
		String message = "";
		String loc = "";
		
		if(n==1) {
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			loginuser.setCoin( loginuser.getCoin() + Integer.parseInt(coinmoney) );
			loginuser.setPoint( loginuser.getPoint() + (int) (Integer.parseInt(coinmoney)*0.01) ); 
						
			message = loginuser.getName()+"님의 "+coinmoney+"원 결제가 완료되었습니다.";
			loc = request.getContextPath()+"/index.up";
		}
		else {
			message = "코인액 결제가 실패되었습니다.";
			loc = "javascript:history.back()";
		}
		
		request.setAttribute("message", message);
		request.setAttribute("loc", loc);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/msg.jsp");
	}

}



