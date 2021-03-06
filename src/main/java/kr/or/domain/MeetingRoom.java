package kr.or.domain;

import java.util.Date;
import java.util.List;

public class MeetingRoom {
	private int meetingRoomId;
	private int managerId;
	private String name;
	private int seats;
	private boolean availability;
	private Date registerDate;
	private String meetingRoomEquipmenet;
	
	public int getMeetingRoomId() {
		return meetingRoomId;
	}
	public void setMeetingRoomId(int meetingRoomId) {
		this.meetingRoomId = meetingRoomId;
	}
	public int getManagerId() {
		return managerId;
	}
	public void setManagerId(int managerId) {
		this.managerId = managerId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getSeats() {
		return seats;
	}
	public void setSeats(int seats) {
		this.seats = seats;
	}
	public boolean isAvailability() {
		return availability;
	}
	public void setAvailability(boolean availability) {
		this.availability = availability;
	}
	public Date getRegisterDate() {
		return registerDate;
	}
	public void setRegisterDate(Date registerDate) {
		this.registerDate = registerDate;
	}
	public String getMeetingRoomEquipmenet() {
		return meetingRoomEquipmenet;
	}
	public void setMeetingRoomEquipmenet(String meetingRoomEquipmenet) {
		this.meetingRoomEquipmenet = meetingRoomEquipmenet;
	}
	
	
}
