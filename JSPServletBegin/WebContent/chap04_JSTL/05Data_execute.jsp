<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.*, chap03.PersonDTO" %>    

<%
	String[] nameArr1 = {"일순신","이순신","삼순신","사순신","오순신"}; 
	request.setAttribute("nameArr1", nameArr1);
	
	List<PersonDTO> personList = new ArrayList<>();
	
	PersonDTO ps1 = new PersonDTO();
	ps1.setName("아이유");
	ps1.setSchool("대졸");
	ps1.setColor("red");
	ps1.setFood("쵸코렛,마이쥬,쵸코파이".split("\\,"));
	
	PersonDTO ps2 = new PersonDTO();
	ps2.setName("이미자");
	ps2.setSchool("초대졸");
	ps2.setColor("blue");
	ps2.setFood("육회비빔밥,광어회,조개구이,참이슬".split("\\,"));
	
	PersonDTO ps3 = new PersonDTO();
	ps3.setName("강산애");
	ps3.setSchool("고졸");
	ps3.setColor("yellow");
	ps3.setFood("라면,떡볶이,순대,피자".split("\\,"));
	
	personList.add(ps1);
	personList.add(ps2);
	personList.add(ps3);
	
	request.setAttribute("personList", personList);
	
	////////////////////////////////////////////////////////////////////////
	
	String[] nameArr2 = {}; 
	request.setAttribute("nameArr2", nameArr2);
	
	List<PersonDTO> personList2 = new ArrayList<>();
	request.setAttribute("personList2", personList2);
	
	
	String[] nameArr3 = null; 
	request.setAttribute("nameArr3", nameArr3);
	
	List<PersonDTO> personList3 = null;
	request.setAttribute("personList3", personList3);
	
		
	RequestDispatcher dispatcher = request.getRequestDispatcher("05View_result.jsp");
	dispatcher.forward(request, response);
%>    




