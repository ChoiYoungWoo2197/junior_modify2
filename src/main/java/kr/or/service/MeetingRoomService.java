package kr.or.service;

import java.util.List;

import kr.or.domain.Equipment;
import kr.or.domain.MeetingRoom;
import kr.or.domain.MeetingRoomEquipment;

public interface MeetingRoomService {
	
	//MeetingRoom
	public int insertMeetingRoom(MeetingRoom meetingRoom);
	
	//MeetingRoomEquipment
	public void insertMeetingRoomEquipment(int meetingRoomId, List<String> equipmentList);
	
	//Equipment
	public List<Equipment> selectEquipment();
}
