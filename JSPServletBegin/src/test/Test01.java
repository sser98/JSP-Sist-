package test;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Test01 {

	public static void main(String[] args) {
		
		String name = "이순신";
		System.out.println(name);
		
		Date now = new Date();
		SimpleDateFormat sdfrmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String today = sdfrmt.format(now);
		
		System.out.println(today);
		
		int point = 100;
		double height = 178.5;
		String irum = "차은우";
		
		System.out.printf("나의 이름은 %s 입니다. 신장은 %f cm이고, 점수는 %d 입니다.",irum,height,point);    
		

	}

}
