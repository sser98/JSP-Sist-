package test.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class Test1Controller extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setAttribute("name", "서영학");
		
		// super.setRedirect(false);
		super.setViewPage("/WEB-INF/test/test1.jsp");
		
	}

}
