package kr.or.persistence;

import java.util.List;

import kr.or.domain.Reservation;
import kr.or.domain.SearchCriteria;

public interface ReservationDetailDao {
	
	public Reservation searchReservationById(int reservationId);

}
