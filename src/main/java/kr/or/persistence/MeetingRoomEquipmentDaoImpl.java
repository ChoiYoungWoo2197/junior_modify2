package kr.or.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.domain.MeetingRoomEquipment;

@Repository
public class MeetingRoomEquipmentDaoImpl implements MeetingRoomEquipmentDao {

	private static final String namespace = "kr.or.mappers.meetingRoomEquipmentMapper";

	@Autowired
	SqlSession sqlSession;

	@Override
	public List<MeetingRoomEquipment> selectMeetingRoomEquipment() {
		return sqlSession.selectList(namespace + ".selectMeetingRoomEquipment");
	}

	@Override
	public void insertMeetingRoomEquipment(int equipmentId, int meetingRoomId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("equipmentId", equipmentId);
		map.put("meetingRoomId", meetingRoomId);
		
		sqlSession.insert(namespace + ".insertMeetingRoomEquipment", map);
	}

	@Override
	public List<MeetingRoomEquipment> selectMeetingRoomEquipmentById(int meetingRoomId) {
		return sqlSession.selectList(namespace + ".selectMeetingRoomEquipmentById", meetingRoomId);
	}

}
