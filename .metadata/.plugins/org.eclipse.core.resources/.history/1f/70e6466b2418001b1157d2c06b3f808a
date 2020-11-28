<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%>
<!DOCTYPE html>
<html>
<head>

<title>:::HOMEPAGE:::</title>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/style.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		
		var vhtml = "";
		for(var i=0; i<15; i++) {
			vhtml += (i+1)+".내용물<br/>";
		}
		
		$("#sideconent").html(vhtml);
		
	});

</script>

</head>
<body>

<div id="mycontainer">

	<div id="headerImg">
		<div class="row">
			<div class="col-md-3">1. 로고이미지/네비게이터</div>
			<div class="col-md-2"><a href="http://www.samsung.com"><img src="<%= ctxPath %>/images/logo1.png"/></a></div>
			<div class="col-md-2"><img src="<%= ctxPath %>/images/logo2.png"/></div>
		</div>
	</div>
	
	<div id="headerLink">
		<div class="row">
			<div class="col-md-4">
				<a href="<%= ctxPath %>/index.jsp">HOME</a>
			</div>
			
			<div class="col-md-4">
				<a href="<%= ctxPath %>/member/memberform.jsp">회원가입</a>
			</div>
			
			<div class="col-md-4">
				<a href="<%= ctxPath %>/member/memberList.jsp">회원목록</a>
			</div>
		</div>
	</div>
	
	<div id="sideinfo">
		<div class="row">
			<div class="col-md-12" style="height: 50px; text-align: left; padding: 20px;">
				2. 로그인/Tree/View
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" id="sideconent" style="text-align: left; padding: 20px;">
			</div>
		</div>	
	</div>
	
	<div id="content" align="center">