package kr.or.persistence;

import java.util.List;

import kr.or.domain.MeetingRoom;
import kr.or.domain.SearchCriteria;

public interface MeetingRoomDao {
	
	public List<MeetingRoom> searchMeetingRoom(SearchCriteria searchCriteria);
	public int searchMeetingRoomCount(SearchCriteria searchCriteria);
	public int insertMeetingRoom(MeetingRoom meetingRoom);
	public void updateMeetingRoom(MeetingRoom meetingRoom);
	public void deleteMeetingRoom(int meetingRoomId);
	public MeetingRoom listMeetingRoomEquipmentById(int meetingRoomId);
}
