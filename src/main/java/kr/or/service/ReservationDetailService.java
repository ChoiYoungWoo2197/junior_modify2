 package kr.or.service;

import java.util.Date;

import kr.or.domain.Extend;
import kr.or.domain.Reservation;

public interface ReservationDetailService {
	public Reservation searchReservationById(int reservationId);
	public void updateCancelReasonByMap(int reservationId,String cancelApplicant, String cancelReason);
	public void updateStateByMap(int reservationId, String state);
	public void updateExitByMap(int reservationId, String validateApplicant, Date actualEndDate);
	public String checkStateByTime(Date startDate, Date endDate, Date currentDate);
	public void insertExtendByMap(Extend extand);
}
