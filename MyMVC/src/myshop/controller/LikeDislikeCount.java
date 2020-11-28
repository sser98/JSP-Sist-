package myshop.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import myshop.model.InterProductDAO;
import myshop.model.ProductDAO;


public class LikeDislikeCount extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String pnum=request.getParameter("pnum");
		
		InterProductDAO pdao = new ProductDAO();
		
		Map<String, String> map = pdao.getLikeDislikeCnt(pnum);
		
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("likecnt", map.get("likecnt"));
		jsonObj.put("dislikecnt", map.get("dislikecnt"));
		
		
		String json=jsonObj.toString();
		
		
		request.setAttribute("json", json);
		
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
		
		
		
	}

}
