package chap05.oralce;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/personUpdate.do")
public class PersonUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String method = request.getMethod();
		InterPersonDAO dao = new PersonDAO();
		
		if("GET".equalsIgnoreCase(method)) {
			
			String seq = request.getParameter("seq");
			
			String path = "";
			
			try {
				PersonDTO psdto = dao.selectOne(seq); 
				request.setAttribute("psdto", psdto);
				
				path = "/WEB-INF/chap05_oracle/personUpdate.jsp";
			} catch (SQLException e) {
				e.printStackTrace();
				
				path = "/WEB-INF/chap05_oracle/sqlerror.jsp";
			}
			
			RequestDispatcher dispatcher = request.getRequestDispatcher(path);
			dispatcher.forward(request, response);
			
		}
		
		else {
			String seq = request.getParameter("seq");
			String name = request.getParameter("name");
			String school = request.getParameter("school");
			String color = request.getParameter("color");
			String[] foodArr = request.getParameterValues("food"); 
			
			PersonDTO psdto = new PersonDTO();
			psdto.setSeq(Integer.parseInt(seq));
			psdto.setName(name);
			psdto.setSchool(school);
			psdto.setColor(color);
			psdto.setFood(foodArr);
			
			String pathName = "";
			
			try {
				int n = dao.personUpdate(psdto);
				
				if(n == 1) {
					pathName = "/WEB-INF/chap05_oracle/personUpdate_ok.jsp";
				}
				else {
					pathName = "/WEB-INF/chap05_oracle/personUpdate_fail.jsp";
				}
			} catch (SQLException e) {
				e.printStackTrace();
				pathName = "/WEB-INF/chap05_oracle/sqlerror.jsp";
			}
			
			RequestDispatcher dispatcher = request.getRequestDispatcher(pathName);
			dispatcher.forward(request, response);
		}
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
