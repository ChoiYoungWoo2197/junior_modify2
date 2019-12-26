package kr.or.persistence;

import java.util.List;

import kr.or.domain.MeetingRoom;

public interface MeetingRoomDao {
	
	public List<MeetingRoom> listMeetingRoom();
	public int insertMeetingRoom(MeetingRoom meetingRoom);
	public void updateMeetingRoom(MeetingRoom meetingRoom);
	public void deleteMeetingRoom(int meetingRoomId);

}
