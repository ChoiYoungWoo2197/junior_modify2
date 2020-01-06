package kr.or.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.domain.Extend;
import kr.or.domain.Reservation;
import kr.or.persistence.ExtendDao;
import kr.or.persistence.ReservationDetailDao;

@Service
public class ReservationDetailServiceImpl implements ReservationDetailService {

	@Autowired
	ReservationDetailDao reservationDetailDao;
	
	@Autowired
	ExtendDao extendDao;

	@Override
	public Reservation searchReservationById(int reservationId) {
		// TODO Auto-generated method stub
		return reservationDetailDao.searchReservationById(reservationId);
	}

	@Override
	public void updateCancelReasonByMap(int reservationId, String cancelApplicant, String cancelReason) {
		// TODO Auto-generated method stub
		reservationDetailDao.updateCancelReasonByMap(reservationId, cancelApplicant, cancelReason);
	}

	@Override
	public void updateStateByMap(int reservationId, String state) {
		// TODO Auto-generated method stub
		reservationDetailDao.updateStateByMap(reservationId, state);
	}
	
	@Override
	public void updateExitByMap(int reservationId, String validateApplicant, Date actualEndDate) {
		// TODO Auto-generated method stub
		reservationDetailDao.updateExitByMap(reservationId, validateApplicant, actualEndDate);
	}

	@Override
	public void insertExtendByMap(Extend extand) {
		// TODO Auto-generated method stub
		extendDao.insertExtendByMap(extand);
	}

	@Override
	public Extend searchExtendReasonById(int reservationId) {
		// TODO Auto-generated method stub
		return extendDao.searchExtendReasonById(reservationId);
	}

	@Override
	public Reservation searchNextReservationById(int reservationId) {
		// TODO Auto-generated method stub
		return reservationDetailDao.searchNextReservationById(reservationId);
	}


}
