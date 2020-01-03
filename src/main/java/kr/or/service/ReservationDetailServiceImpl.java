package kr.or.service;

import java.util.Date;

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
	public String checkTime(Date startDate, Date endDate, Date currentDate, String state) {
		// TODO Auto-generated method stub
		String resultState = "";
		int resultStart =0;
		int resultEnd =0;
		/*
		 * 현재시간 < 기준시간  리턴값 -
		 * 현재시간 > 기준시간  리턴값 +
		 * 현재시간 = 기준시간  리턴값 =
		*/
		resultStart = currentDate.compareTo(startDate);
		resultEnd = currentDate.compareTo(endDate);

		// 현재일시 --- | 시작일시 ~ 종료일시
		if(resultStart < 0 && resultEnd < 0) { //1. 현재일시가 시작일시 -- 종료일시보다 앞선 경우 => 예약 상태(R)
			resultState = "R";
		}
		// 시작일시 ~현재일시~ 종료일시
		else if(resultStart >= 0 && resultEnd < 0) { //2. 현재일시가 시작일시 -- 종료일시사이에 있는 경우 => 진행중(P)
			if(state.equals("R")) { // 진행중이라는걸 알려야 하는 경우
				resultState = "P";
			}
			else if(state.equals("E")) { //연장에 들어간 경우
				resultState = "E";
			}
			
		}
		// 시작일시 ~ 종료일시 | 현재일시
		else if(resultStart > 0 && resultEnd > 0) { //3. 현재일시가 시작일시 -- 종료일시보다 지난 경우 => 종료 상태(F)
			resultState = "F";
		}

		return resultState;
	}
}
