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
	public MeetingRoom selectMeetingRoomById(int meetingRoomId);
	public void updateMeetingRoom(MeetingRoom meetingRoom);
	public void deleteMeetingRoom(int meetingRoomId);
	
	//MeetingRoomEquipment
	public void insertMeetingRoomEquipment(int meetingRoomId, List<String> equipmentList);

	/*
	 * public List<MeetingRoomEquipment> searchMeetingRoomEquipment(SearchCriteria
	 * searchCriteria);
	 */
	public List<MeetingRoomEquipment> selectMeetingRoomEquipmentById(int meetingRoomId);
	public void deleteMeetingRoomEquipment(int meetingRoomId);
	
	//Equipment
	public List<Equipment> selectEquipment();
}
