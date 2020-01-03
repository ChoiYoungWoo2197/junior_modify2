package kr.or.domain;

import java.util.Date;

import org.hibernate.validator.constraints.NotEmpty;

public class Reservation {
 	 private int reservationId;
	 private int employeeId;
	 private int meetingRoomId;
	 @NotEmpty(message="회의목적을 입력하세요")
	 private String meetPurpose;
	 private int meetAttendess;
	 private Date startDate;
	 private Date endDate;
	 private Date reservationDate;
	 private String state;
	 private Date modifyDate;
	 private Date actualEndDate;
	 private Date validateTime;
	 private String validateApplicant;
	 private String validateChecker;
	 private String abnormality;
	 private String cancelApplicant;
	 private Date cancelDate;
	 private String cancelReason;
	 private String employeeName;
	 private String departmentName;
	 private String meetingRoomName;
	 
	 public int getReservationId() {
		return reservationId;
	}
	public void setReservationId(int reservationId) {
		this.reservationId = reservationId;
	}
	public int getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(int employeeId) {
		this.employeeId = employeeId;
	}
	public int getMeetingRoomId() {
		return meetingRoomId;
	}
	public void setMeetingRoomId(int meetingRoomId) {
		this.meetingRoomId = meetingRoomId;
	}
	public String getMeetPurpose() {
		return meetPurpose;
	}
	public void setMeetPurpose(String meetPurpose) {
		this.meetPurpose = meetPurpose;
	}
	public int getMeetAttendess() {
		return meetAttendess;
	}
	public void setMeetAttendess(int meetAttendess) {
		this.meetAttendess = meetAttendess;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public Date getReservationDate() {
		return reservationDate;
	}
	public void setReservationDate(Date reservationDate) {
		this.reservationDate = reservationDate;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public Date getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}
	public Date getActualEndDate() {
		return actualEndDate;
	}
	public void setActualEndDate(Date actualEndDate) {
		this.actualEndDate = actualEndDate;
	}
	public Date getValidateTime() {
		return validateTime;
	}
	public void setValidateTime(Date validateTime) {
		this.validateTime = validateTime;
	}
	public String getValidateApplicant() {
		return validateApplicant;
	}
	public void setValidateApplicant(String validateApplicant) {
		this.validateApplicant = validateApplicant;
	}
	public String getValidateChecker() {
		return validateChecker;
	}
	public void setValidateChecker(String validateChecker) {
		this.validateChecker = validateChecker;
	}
	public String getAbnormality() {
		return abnormality;
	}
	public void setAbnormality(String abnormality) {
		this.abnormality = abnormality;
	}
	public String getCancelApplicant() {
		return cancelApplicant;
	}
	public void setCancelApplicant(String cancelApplicant) {
		this.cancelApplicant = cancelApplicant;
	}
	public Date getCancelDate() {
		return cancelDate;
	}
	public void setCancelDate(Date cancelDate) {
		this.cancelDate = cancelDate;
	}
	public String getCancelReason() {
		return cancelReason;
	}
	public void setCancelReason(String cancelReason) {
		this.cancelReason = cancelReason;
	}
	public String getEmployeeName() {
		return employeeName;
	}
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}
	public String getDepartmentName() {
		return departmentName;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	public String getMeetingRoomName() {
		return meetingRoomName;
	}
	public void setMeetingRoomName(String meetingRoomName) {
		this.meetingRoomName = meetingRoomName;
	}
	@Override
	public String toString() {
		return "Reservation [reservationId=" + reservationId + ", employeeId=" + employeeId + ", meetingRoomId="
				+ meetingRoomId + ", meetPurpose=" + meetPurpose + ", meetAttendess=" + meetAttendess + ", startDate="
				+ startDate + ", endDate=" + endDate + ", reservationDate=" + reservationDate + ", state=" + state
				+ ", modifyDate=" + modifyDate + ", actualEndDate=" + actualEndDate + ", validateTime=" + validateTime
				+ ", validateApplicant=" + validateApplicant + ", validateChecker=" + validateChecker + ", abnormality="
				+ abnormality + ", cancelApplicant=" + cancelApplicant + ", cancelDate=" + cancelDate
				+ ", cancelReason=" + cancelReason + ", employeeName=" + employeeName + ", departmentName="
				+ departmentName + ", meetingRoomName=" + meetingRoomName + "]";
	}
}
