package myshop.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import common.controller.AbstractController;
import myshop.model.InterProductDAO;
import myshop.model.ProductDAO;


public class LikeAddAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// prodView.jsp 뷰단에서 ajax post 방식으로 넘겨준 데이터 값 받기
		
		String userid=request.getParameter("userid");
		String pnum=request.getParameter("pnum");
		
				
		Map <String, String> paraMap = new HashMap<>();
		
		// 메소드 호출시에 별도의 VO를 만들지 않고 Map을 만들어서 값을 넘겨 줄수 있어 편하므로 작성
		
		paraMap.put("pnum", pnum);
		paraMap.put("userid", userid);
		
		InterProductDAO pdao = new ProductDAO();
		
		
		
		
		int n=pdao.likeAdd(paraMap);
		// n => 1 이라면 정상투표, n=> 0 이라면 중복투표
		
		String msg="";
		
		if(n==1) {
			
			msg="해당제품에\n 종아요를 클릭하셨습니다.";
			
		} else {
			
			msg="이미 좋아요를 클릭하셨기에\n 두번 이상 좋아요는 불가합니다.";
			
		}
			
		
		// 값을 넘겨줄 필요없이 alert를 띄우기 위해 msg 안의 값을 변경해줌.
		
		JSONObject jsonObj = new JSONObject();
		
		
		jsonObj.put("msg", msg);  // {"msg":msg} 형태 view단에서 넘겨받을때 객체 자바스크립트에서 객체 안의 속성을 호출하듯 호출
		
		String json=jsonObj.toString(); // "{"n" : "1"}"
		
		request.setAttribute("json", json);
		
		super.setRedirect(false);
		
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
		
		
		
		
	}

}
