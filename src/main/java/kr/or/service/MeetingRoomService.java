package kr.or.service;

import java.util.List;

import kr.or.domain.Equipment;
import kr.or.domain.MeetingRoom;
import kr.or.domain.MeetingRoomEquipment;
import kr.or.domain.SearchCriteria;

public interface MeetingRoomService {
	
	//MeetingRoom
	public List<MeetingRoom> searchMeetingRoom(SearchCriteria searchCriteria);
	public int searchMeetingRoomCount(SearchCriteria searchCriteria);
	public int insertMeetingRoom(MeetingRoom meetingRoom);
	
	//MeetingRoomEquipment
	public void insertMeetingRoomEquipment(int meetingRoomId, List<String> equipmentList);
	public List<MeetingRoomEquipment> listMeetingRoomEquipment();
	
	//Equipment
	public List<Equipment> selectEquipment();
}
