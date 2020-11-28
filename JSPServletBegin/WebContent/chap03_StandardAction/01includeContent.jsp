<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.Date" %>    

<%
   // *** 현재시각을 알아오기 *** //
   Date now = new Date();    // 현재시각
   String currentTime = String.format("%tF %tT %tA", now, now, now);
%>

&copy; 이 웹페이지의 저작권은 이순신씨에게 있습니다.<br>
<span style="color: blue; font-weight: bold;"><%= currentTime%></span>
