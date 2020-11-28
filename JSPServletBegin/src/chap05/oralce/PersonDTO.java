package chap05.oralce;

public class PersonDTO {
	
	private int seq;
	private String name;
	private String school;
	private String color;
	private String[] food;
	private String registerday;
	
	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getRegisterday() {
		return registerday;
	}

	public void setRegisterday(String registerday) {
		this.registerday = registerday;
	}

	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getSchool() {
		return school;
	}
	
	public void setSchool(String school) {
		this.school = school;
	}
	
	public String getColor() {
		return color;
	}
	
	public void setColor(String color) {
		this.color = color;
	}
	
	public String[] getFood() {
		return food;
	}
	
	public void setFood(String[] food) {
		this.food = food;
	}
	
	//////////////////////////////////////////////////

	public String getStrFood() {
		return String.join(",", food);
	}
	
}







