package kr.or.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.domain.Equipment;
import kr.or.domain.MeetingRoom;
import kr.or.domain.MeetingRoomEquipment;

@Repository
public class MeetingRoomEquipmentDaoImpl implements MeetingRoomEquipmentDao {

	private static final String namespace = "kr.or.mappers.meetingRoomEquipmentMapper";

	@Autowired
	SqlSession sqlSession;

	@Override
	public List<MeetingRoomEquipment> listMeetingRoomEquipment() {
		return sqlSession.selectList(namespace + ".listMeetingRoomEquipment");
	}

	@Override
	public void insertMeetingRoomEquipment(int equipmentId, int meetingRoomId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("equipmentId", equipmentId);
		map.put("meetingRoomId", meetingRoomId);
		
		sqlSession.insert(namespace + ".insertMeetingRoomEquipment", map);
	}

}
