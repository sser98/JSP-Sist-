package chap05.oralce;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/personSelect.do")
public class PersonSelect extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// tbl_person_interest 테이블에 저장되어진 행(데이터)을 읽어다가(select) 웹페이지에 보여주어야 한다. 
		InterPersonDAO dao = new PersonDAO();
		
		List<PersonDTO> personList;
		
		try {
			personList = dao.selectAll();
			request.setAttribute("personList", personList);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/chap05_oracle/personSelectAll.jsp");
			dispatcher.forward(request, response);
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
