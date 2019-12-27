package kr.or.service;

import java.util.List;

import kr.or.domain.MeetingRoom;
import kr.or.domain.MeetingRoomEquipment;
import kr.or.domain.Reservation;
import kr.or.domain.SearchCriteria;

public interface ReservationService {

	//Reservation
	public List<Reservation> searchReservation(SearchCriteria searchCriteria);
	public int searchReservationCount (SearchCriteria searchCriteria);
	public List<Reservation> selectReservationByMeetAndDate(Reservation reservation);
	public void insertReservation(Reservation reservation);
	public void updateReservation(Reservation reservation);
	
	//MeetingRoom
	public MeetingRoom selectMeetingRoomById(int meetingRoomId);
	
	//MeetingRoomEquipment
	public MeetingRoomEquipment selectMeetingRoomEquipmentById(int meetingRoomId);
}