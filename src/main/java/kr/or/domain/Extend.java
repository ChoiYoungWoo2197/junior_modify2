package kr.or.domain;

import java.util.Date;

public class Extend {
	
	private int extendId;
	private int reservationId;
	private Date applicationDate;
	private Date endDate;
	private String extendReason;
	
	public int getExtendId() {
		return extendId;
	}
	public void setExtendId(int extendId) {
		this.extendId = extendId;
	}
	public int getReservationId() {
		return reservationId;
	}
	public void setReservationId(int reservationId) {
		this.reservationId = reservationId;
	}
	public Date getApplicationDate() {
		return applicationDate;
	}
	public void setApplicationDate(Date applicationDate) {
		this.applicationDate = applicationDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public String getExtendReason() {
		return extendReason;
	}
	public void setExtendReason(String extendReason) {
		this.extendReason = extendReason;
	}


}
