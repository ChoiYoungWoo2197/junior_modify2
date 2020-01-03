package kr.or.service;

import java.util.Date;

import kr.or.domain.Reservation;

public interface ReservationDetailService {
	public Reservation searchReservationById(int reservationId);
	public void updateCancelReasonByMap(int reservationId,String cancelApplicant, String cancelReason);
	public void updateStateByMap(int reservationId, String state);
	public String checkTime(Date startDate, Date endDate, Date currentDate, String State);
}
