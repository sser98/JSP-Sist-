<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>    

<%
	List<String> strList = new ArrayList<String>();
    strList.add("일순신");
    strList.add("이순신");
    strList.add("삼순신");
    strList.add("사순신");
    strList.add("오순신");
	request.setAttribute("strList", strList); 
	
	String subject = "JSTL(JSP Standard Tag Library)";
	request.setAttribute("subject", subject);
	
	String firstName = "홍";
	String lastName = "          길     동                ";
	String word = "만세";
	request.setAttribute("firstName", firstName);
	request.setAttribute("lastName", lastName);
	request.setAttribute("word", word);
	
	
	RequestDispatcher dispatcher = request.getRequestDispatcher("07View_function_result.jsp"); 
	dispatcher.forward(request, response);
%>


    