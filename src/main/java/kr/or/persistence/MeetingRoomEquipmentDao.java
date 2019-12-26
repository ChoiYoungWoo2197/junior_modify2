package kr.or.persistence;

import java.util.List;

import kr.or.domain.Equipment;
import kr.or.domain.MeetingRoom;
import kr.or.domain.MeetingRoomEquipment;

public interface MeetingRoomEquipmentDao {
	
	public List<MeetingRoomEquipment> listMeetingRoomEquipment();
	public void insertMeetingRoomEquipment(int equipmentId, int meetingRoomId);
	
}
