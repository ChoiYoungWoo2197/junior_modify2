package kr.or.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.domain.MeetingRoom;
import kr.or.domain.MeetingRoomEquipment;
import kr.or.domain.Reservation;
import kr.or.domain.SearchCriteria;
import kr.or.persistence.MeetingRoomDao;
import kr.or.persistence.MeetingRoomEquipmentDao;
import kr.or.persistence.ReservationDao;
import kr.or.persistence.ReservationDetailDao;

@Service
public class ReservationServiceImpl implements ReservationService {
	
	@Autowired
	ReservationDao reservationDao;
	
	@Autowired
	MeetingRoomDao meetingRoomDao;
	
	@Autowired
	MeetingRoomEquipmentDao meetingRoomEquipmentDao;
	
	@Autowired
	ReservationDetailDao reservationDetailDao;
	
	@Override
	public List<Reservation> selectReservationByMeetAndDate(int meetingRoomId, String startDate) {
		return reservationDao.selectReservationByMeetAndDate(meetingRoomId, startDate);
	}
	
	@Override
	@Transactional
	public List<Reservation> searchReservation(SearchCriteria searchCriteria) {
		reservationDao.updateReservationByCurrentTime(new Date());
		reservationDao.updateReservationByFinishTime(new Date());
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
	public Reservation selectReservationById(int reservationId) {
		return reservationDao.selectReservationById(reservationId);
	}
	
	@Override
	public void updateReservation(Reservation reservation) {
		reservationDao.updateReservation(reservation);
	}
	
	@Override
	public Reservation selectReservationByMemeberAndTime(int employeeId, Date startTime, Date endTime) {
		return reservationDao.selectReservationByMemeberAndTime(employeeId, startTime, endTime);
	}
	
	@Override
	public List<MeetingRoom> selectMeetingRoom() {
		return meetingRoomDao.selectMeetingRoom();
	}

	@Override
	public MeetingRoom selectMeetingRoomById(int meetingRoomId) {
		return meetingRoomDao.selectMeetingRoomById(meetingRoomId);
	}
	
	@Override
	public int selectMeetingRoomSeatsById(int meetingRoomId) {
		return meetingRoomDao.selectMeetingRoomSeatsById(meetingRoomId);
	}
	
	@Override
	public List<MeetingRoomEquipment> selectMeetingRoomEquipmentById(int meetingRoomId) {
		return meetingRoomEquipmentDao.selectMeetingRoomEquipmentById(meetingRoomId);
	}
	
	@Override
	public String checks(String result, Date startDate, Date endDate, Reservation reservation) {
//		if(string.equals("extend")) {
//			if(reservation.getStartDate().getTime() <= startDate.getTime() && startDate.getTime() <= reservation.getExtendEndDate().getTime()) {
//				result = "false";
//			}
//			if(reservation.getStartDate().getTime() <= endDate.getTime() && endDate.getTime() <= reservation.getExtendEndDate().getTime()) {
//				result = "false";
//			}
//			if(startDate.getTime() <= reservation.getStartDate().getTime() && reservation.getExtendEndDate().getTime() <= endDate.getTime()) {
//				result = "false";
//			}
//		} else {
//			if(reservation.getStartDate().getTime() <= startDate.getTime() && startDate.getTime() <= reservation.getEndDate().getTime()) {
//				result = "false";
//			}
//			if(reservation.getStartDate().getTime() <= endDate.getTime() && endDate.getTime() <= reservation.getEndDate().getTime()) {
//				result = "false";
//			}
//			if(startDate.getTime() <= reservation.getStartDate().getTime() && reservation.getEndDate().getTime() <= endDate.getTime()) {
//				result = "false";
//			}
//		}
		if (reservation.getStartDate().getTime() <= startDate.getTime() && startDate.getTime() <= reservation.getActualEndDate().getTime()) {
			result = "false";
		} else if (reservation.getStartDate().getTime() <= endDate.getTime() && endDate.getTime() <= reservation.getActualEndDate().getTime()) {
			result = "false";
		} else if (startDate.getTime() <= reservation.getStartDate().getTime() && reservation.getActualEndDate().getTime() <= endDate.getTime()) {
			result = "false";
		}
		
		return result;
	}

	@Override
	public boolean availableReservation(Reservation reservation, Date startDate, Date endDate) {
//		if(reservation.getStartDate().getTime() > new Date().getTime()) { //등록 & 수정
//			if (reservation.getStartDate().getTime() < startDate.getTime() && startDate.getTime() < reservation.getActualEndDate().getTime()) {
//				return false;
//			} else if (reservation.getStartDate().getTime() < endDate.getTime() && endDate.getTime() < reservation.getActualEndDate().getTime()) {
//				return false;
//			} else if ((startDate.getTime() <= reservation.getStartDate().getTime()) && (reservation.getActualEndDate().getTime() <= endDate.getTime())) {
//				return false;
//			}
//		} else if(reservation.getStartDate().getTime() <= new Date().getTime()){ //연장신청
//			if (reservation.getStartDate().getTime() < endDate.getTime() && endDate.getTime() <= reservation.getActualEndDate().getTime()) {
//				
//			}
//			
//		}
		if (reservation.getStartDate().getTime() < startDate.getTime() && startDate.getTime() < reservation.getActualEndDate().getTime()) {
			return false;
		} else if (reservation.getStartDate().getTime() < endDate.getTime() && endDate.getTime() < reservation.getActualEndDate().getTime()) {
			return false;
		} else if ((startDate.getTime() <= reservation.getStartDate().getTime()) && (reservation.getActualEndDate().getTime() <= endDate.getTime())) {
			return false;
		}
		return true;
	}

	@Override
	public boolean availableReservation(Date actualEndDate, Date nextStartDate) { //연장
		if(actualEndDate.getTime() > nextStartDate.getTime()) {
			return false;
		}
		return true;
	}

}
