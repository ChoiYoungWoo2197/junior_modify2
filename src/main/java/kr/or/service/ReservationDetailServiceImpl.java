package kr.or.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.or.domain.Reservation;
import kr.or.persistence.ReservationDetailDao;

@Service
public class ReservationDetailServiceImpl implements ReservationDetailService {

	@Autowired
	ReservationDetailDao reservationDetailDao;

	@Override
	public Reservation searchReservationById(int reservationId) {
		// TODO Auto-generated method stub
		return reservationDetailDao.searchReservationById(reservationId);
	}
}
