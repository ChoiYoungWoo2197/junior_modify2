package kr.or.persistence;

import java.util.List;

import kr.or.domain.Reservation;
import kr.or.domain.SearchCriteria;

public interface ReservationDao {
	
	public List<Reservation> searchReservation(SearchCriteria searchCriteria);
	public int searchReservationCount (SearchCriteria searchCriteria);
	public List<Reservation> selectReservationByMeetAndDate(Reservation reservation);
	public void insertReservation(Reservation reservation);
	public void updateReservation(Reservation reservation);
	
}
