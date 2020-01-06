 package kr.or.service;

import java.util.Date;

import kr.or.domain.Extend;
import kr.or.domain.Reservation;

public interface ReservationDetailService {
	public Reservation searchReservationById(int reservationId);
	public void updateCancelReasonByMap(int reservationId,String cancelApplicant, String cancelReason);
	public void updateStateByMap(int reservationId, String state);
	public void updateExitByMap(int reservationId, String validateApplicant, Date actualEndDate);
	public void insertExtendByMap(Extend extand);
	public Extend searchExtendReasonById(int reservationId);
	public Reservation searchNextReservationById(int reservationId);
}
