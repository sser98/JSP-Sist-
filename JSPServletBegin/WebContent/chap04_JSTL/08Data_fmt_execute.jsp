<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String[] pointArr1 = {"10","20.4","30.5","46"};
	request.setAttribute("pointArr1", pointArr1);

	String[] pointArr2 = null;
	request.setAttribute("pointArr2", pointArr2);
	
	int[] priceArr = {50000, 100000, 250000, 150000, 2000000};
	request.setAttribute("priceArr", priceArr);

	RequestDispatcher dispatcher = request.getRequestDispatcher("08View_fmt_result.jsp"); 
	dispatcher.forward(request, response);
%>    