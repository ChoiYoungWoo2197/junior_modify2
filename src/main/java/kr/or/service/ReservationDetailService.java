package kr.or.service;

import kr.or.domain.Reservation;

public interface ReservationDetailService {
	public Reservation searchReservationById(int reservationId);
	public void updateCancelReasonByMap(int reservationId,String cancelApplicant, String cancelReason);
	public void updateStateByMap(int reservationId, String state);

}
