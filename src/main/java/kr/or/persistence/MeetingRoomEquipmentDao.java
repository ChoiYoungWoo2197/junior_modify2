package kr.or.persistence;

import java.util.List;

import kr.or.domain.Equipment;
import kr.or.domain.MeetingRoom;
import kr.or.domain.MeetingRoomEquipment;
import kr.or.domain.SearchCriteria;

public interface MeetingRoomEquipmentDao {
	
	/*
	 * public List<MeetingRoomEquipment> searchMeetingRoomEquipment(SearchCriteria
	 * searchCriteria);
	 */
	public void insertMeetingRoomEquipment(int equipmentId, int meetingRoomId);
	public List<MeetingRoomEquipment> selectMeetingRoomEquipmentById(int meetingRoomId);
	public void deleteMeetingRoomEquipment(int meetingRoomId);
	
}
