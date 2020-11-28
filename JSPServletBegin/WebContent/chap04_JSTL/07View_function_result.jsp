<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- ==== JSTL(JSP Standard Tag Library) 사용하기 ==== --%>     
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
 
<%--
        === 함수 태그(functions) ===
  
  JSTL은 EL에서 사용할 수 있는 함수 태그를 제공한다.
 
 -------------------------------------------------------------------------------------   
     함수                                                   설명
 -------------------------------------------------------------------------------------   
  length(obj)                      obj가 Conllection인 경우 저장된 항목의 개수를, 문자인 경우 문자열의 길이를 반환
  toUpperCase(str)                 str을 대문자로 변환
  toLowerCase(str)                 str을 소문자로 변환
  substring(str, idx1, idx2)       str.substring(idx1, idx2)의 결과를 반환, idx2가 -1일 경우 str.substring(idx1)과 동일
  substringAfter(str1, str2)       str1에서 str1에 포함되어 있는 str2 이후의 문자열을 구함
  substringBefore(str1, str2)      str1에서 str1에 포함되어 있는 str2 이전의 문자열을 구함
  trim(str)                        str 좌우의 공백 문자를 제거 
  replace(str, src, dest)          str에 있는 src를 dest로 변환
  indexOf(str1, str2)              str1에서 str2가 위치한 인덱스를 구함
  startsWith(str1, str2)           str1이 str2로 시작할 경우 true, 그렇지 않을 경우 false를 반환
  endsWith(str1, str2)             str1이 str2로 끝나는 경우 true, 그렇지 안을 경우 false를 반환
  contains(str1, str2)             st1이 str2를 포함하고 있을 경우 true를 반환
  containsIgnoreCase(str1, str2)   대소문자 구분없이 str1이 str2를 포함하고 있을 경우 true를 반환
  split(str1, str2)                str2로 명시한 글자를 기준으로 str1을 분리해서 배열로 반환 
  join(array, str2)                array에 저장된 문자열을 합침, 각 문자열의 사이에는 str2가 붙음
  
 --%>  
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함수(functions) taglib</title>

<style type="text/css">

	table, th, td {
		border: solid 1px gray;
		border-collapse: collapse;
		padding: 6px;
	} 
	
	th {
		background-color: #ddd;
		font-size: 14pt;
	}

</style>

</head>
<body>
	<h2>JSTL 함수(functions) taglib</h2>
	<table>
		<tr>
			<th>함수</th>
			<th>설명</th>
			<th>결과값</th>
			<th>리턴타입</th>
		</tr>
		<tr>
		    <td>fn:length(strList)</td>
			<td>strList 의 크기</td>
			<td>${ fn:length(strList) }</td>
			<td>int</td>
		</tr>
		<tr>
		    <td>fn:length(subject)</td>
			<td>문자열 &quot;JSTL(JSP Standard Tag Library)&quot; 인 subject의 길이</td>
			<td>${ fn:length(subject) }</td>
			<td>int</td>
		</tr>
		<tr>
			<td>fn:toUpperCase(subject)</td>
			<td>문자열 &quot;JSTL(JSP Standard Tag Library)&quot; 인 subject를 대문자로 변환</td>
			<td>${ fn:toUpperCase(subject) }</td>
			<td>String</td>
		</tr>
		<tr>
			<td>fn:toLowerCase(subject)</td>
			<td>문자열 &quot;JSTL(JSP Standard Tag Library)&quot; 인 subject를 소문자로 변환</td>
			<td>${ fn:toLowerCase(subject) }</td>
			<td>String</td>
		</tr>
		<tr>
			<td>fn:substring(subject, 5, 8)</td>
			<td>문자열 &quot;JSTL(JSP Standard Tag Library)&quot; 인 subject 에서 JSP만 추출</td>
			<td>${ fn:substring(subject, 5, 8) }</td>
			<td>String</td>
		</tr>
		<tr>
			<td>fn:substringAfter(subject, "JSP")</td>  
			<td>문자열 &quot;JSTL(JSP Standard Tag Library)&quot; 인 subject 에서 JSP 다음의 문자열을 추출</td>
			<td>${ fn:substringAfter(subject, "JSP") }</td>  <!-- 또는 "JSP" 대신에 'JSP' 를 사용해도 됨.  -->
			<td>String</td>
		</tr>
		<tr>
			<td>fn:substringBefore(subject, 'JSP')</td>  
			<td>문자열 &quot;JSTL(JSP Standard Tag Library)&quot; 인 subject 에서 JSP 이전의 문자열을 추출</td>
			<td>${ fn:substringBefore(subject, 'JSP') }</td>  <!-- 또는 'JSP' 대신에 "JSP" 를 사용해도 됨.  -->
			<td>String</td>
		</tr>
		<tr>
			<td>fn:trim(lastName)</td> 
			<td>문자열 &quot;&nbsp;&nbsp;&nbsp;길     동&nbsp;&nbsp;&nbsp;&quot; 인 lastName 에서 좌우의 공백 문자를 제거</td>
			<td>${firstName}${ fn:trim(lastName) }${word}</td>  
			<td>String</td>
		</tr>
		<tr>
			<td>fn:replace(subject, "S","에스")</td>  
			<td>문자열 &quot;JSTL(JSP Standard Tag Library)&quot; 인 subject 에서 S 를 에스 로 변환</td>
			<td>${ fn:replace(subject, "S","에스") }</td>  <!-- 대소문자 구분함  -->
			<td>String</td>
		</tr>
		<tr>
			<td>fn:indexOf(subject, "JSP")</td>  <!-- 대소문자 구분함  -->
			<td>문자열 &quot;JSTL(JSP Standard Tag Library)&quot; 인 subject 에서 JSP 가 위치한 인덱스를 구함</td>
			<td>${ fn:indexOf(subject, "JSP") }</td>  <!-- 대소문자 구분함  -->
			<td>int</td>
		</tr>
		<tr>
			<td>fn:startsWith(subject, "JSTL")</td>  <!-- 대소문자 구분함  -->
			<td>문자열 &quot;JSTL(JSP Standard Tag Library)&quot; 인 subject 가 JSTL 로 시작합니까?</td>
			<td>${ fn:startsWith(subject, "JSTL") }</td>  <!-- 대소문자 구분함  -->
			<td>boolean</td>
		</tr>
		<tr>
			<td>fn:endsWith(subject, "ary)")</td>  <!-- 대소문자 구분함  -->
			<td>문자열 &quot;JSTL(JSP Standard Tag Library)&quot; 인 subject 가 ary) 로 끝납니까?</td>
			<td>${ fn:endsWith(subject, "ary)") }</td>  <!-- 대소문자 구분함  -->
			<td>boolean</td>
		</tr>
		<tr>
			<td>fn:contains(subject, "Tag")</td>  <!-- 대소문자 구분함  -->
			<td>문자열 &quot;JSTL(JSP Standard Tag Library)&quot; 인 subject 속에 Tag 라는 문자열이 포함되어 있습니까?</td>
			<td>${ fn:contains(subject, "Tag") }</td>  <!-- 대소문자 구분함  -->
			<td>boolean</td>
		</tr>
		<tr>
			<td>fn:containsIgnoreCase(subject, "tag")</td>  <!-- 대소문자 구분하지 않음 -->
			<td>문자열 &quot;JSTL(JSP Standard Tag Library)&quot; 속에 대소문자 구분없이 tag 라는 문자열이 포함되어 있습니까?</td>
			<td>${ fn:containsIgnoreCase(subject, "tag") }</td>  <!-- 대소문자 구분하지 않음 -->
			<td>boolean</td>
		</tr>
		<tr>
			<td>fn:split(subject, ' ')</td>  <!-- 대소문자 구분하지 않음 -->
			<td>문자열 &quot;JSTL(JSP Standard Tag Library)&quot; 인 subject 를 공백을 구분자로 하여 배열명 array 로 만들기</td>
			<td><c:set var="array" value="${ fn:split(subject, ' ') }" /></td>  <!-- 대소문자 구분하지 않음 -->
			<td>String[]</td>
		</tr>
		<tr>
			<td>fn:join(array, '')</td> 
			<td>공백을 구분자로 만들어진 배열명 array 를  하나의 문자열로 만들기(공백을 제거한 결과가 됨)</td>
			<td>${ fn:join(array, '') }</td> 
			<td>String</td>
		</tr>
		<tr>
			<td>fn:join(array, ',')</td> 
			<td>공백을 구분자로 만들어진 배열명 array 를  하나의 문자열로 만들기(구분자를 콤마로 한 것)</td>
			<td>${ fn:join(array, ',') }</td> 
			<td>String</td>
		</tr>
	</table>
</body>
</html>    