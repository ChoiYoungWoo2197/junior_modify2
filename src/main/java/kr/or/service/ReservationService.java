package kr.or.service;

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
//	public void updateReservation(Reservation reservation);
	
	//MeetingRoom
	public List<MeetingRoom> selectMeetingRoom();
	public MeetingRoom selectMeetingRoomById(int meetingRoomId);
//	public int selectMeetingRoomSeatsById(int meetingRoomId);
	
	//MeetingRoomEquipment
	public List<MeetingRoomEquipment> selectMeetingRoomEquipmentById(int meetingRoomId);
}
