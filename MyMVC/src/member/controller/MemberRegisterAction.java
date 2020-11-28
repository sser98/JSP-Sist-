package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.*;

public class MemberRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		String snstype = request.getParameter("snstype"); 
		
		if("GET".equalsIgnoreCase(method)) {
		
		//  super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/memberRegister.jsp");
		}
	
	//	else { 
		else if("POST".equalsIgnoreCase(method) && snstype == null) {
			// 일반적인 회원으로 회원가입한 경우 라면
			
			String name = request.getParameter("name"); 
			String userid = request.getParameter("userid"); 
			String pwd = request.getParameter("pwd"); 
			String email = request.getParameter("email"); 
			String hp1 = request.getParameter("hp1"); 
			String hp2 = request.getParameter("hp2"); 
			String hp3 = request.getParameter("hp3"); 
			String postcode = request.getParameter("postcode");
			String address = request.getParameter("address"); 
			String detailAddress = request.getParameter("detailAddress"); 
			String extraAddress = request.getParameter("extraAddress"); 
			String gender = request.getParameter("gender"); 
			String birthyyyy = request.getParameter("birthyyyy"); 
			String birthmm = request.getParameter("birthmm"); 
			String birthdd = request.getParameter("birthdd");
			
			String mobile = hp1+hp2+hp3;
			String birthday = birthyyyy+"-"+birthmm+"-"+birthdd;
			
			MemberVO member = new MemberVO(userid, pwd, name, email, mobile, postcode, address, detailAddress, extraAddress, gender, birthday);  
			
			InterMemberDAO mdao = new MemberDAO();
			int n = mdao.registerMember(member);
			
			String message = "";
			String loc = "";
			
			if(n == 1) {
				message = "회원가입 성공";
				loc = request.getContextPath()+"/index.up"; // 시작페이지로 이동한다. 
			}
			else {
				message = "회원가입 실패";
				loc = "javascript:history.back()" ; // 자바스크립트를 이용한 이전페이지로 이동하는것.
			}
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		else if("POST".equalsIgnoreCase(method) && "kakao".equals(snstype)) {
			// 카카오 로그인을 시도하여 회원가입한 경우 라면
			
			String name = request.getParameter("name"); 
			String userid = request.getParameter("userid"); 
			String pwd = request.getParameter("pwd"); 
			String email = request.getParameter("email"); 
			String hp1 = request.getParameter("hp1"); 
			String hp2 = request.getParameter("hp2"); 
			String hp3 = request.getParameter("hp3"); 
			String postcode = request.getParameter("postcode");
			String address = request.getParameter("address"); 
			String detailAddress = request.getParameter("detailAddress"); 
			String extraAddress = request.getParameter("extraAddress"); 
			String gender = request.getParameter("gender"); 
			String birthyyyy = request.getParameter("birthyyyy"); 
			String birthmm = request.getParameter("birthmm"); 
			String birthdd = request.getParameter("birthdd");
			
			String mobile = hp1+hp2+hp3;
			String birthday = birthyyyy+"-"+birthmm+"-"+birthdd;
			
			MemberVO member = new MemberVO(userid, pwd, name, email, mobile, postcode, address, detailAddress, extraAddress, gender, birthday);  
			
			InterMemberDAO mdao = new MemberDAO();
			int n = mdao.registerMember(member);
			
			JSONObject jsonObj = new JSONObject(); // {}
			jsonObj.put("n", n);  // {"n":1} 또는 {"n":0} 으로 만들어준다.
			
			String json = jsonObj.toString(); // 문자열 형태인 {"n":1} 또는 {"n":0} 으로 만들어준다. 
		//	System.out.println(">>> 확인용 json => " + json);
		//  {"n":1}	{"n":0}
			
			request.setAttribute("json", json);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		}
		
	}

}
