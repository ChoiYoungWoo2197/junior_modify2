package kr.or.persistence;

import java.util.List;

import kr.or.domain.Equipment;
import kr.or.domain.MeetingRoom;
import kr.or.domain.MeetingRoomEquipment;

public interface MeetingRoomEquipmentDao {
	
	public List<MeetingRoomEquipment> selectMeetingRoomEquipment();
	public void insertMeetingRoomEquipment(int equipmentId, int meetingRoomId);
	public List<MeetingRoomEquipment> selectMeetingRoomEquipmentById(int meetingRoomId);
	
}
