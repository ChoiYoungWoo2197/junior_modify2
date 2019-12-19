package kr.or.persistence;

import java.util.List;

import kr.or.domain.MeetingRoomEquipment;

public interface MeetingRoomEquipmentDao {
	
	public List<MeetingRoomEquipment> listMeetingRoomEquipment();
	public void insertMeetingRoomEquipment(MeetingRoomEquipment meetingRoomEquipment);
	
}
