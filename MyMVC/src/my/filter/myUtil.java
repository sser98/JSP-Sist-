package my.filter;

import javax.servlet.http.HttpServletRequest;

public class myUtil {
	
	
	public static String getCurrentURL(HttpServletRequest request) {
		
		
		
		
		String currentURL=request.getRequestURL().toString();
		// http://localhost:9090/MyMVC/member/memberList.up
		
		String queryString=request.getQueryString();
		// searchType=name&searchWord=홍승의&sizePerPage=10
		
		currentURL += "?" + queryString;
		
		String ctxPath=request.getContextPath();
		// /MyMVC
		
		
		int beginIndex=currentURL.indexOf(ctxPath) + ctxPath.length();
		// 21 + 6 
		
		
		currentURL =currentURL.substring(beginIndex+1);
		
		return currentURL;
		
		
		/* currentURL을 잘못 가져오므로 이부분에서 수정을 해야함 */
		
	}
}