package kr.or.service;

import kr.or.domain.MeetingRoom;
import kr.or.domain.MeetingRoomEquipment;

public interface MeetingRoomService {
	
	//MeetingRoom
	public void insertMeetingRoom(MeetingRoom meetingRoom, MeetingRoomEquipment meetingRoomEquipment);
	
}