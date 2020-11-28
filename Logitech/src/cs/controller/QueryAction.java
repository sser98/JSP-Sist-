package cs.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;


public class QueryAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		
		HttpSession session=request.getSession();
		
		MemberVO loginuser= (MemberVO)session.getAttribute("loginuser");
		
		
		if(loginuser != null) {
			// 로그인 했을 경우.
				
			super.setViewPage("/WEB-INF/oneQueryform.jsp");
				
			}
		
		
		else {
			// 로그인을 안한 경우, 일반사용자로 로그인 한 경우.
			
			super.setViewPage("/WEB-INF/oneQueryform.jsp");
			// 로그인 화면으로 옮겨줌.
		
		}
		
		
	}

}
