package kr.or.persistence;

import kr.or.domain.Reservation;

public interface ReservationDetailDao {
	
	public Reservation searchReservationById(int reservationId);
	public void updateCancelReasonByMap(int reservationId,String cancelApplicant, String cancelReason);

}
