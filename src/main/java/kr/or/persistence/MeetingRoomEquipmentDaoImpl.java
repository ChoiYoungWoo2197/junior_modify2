package kr.or.persistence;

import java.util.List;

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
	public List<MeetingRoomEquipment> listMeetingRoomEquipment() {
		return sqlSession.selectList(namespace + ".listMeetingRoomEquipment");
	}

	@Override
	public void insertMeetingRoomEquipment(MeetingRoomEquipment meetingRoomEquipment) {
		sqlSession.insert(namespace + ".insertMeetingRoomEquipment", meetingRoomEquipment);
	}

}
