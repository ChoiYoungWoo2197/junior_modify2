package kr.or.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.domain.Reservation;
import kr.or.domain.SearchCriteria;

@Repository
public class ReservationDaoImpl implements ReservationDao {
private static final String namespace = "kr.or.mappers.reservationMapper";
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<Reservation> selectReservationByMeetAndDate(int meetingRoomId, String startDate) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("meetingRoomId", meetingRoomId);
		map.put("startDate", startDate);
		
		return sqlSession.selectList(namespace + ".selectReservationByMeetAndDate", map);
	}

	@Override
	public List<Reservation> searchReservation(SearchCriteria searchCriteria) {
		return sqlSession.selectList(namespace + ".searchReservation", searchCriteria);
	}

}
