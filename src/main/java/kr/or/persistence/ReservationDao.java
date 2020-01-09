package kr.or.persistence;

import java.util.Date;
import java.util.List;

import kr.or.domain.Reservation;
import kr.or.domain.SearchCriteria;

public interface ReservationDao {
	
	public List<Reservation> selectReservationByMeetAndDate(int meetingRoomId, String startDate);
	public List<Reservation> searchReservation(SearchCriteria searchCriteria);
	public int searchReservationCount (SearchCriteria searchCriteria);
	public void insertReservation(Reservation reservation);
	public Reservation selectReservationById(int reservationId);
	public void updateReservation(Reservation reservation);
	public void updateReservationByCurrentTime(Date currentTime);
	public void updateReservationByFinishTime(Date currentTime);
	public Reservation selectReservationByMemeberAndTime(int employeeId, Date startTime, Date endTime);
	
}
