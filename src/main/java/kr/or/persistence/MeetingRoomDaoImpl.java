package kr.or.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.domain.MeetingRoom;
import kr.or.domain.SearchCriteria;

@Repository
public class MeetingRoomDaoImpl implements MeetingRoomDao {

	private static final String namespace = "kr.or.mappers.meetingRoomMapper";
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<MeetingRoom> searchMeetingRoom(SearchCriteria searchCriteria) {
		return sqlSession.selectList(namespace + ".searchMeetingRoom", searchCriteria);
	}
	
//	@Override
//	public int searchMeetingRoomCount(SearchCriteria searchCriteria) {
//		return sqlSession.selectOne(namespace + ".searchMeetingRoomCount", searchCriteria);
//	}
	
	@Override
	public int insertMeetingRoom(MeetingRoom meetingRoom) {
		return sqlSession.insert(namespace + ".insertMeetingRoom", meetingRoom);
	}

	@Override
	public void updateMeetingRoom(MeetingRoom meetingRoom) {
		sqlSession.update(namespace + ".updateMeetingRoom", meetingRoom);
	}

	@Override
	public void deleteMeetingRoom(int meetingRoomId) {
		sqlSession.delete(namespace + ".deleteMeetingRoom", meetingRoomId);
	}

	@Override
	public MeetingRoom selectMeetingRoomById(int meetingRoomId) {
		return sqlSession.selectOne(namespace + ".selectMeetingRoomById", meetingRoomId);
	}

	@Override
	public List<MeetingRoom> selectMeetingRoom() {
		return sqlSession.selectList(namespace + ".selectMeetingRoom");
	}

	

//	@Override
//	public int selectMeetingRoomSeatsById(int meetingRoomId) {
//		return sqlSession.selectOne(namespace + ".selectMeetingRoomSeatsById", meetingRoomId);
//	}

	
}
