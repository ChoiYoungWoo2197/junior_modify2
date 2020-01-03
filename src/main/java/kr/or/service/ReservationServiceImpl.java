package kr.or.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.domain.MeetingRoom;
import kr.or.domain.MeetingRoomEquipment;
import kr.or.domain.Reservation;
import kr.or.domain.SearchCriteria;
import kr.or.persistence.MeetingRoomDao;
import kr.or.persistence.MeetingRoomEquipmentDao;
import kr.or.persistence.ReservationDao;

@Service
public class ReservationServiceImpl implements ReservationService {
	
	@Autowired
	ReservationDao reservationDao;
	
	@Autowired
	MeetingRoomDao meetingRoomDao;
	
	@Autowired
	MeetingRoomEquipmentDao meetingRoomEquipmentDao;
	
	@Override
	public List<Reservation> selectReservationByMeetAndDate(int meetingRoomId, String startDate) {
		return reservationDao.selectReservationByMeetAndDate(meetingRoomId, startDate);
	}
	
	@Override
	public List<Reservation> searchReservation(SearchCriteria searchCriteria) {
		return reservationDao.searchReservation(searchCriteria);
	}
	
	@Override
	public int searchReservationCount(SearchCriteria searchCriteria) {
		return reservationDao.searchReservationCount(searchCriteria);
	}
	
	@Override
	public void insertReservation(Reservation reservation) {
		reservationDao.insertReservation(reservation);
	}
	
	@Override
	public List<MeetingRoom> selectMeetingRoom() {
		return meetingRoomDao.selectMeetingRoom();
	}

	@Override
	public MeetingRoom selectMeetingRoomById(int meetingRoomId) {
		return meetingRoomDao.selectMeetingRoomById(meetingRoomId);
	}
	
//	@Override
//	public int selectMeetingRoomSeatsById(int meetingRoomId) {
//		return meetingRoomDao.selectMeetingRoomSeatsById(meetingRoomId);
//	}
	
	@Override
	public List<MeetingRoomEquipment> selectMeetingRoomEquipmentById(int meetingRoomId) {
		return meetingRoomEquipmentDao.selectMeetingRoomEquipmentById(meetingRoomId);
	}

	

	

	

	
}
