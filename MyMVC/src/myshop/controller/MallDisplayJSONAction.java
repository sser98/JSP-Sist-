package myshop.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import myshop.model.*;

public class MallDisplayJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String sname = request.getParameter("sname");  // "HIT" 
		String start = request.getParameter("start");
		String len = request.getParameter("len");
	/*
	       맨 처음에는 sname("HIT")상품을  start("1") 부터 len("8")개를 보여준다.
	       더보기... 버튼을 클릭하면  sname("HIT")상품을  start("9") 부터 len("8")개를 보여준다.
	       또  더보기... 버튼을 클릭하면  sname("HIT")상품을  start("17") 부터 len("8")개를 보여준다.      
    */
		
		InterProductDAO pdao = new ProductDAO();
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("sname", sname);
		paraMap.put("start", start);         // start  "1"   "9"   "17"   "25"   "33"
		
		String end = String.valueOf( Integer.parseInt(start) + Integer.parseInt(len) - 1 );
		
		paraMap.put("end", end);             // end => start + len - 1; 
		                                     // end    "8"   "16"  "24"   "32"   "40" 
		
		
		List<ProductVO> prodList = pdao.selectBySpecName(paraMap);
		
		JSONArray jsonArr = new JSONArray();  // []
		
		if( prodList.size() > 0 ) {
			
			for(ProductVO pvo : prodList) {
				
				JSONObject jsonObj = new JSONObject(); // {}  {}
				
				jsonObj.put("pnum", pvo.getPnum());    
				jsonObj.put("pname", pvo.getPname());
				jsonObj.put("code", pvo.getCategvo().getCode());
				jsonObj.put("pcompany", pvo.getPcompany());
				jsonObj.put("pimage1", pvo.getPimage1());
				jsonObj.put("pimage2", pvo.getPimage2());
				jsonObj.put("pqty", pvo.getPqty());
				jsonObj.put("price", pvo.getPrice());
				jsonObj.put("saleprice", pvo.getSaleprice());
				jsonObj.put("sname", pvo.getSpvo().getSname());
				jsonObj.put("pcontent", pvo.getPcontent());
				jsonObj.put("point", pvo.getPoint());
				jsonObj.put("pinputdate", pvo.getPinputdate());
				jsonObj.put("discoutPercent", pvo.getDiscountPercent());
				
				// jsonObj ==> {"pnum":1, "pname":"스마트TV", "code":"100000", "pcompany":"삼성", ..... , "pinputdate":"2020-11-13"}        
				// jsonObj ==> {"pnum":2, "pname":"노트북", "code":"100000", "pcompany":"엘지", ..... , "pinputdate":"2020-11-13"}
				
				jsonArr.put(jsonObj);
				/*
				   [  {"pnum":1, "pname":"스마트TV", "code":"100000", "pcompany":"삼성", ..... , "pinputdate":"2020-11-13"}
				    , {"pnum":2, "pname":"노트북", "code":"100000", "pcompany":"엘지", ..... , "pinputdate":"2020-11-13"}
				    , ........
				    , {.....} ]
				*/    
				
			}// end of for-----------------------------
			
			String json = jsonArr.toString();  // 문자열로 변환
			
		//	System.out.println("~~~~ 확인용 json => " + json);
		/*
		 ~~~~ 확인용 json => [{"pnum":1,"code":"100000","pname":"스마트TV","pcompany":"삼성","saleprice":800000,"point":50,"pinputdate":"2020-11-13","pimage1":"tv_samsung_h450_1.png","pqty":100,"pimage2":"tv_samsung_h450_2.png","pcontent":"42인치 스마트 TV. 기능 짱!!","price":1200000,"sname":"HIT"},{"pnum":2,"code":"100000","pname":"노트북","pcompany":"엘지","saleprice":750000,"point":30,"pinputdate":"2020-11-13","pimage1":"notebook_lg_gt50k_1.png","pqty":150,"pimage2":"notebook_lg_gt50k_2.png","pcontent":"노트북. 기능 짱!!","price":900000,"sname":"HIT"},{"pnum":3,"code":"200000","pname":"바지","pcompany":"S사","saleprice":10000,"point":5,"pinputdate":"2020-11-13","pimage1":"cloth_canmart_1.png","pqty":20,"pimage2":"cloth_canmart_2.png","pcontent":"예뻐요!!","price":12000,"sname":"HIT"},{"pnum":4,"code":"200000","pname":"남방","pcompany":"버카루","saleprice":13000,"point":10,"pinputdate":"2020-11-13","pimage1":"cloth_buckaroo_1.png","pqty":50,"pimage2":"cloth_buckaroo_2.png","pcontent":"멋져요!!","price":15000,"sname":"HIT"},{"pnum":5,"code":"300000","pname":"세계탐험보물찾기시리즈","pcompany":"아이세움","saleprice":33000,"point":20,"pinputdate":"2020-11-13","pimage1":"book_bomul_1.png","pqty":100,"pimage2":"book_bomul_2.png","pcontent":"만화로 보는 세계여행","price":35000,"sname":"HIT"},{"pnum":6,"code":"300000","pname":"만화한국사","pcompany":"녹색지팡이","saleprice":120000,"point":60,"pinputdate":"2020-11-13","pimage1":"book_koreahistory_1.png","pqty":80,"pimage2":"book_koreahistory_2.png","pcontent":"만화로 보는 이야기 한국사 전집","price":130000,"sname":"HIT"},{"pnum":7,"code":"100000","pname":"노트북1","pcompany":"DELL","saleprice":1000000,"point":60,"pinputdate":"2020-11-13","pimage1":"1.jpg","pqty":100,"pimage2":"2.jpg","pcontent":"1번 노트북","price":1200000,"sname":"HIT"},{"pnum":8,"code":"100000","pname":"노트북2","pcompany":"에이서","saleprice":1000000,"point":60,"pinputdate":"2020-11-13","pimage1":"3.jpg","pqty":100,"pimage2":"4.jpg","pcontent":"2번 노트북","price":1200000,"sname":"HIT"}] 
		 
		 -- *** 만약에  select 되어진 정보가 없다라면 [] 로 나오므로 null 이 아닌 요소가 없는 빈배열이다. *** -- 
		*/
			
			request.setAttribute("json", json);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
		}
		
	}

}
