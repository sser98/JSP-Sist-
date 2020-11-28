package review.modul;

public class ReviewVO{

	
	private String seq_review; 	  // 리뷰번호
	private String fk_productid;  // 상품아이디
	private String color;         // 색상
	private String userid;        // 아이디
	private String content;       // 내용
	private String score;         // 별점
	private String review_image;  // 상품이미지
	private String wirteday;      // 작성일자 
	
	
	public String getSeq_review() {
		return seq_review;
	}
	public void setSeq_review(String seq_review) {
		this.seq_review = seq_review;
	}
	public String getFk_productid() {
		return fk_productid;
	}
	public void setFk_productid(String fk_productid) {
		this.fk_productid = fk_productid;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public String getReview_image() {
		return review_image;
	}
	public void setReview_image(String review_image) {
		this.review_image = review_image;
	}
	public String getWirteday() {
		return wirteday;
	}
	public void setWirteday(String wirteday) {
		this.wirteday = wirteday;
	}
	
	public ReviewVO() {}
	
	public ReviewVO(String seq_review, String fk_productid, String color, String userid, String content, String score,
			String review_image, String wirteday) {
		
		this.seq_review = seq_review;
		this.fk_productid = fk_productid;
		this.color = color;
		this.userid = userid;
		this.content = content;
		this.score = score;
		this.review_image = review_image;
		this.wirteday = wirteday;
		
	}
	
	
	
	
	
	
	
	
}
