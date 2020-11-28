package chap03;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/03forwardCalc.do")
public class ForwardCalc extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String firstNum = request.getParameter("firstNum");
		String secondNum = request.getParameter("secondNum");
		
	 	int nFirstNum = Integer.parseInt(firstNum);
	 	int nSecondNum = Integer.parseInt(secondNum);
	 	
	 	int sum = 0;
	 	for(int i=nFirstNum; i<=nSecondNum; i++) {
	 		sum += i;
	 	}
	 	
	 	request.setAttribute("sum", sum);
	 	
	 	RequestDispatcher dispatcher = request.getRequestDispatcher("/chap03_StandardAction/03forwardCalcView.jsp");
	 	dispatcher.forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
