package kr.or.persistence;

import java.util.Date;

import kr.or.domain.Reservation;

public interface ReservationDetailDao {

	public Reservation searchReservationById(int reservationId);
	public void updateCancelReasonByMap(int reservationId,String cancelApplicant, String cancelReason);
	public void updateStateByMap(int reservationId, String state);
	public void updateExitByMap(int reservationId, String validateApplicant, Date actualEndDate);
	public Reservation searchNextReservationById(int reservationId);
}
