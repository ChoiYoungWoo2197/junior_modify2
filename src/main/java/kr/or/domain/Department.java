package kr.or.domain;

import java.util.Date;

public class Department {
	private int departmentId;
	private String name;
	private Date registerDate;
	private int emoloyeeCount;
	
	public int getDepartmentId() {
		return departmentId;
	}
	public void setDepartmentId(int departmentId) {
		this.departmentId = departmentId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getRegisterDate() {
		return registerDate;
	}
	public void setRegisterDate(Date registerDate) {
		this.registerDate = registerDate;
	}
	public int getEmoloyeeCount() {
		return emoloyeeCount;
	}
	public void setEmoloyeeCount(int emoloyeeCount) {
		this.emoloyeeCount = emoloyeeCount;
	}
}
