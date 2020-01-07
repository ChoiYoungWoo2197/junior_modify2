package kr.or.persistence;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import kr.or.domain.Reservation;


@Repository
public class ReservationDetailDaoImpl implements ReservationDetailDao {
private static final String namespace = "kr.or.mappers.reservationDetailMapper";
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public Reservation searchReservationById(int reservationId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace + ".searchReservationById", reservationId);
	}
	
	@Override
	public void updateCancelReasonByMap(int reservationId, String cancelApplicant, String cancelReason) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		map.put("reservationId", reservationId);
		map.put("cancelApplicant", cancelApplicant);
		map.put("cancelReason", cancelReason);
		sqlSession.update(namespace + ".updateCancelReasonByMap", map);
	}

	@Override
	public void updateStateByMap(int reservationId, String state) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		map.put("reservationId", reservationId);
		map.put("state", state);
		sqlSession.update(namespace + ".updateStateByMap", map);
	}

	@Override
	public void updateExitByMap(int reservationId, String validateApplicant, Date actualEndDate) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		map.put("reservationId", reservationId);
		map.put("validateApplicant", validateApplicant);
		map.put("actualEndDate", actualEndDate);
		sqlSession.update(namespace + ".updateExitByMap", map);
		
	}

	@Override
	public List<Reservation> searchNextReservationById(int reservationId) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace + ".searchNextReservationById", reservationId);
	}

	@Override
	public void updateExitCheckByMap(int reservationId, String validateChecker, String abnormality) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		map.put("reservationId", reservationId);
		map.put("validateChecker", validateChecker);
		map.put("abnormality", abnormality);
		sqlSession.update(namespace + ".updateExitCheckByMap", map);
	}

	

}
