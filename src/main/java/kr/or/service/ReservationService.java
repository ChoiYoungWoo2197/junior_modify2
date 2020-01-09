package kr.or.service;

import java.util.Date;
import java.util.List;

import kr.or.domain.MeetingRoom;
import kr.or.domain.MeetingRoomEquipment;
import kr.or.domain.Reservation;
import kr.or.domain.SearchCriteria;

public interface ReservationService {

	//Reservation
	public List<Reservation> selectReservationByMeetAndDate(int meetingRoomId, String startDate);
	public List<Reservation> searchReservation(SearchCriteria searchCriteria);
	public int searchReservationCount (SearchCriteria searchCriteria);
	public void insertReservation(Reservation reservation);
	public Reservation selectReservationById(int reservationId);
	public void updateReservation(Reservation reservation);
	public Reservation selectReservationByMemeberAndTime(int employeeId, Date time);
	
	//MeetingRoom
	public List<MeetingRoom> selectMeetingRoom();
	public MeetingRoom selectMeetingRoomById(int meetingRoomId);
	public int selectMeetingRoomSeatsById(int meetingRoomId);
	
	//MeetingRoomEquipment
	public List<MeetingRoomEquipment> selectMeetingRoomEquipmentById(int meetingRoomId);
	
	//함수
	public String checks(String result, Date startDate, Date endDate, Reservation reservation);
	public boolean availableReservation(Reservation reservation, Date startDate, Date endDate);
	public boolean availableReservation(Date actualEndDate, Date nextStartDate);
}
