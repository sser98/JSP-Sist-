package test.string;

public class StringTest {

	public static void main(String[] args) {

		// === 1. charAt(int index) ===
		//  "안녕하세요".charAt(2)  ==>  '하'
		//   01234 
		
		char ch = "안녕하세요".charAt(2);
		System.out.println("ch => "+ch); // ch => 하
		
		String str = "안녕하세요";
		String result = "";
		
		for(int i=str.length()-1; i>=0; i--) {
			result += str.charAt(i);
		}
		
		System.out.println(result);
		// 요세하녕안
		
		// === 2. toCharArray() ===
		// "안녕하세요".toCharArray()  ==> char 타입의 배열로 만들어준다.
		//                              -------------
		//                              |안|녕|하|세|요|
		//                              -------------
		//                               0  1  2  3 4
		
	    char[] chArr = "안녕하세요".toCharArray();
	    result = "";
	    
	    for(int i=chArr.length-1; i>=0; i--) {
	    	result += chArr[i];
	    }
	    
	    System.out.println(result);
		// 요세하녕안
	    
	    // === 3. substring(int 시작index, int 끝index) ===
	    // "안녕하세요".substring(1, 4);  ==> 1번 인덱스인 "녕"부터 4번 인덱스 앞까지인 "세"까지만 뽑아온다.
	    
	    String substr = "안녕하세요".substring(1, 4);
	    System.out.println(substr);  // 녕하세 
	    
	    // === 4. substring(int 시작index) ===
	    // "안녕하세요".substring(1); ==> 1번 인덱스인 "녕"부터 끝까지를 뽑아온다.
	    substr = "안녕하세요".substring(1);
	    System.out.println(substr);  // 녕하세요 
	    
	    String sosu = "2,3,5,7,11,";
	    sosu = sosu.substring(0, sosu.length()-1);
	    System.out.println(sosu); // 2,3,5,7,11
	    
	    String sosu2 = "2,3,5,7,11,";
	    System.out.println( sosu2.substring(6, sosu2.length()) ); // 7,11,
	    System.out.println( sosu2.substring(6) ); // 7,11,
	    
	    // === 5. "문자열".indexOf("찾을문자열") ===
	    //        "문자열"에서 최초로 나오는 "찾을문자열"의 인덱스(int)값을 알려준다.
	    int index = "시작하라 안녕하세요 건강하세요".indexOf("하");
	               //012
	    System.out.println(index); // 2
	    
	    index = "시작하라 안녕하세요 건강하세요".indexOf("하세요");
               //01234567
        System.out.println(index); // 7 
        
        System.out.println("\n~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");
        
        String strMoney = "17,345,678";

        index = strMoney.indexOf(","); // ==> 2
        strMoney = strMoney.substring(0, index) + strMoney.substring(index+1);  // "17"+"345,678"  "17345,678"                      
        
        index = strMoney.indexOf(","); // 5
        strMoney = strMoney.substring(0, index) + strMoney.substring(index+1) ; // "17345"+"678"  "17345678"
        
        index = strMoney.indexOf(","); // -1
        
        System.out.println(index);
                
        System.out.println(strMoney); // 17345,678   17345678  
        
        System.out.println(Integer.parseInt(strMoney) + 100); // 17345778
        
        System.out.println("\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");
        
        String strMoney2 = "1,317,345,678";
        
        do {
        	int idx = strMoney2.indexOf(",");
        	
        	if(idx == -1)
        		break;
        	else 
        		strMoney2 = strMoney2.substring(0, idx) + strMoney2.substring(idx+1);
		} while (true);
	    
        System.out.println(strMoney2); // 1317345678

        System.out.println("\n~~~~~~~~~~~~~~~~~~~~~~~\n");
        
     // === 6. "문자열".lastIndexOf("찾을문자열") ===
	 //        "문자열"에서 마지막으로 나오는 "찾을문자열"의 인덱스(int)값을 알려준다.
        index = "시작하라 안녕하세요 건강하세요".lastIndexOf("하"); 
		        //012
		System.out.println(index); // 13
		
		index = "시작하라 안녕하세요 건강하세요".lastIndexOf("하세요");
		       //01234567
		System.out.println(index); // 13 
		
		sosu = "2,3,5,7,11,";
		sosu = sosu.substring(0, sosu.lastIndexOf(",") );
		System.out.println(sosu); // 2,3,5,7,11
       
		
	// === 7. "문자열".split("구분자") ===
	//       "문자열"을 "구분자"로 잘라서 문자열 배열 타입으로 반환시켜준다.
		System.out.println("\n1.================\n");
		
		String food = "파스타,국밥,볶음밥,고구마,계란말이";
		
		String[] foodArr = food.split(",");
		
		for(int i=0; i<foodArr.length; i++) {
			System.out.println(foodArr[i]);
		}
		/*
		      파스타
		      국밥
		      볶음밥
		      고구마
		      계란말이 
		 */
		
		System.out.println("\n2.================\n");
		
		food = "파스타	국밥	볶음밥	고구마	계란말이";
		
		foodArr = food.split("\t");
		
		for(int i=0; i<foodArr.length; i++) {
			System.out.println(foodArr[i]);
		}
		/*
		      파스타
		      국밥
		      볶음밥
		      고구마
		      계란말이 
		 */
		
		System.out.println("\n3.==== split 사용시 구분자로 . | / 등 특수문자를 사용하려고 할 경우 ====\n");
		
		food = "파스타.국밥.볶음밥.고구마.계란말이";
		
	 // foodArr = food.split(".");
	 // System.out.println("foodArr.length =>" + foodArr.length); 
		 // ==> 0 이 나옴. 즉 . 단독만으로는 구분자로 인식을 못함.
		 // split 사용시 구분자로 . | / 등 특수문자를 사용하려고 할 경우에는 구분자로 인식을 못할 경우가 많으므로
		 // 구분자 앞에 \\ 를 붙이거나 구분자를 [] 로 씌워주면 된다. 즉, [구분자] 이렇게 말이다.
				
	//	foodArr = food.split("[.]");
	//  또는 
		foodArr = food.split("\\."); // ==> split 에서 사용되어지는 구분자는 \\를 앞에 붙여서 사용해야 한다.
		System.out.println("foodArr.length =>" + foodArr.length); // ==> 5 가 나옴. 
		
		for(int i=0; i<foodArr.length; i++) {
			System.out.println(foodArr[i]);
		}
		/*
		      파스타
		      국밥
		      볶음밥
		      고구마
		      계란말이 
		 */
		
		System.out.println("\n4.================\n");
		
		food = "파스타|국밥|볶음밥|고구마|계란말이";
		
		foodArr = food.split("[|]");
		
		for(int i=0; i<foodArr.length; i++) {
			System.out.println(foodArr[i]);
		}
		
		System.out.println("\n5.================\n");
		
		food = "파스타,국밥,볶음밥,고구마,계란말이";
		
		foodArr = food.split("\\,");
		
		for(int i=0; i<foodArr.length; i++) {
			System.out.println(foodArr[i]);
		}
		
		System.out.println("\n6.================\n");
		
		food = "파스타,국밥.볶음밥	고구마,계란말이";
		
		foodArr = food.split("\\,|\\.|\\t");
		
		for(int i=0; i<foodArr.length; i++) {
			System.out.println(foodArr[i]);
		}
		
		System.out.println("\n7.================\n");
		
		food = "파스타1국밥2볶음밥3고구마4계란말이";
		
		foodArr = food.split("\\d"); //  \\d 에서 d는 정규표현식의 하나로써 숫자를 의미한다. 즉 숫자가 구분자가 되는 것이다. 
		
		for(int i=0; i<foodArr.length; i++) {
			System.out.println(foodArr[i]);
		}
		/*
		  	파스타
			국밥
			볶음밥
			고구마
			계란말이
		*/
		
		System.out.println("\n8.================\n");
		
		food = "파스타1국밥2볶음밥3고구마4계란말이";
		
		foodArr = food.split("\\D"); //  \\D 에서 D는 정규표현식의 하나로써 숫자가 아닌것을 의미한다. 즉 숫자가 아닌것이 구분자가 되는 것이다.  
		
		for(int i=0; i<foodArr.length; i++) {
			System.out.println(foodArr[i]);
		}
		/*
		 	1

			2
			
			
			3
			
			
			4
		 */
		System.out.println("\n~~~~~~~~~~~~~~~~~~\n");
		
	// === 8. String.join("구분자", 문자열배열명) ===
	//     	문자열배열을 "구분자"로 합쳐서 하나의 문자열로 반환.
		String[] nameArr = {"한석규","두석규","세석규","네석규","오석규"}; 
		String names = String.join("-", nameArr);
		System.out.println(names); // 한석규-두석규-세석규-네석규-오석규
	
		
	// === 9. "문자열".replaceAll("변경대상문자열","새로이변경될문자열")  ===
	//    	"문자열" 에서 "변경대상문자열"을 모두 "새로이변경될문자열"로 교체해서 반환.
		names = names.replaceAll("석규", "SK");
		System.out.println(names);
		// 한SK-두SK-세SK-네SK-오SK 
	
		
	// === 10. "문자열".replaceFirst("변경대상문자열","새로이변경될문자열")  ===
	//    	"문자열" 에서 "변경대상문자열" 중 첫번째만 "새로이변경될문자열"로 교체해서 반환.
		names = names.replaceFirst("SK", "석규");
		System.out.println(names);
		// 한석규-두SK-세SK-네SK-오SK
		
	System.out.println("\n====== 퀴즈 ======\n");
	    
	    String[] contents = {"호호안녕하세요","건강하세요","행복하세요 또봐요","즐겁고 건강한 하루되세요"}; 
	    
	    // "건강" 이라는 단어가 포함된것을 출력하세요.
	    for(int i=0; i<contents.length; i++) {
	    	int idx = contents[i].indexOf("건강");
	    	if(idx != -1)
	    		System.out.println(contents[i]);
	    }
	    /*
	              건강하세요
	              즐겁고 건강한 하루되세요
	    */
	    
	    System.out.println("=========================");
	    
	    // "건강" 이라는 단어로 시작하는 것만 출력하세요.
	    for(int i=0; i<contents.length; i++) {
	    	int idx = contents[i].indexOf("건강");
	    	if(idx == 0)
	    		System.out.println(contents[i]);
	    }
	    // 건강하세요
	    
	    System.out.println("~~~~~~~~~~~~~~~~~~");
	    
	    // 또는 아래와 같이 할수도 있습니다.
	    // === 11. "문자열".startsWith("찾고자하는문자열")  ===
		//    	"문자열" 에서 "찾고자하는문자열"이 맨첫번째에 나오면 true 를 반환.
	    //      "문자열" 에서 "찾고자하는문자열"이 맨첫번째에 나오지 않으면 false 를 반환.
	    
	    // "건강" 이라는 단어로 시작하는 것만 출력하세요.
	    for(int i=0; i<contents.length; i++) {
	    	boolean bool = contents[i].startsWith("건강");
	    	if(bool)
	    		System.out.println(contents[i]);
	    }
	    // 건강하세요
	    
	    System.out.println("~~~~~~~~~~~~~~~~~~~~~~~");
	    
	 // === 12. "문자열".endsWith("찾고자하는문자열")  ===
	 //    	"문자열" 에서 "찾고자하는문자열"이 맨마지막에 나오면 true 를 반환.
	 //     "문자열" 에서 "찾고자하는문자열"이 맨마지막에 나오지 않으면 false 를 반환.
	    for(int i=0; i<contents.length; i++) {
	    	boolean bool = contents[i].endsWith("하세요");
	    	if(bool)
	    		System.out.println(contents[i]);
	    }
	    /*
	              호호안녕하세요
                     건강하세요 
	    */
	    System.out.println("~~~~~~~~~~~~~~~~~~~~~~~");   
	    
	    String str2 = "My Name is Tom 입니다.";   
	 
	 // === 13. "문자열".toUpperCase()  === 
	 //         "문자열"에서 소문자가 있으면 모두 대문자로 변경해서 반환.
	    System.out.println(str2.toUpperCase());
	    // MY NAME IS TOM 입니다. 
	    
	    System.out.println("~~~~~~~~~~~~~~~~~~~~~~~"); 
	    
	 // === 14. "문자열".toLowerCase()  === 
     //         "문자열"에서 대문자가 있으면 모두 소문자로 변경해서 반환.   
	    System.out.println(str2.toLowerCase());
	    // my name is tom 입니다.
	    
	    System.out.println("~~~~~~~~~~~~~~~~~~~~~~~");
	    
	 // === 15. "문자열".equals("비교대상문자열") ===
	 //         "문자열" 과  "비교대상문자열" 의 값이 일치하면 true 를 반환.
	 //         "문자열" 과  "비교대상문자열" 의 값이 일치하지 않으면 false 를 반환.
	    String str3 = "KoreA";
	    if(str3.equals("KoreA"))
	    	System.out.println("KoreA 를 입력하셨군요.");
	    else
	    	System.out.println("KoreA 를 입력하지 않으셨습니다.");
	    
	    String str4 = null;
	  /*
	    if(str4.equals("Seoul")) // NullPointerException
	    	System.out.println("Seoul 를 입력하셨군요.");
	    else
	    	System.out.println("Seoul 를 입력하지 않으셨습니다.");
	  */ 	
	    if("Seoul".equals(str4)) 
	    	System.out.println("Seoul 를 입력하셨군요.");
	    else
	    	System.out.println("Seoul 를 입력하지 않으셨습니다.");
	    
	    
	 // === 16. "문자열".equalsIgnoreCase("비교대상문자열") ===
	 //         "문자열" 과  "비교대상문자열" 의 값이 대,소문자 관계없이 일치하면 true 를 반환.
	 //         "문자열" 과  "비교대상문자열" 의 값이 대,소문자 관계없이 일치하지 않으면 false 를 반환.   
	    str4 = "KoreA";
	    if("koRea".equalsIgnoreCase(str4)) 
	    	System.out.println("koRea 를 입력하셨군요.");
	    else
	    	System.out.println("koRea 를 입력하지 않으셨군요.");
	    
	    System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	    
	 // === 17. "문자열".trim() ====
	 //        "문자열".trim()은 "문자열"에 좌,우로 공백이 있으면 공백을 모두 제거하고서 반환.
	    String str5 = "        수고     많으셨습니다.         ";
	    System.out.println("첫번째"+str5+"내일 뵐께요~~");
	    System.out.println("첫번째"+str5.trim()+"내일 뵐께요~~");
	    
	 // === 18. "문자열".isEmpty() ===
	 //         "문자열" 이 아무것도 없으면 true 를 반환.
     //         "문자열" 이 뭔가 있으면 false 를 반환.   
	    System.out.println("".isEmpty());              // true 
	    System.out.println("abc".isEmpty());           // false
	    System.out.println("      ".isEmpty());        // false
	    System.out.println("      ".trim().isEmpty()); // true
	    
	 // === 참고 ==== // 
	    System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	    
	    int a = 123;
	    double dbl = 4.567;
	    String str6 = "이제 진짜 끝입니다";
	    
	    System.out.printf("정수 a는 %d 이고\n실수 dbl은 %f 이고\n문자열 str6은 %s 입니다.",a,dbl,str6); 

	}

}
