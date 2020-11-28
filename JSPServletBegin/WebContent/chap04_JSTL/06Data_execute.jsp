<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
//  String myfriends = null;
//  String myfriends = "";
//	String myfriends = " ";
	String myfriends = "이제훈,고수,강산애,강동원,주원";
    myfriends = (myfriends == null)?null:myfriends.trim();
    
    String mymembers = "수지,혜리,사나,서지혜,화사";
    
    String myheowons = "이수지,김혜리.왜사나,오지혜/와화사";
    
    request.setAttribute("myfriends", myfriends);
    request.setAttribute("mymembers", mymembers);
    request.setAttribute("myheowons", myheowons);

    RequestDispatcher dispatcher = request.getRequestDispatcher("06View_result.jsp");
    dispatcher.forward(request, response);
%>



    