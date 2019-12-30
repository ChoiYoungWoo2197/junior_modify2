package kr.or.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.domain.Equipment;
import kr.or.domain.MeetingRoom;
import kr.or.domain.MeetingRoomEquipment;
import kr.or.domain.SearchCriteria;
import kr.or.persistence.EquipmentDao;
import kr.or.persistence.MeetingRoomDao;
import kr.or.persistence.MeetingRoomEquipmentDao;

@Service
public class MeetingRoomServiceImpl implements MeetingRoomService {

	@Autowired
	MeetingRoomDao meetingRoomDao;
	
	@Autowired
	MeetingRoomEquipmentDao meetingRoomEquipmentDao;
	
	@Autowired
	EquipmentDao equipmentDao;
	
	@Override
	public List<MeetingRoom> searchMeetingRoom(SearchCriteria searchCriteria) {
		return meetingRoomDao.searchMeetingRoom(searchCriteria);
	}
	
	@Override
	public int searchMeetingRoomCount(SearchCriteria searchCriteria) {
		return meetingRoomDao.searchMeetingRoomCount(searchCriteria);
	}

	@Override
	public int insertMeetingRoom(MeetingRoom meetingRoom) {
		return meetingRoomDao.insertMeetingRoom(meetingRoom);
	}

	@Override
	public MeetingRoom selectMeetingRoomById(int meetingRoomId) {
		return meetingRoomDao.selectMeetingRoomById(meetingRoomId);
	}
	
	@Override
	public void updateMeetingRoom(MeetingRoom meetingRoom) {
		meetingRoomDao.updateMeetingRoom(meetingRoom);
	}
	
	@Override
	public void deleteMeetingRoom(int meetingRoomId) {
		meetingRoomDao.deleteMeetingRoom(meetingRoomId);
	}
	
	@Override
	public void insertMeetingRoomEquipment(int meetingRoomId, List<String> equipmentList) {
		for(String equipmentId : equipmentList) {
			System.out.println(equipmentId);
			meetingRoomEquipmentDao.insertMeetingRoomEquipment(Integer.parseInt(equipmentId), meetingRoomId);
		}
	}
	
	/*
	 * @Override public List<MeetingRoomEquipment>
	 * searchMeetingRoomEquipment(SearchCriteria searchCriteria) { return
	 * meetingRoomEquipmentDao.searchMeetingRoomEquipment(searchCriteria); }
	 */

	@Override
	public List<MeetingRoomEquipment> selectMeetingRoomEquipmentById(int meetingRoomId) {
		return meetingRoomEquipmentDao.selectMeetingRoomEquipmentById(meetingRoomId);
	}
	
	@Override
	public void deleteMeetingRoomEquipment(int meetingRoomId) {
		meetingRoomEquipmentDao.deleteMeetingRoomEquipment(meetingRoomId);
	}
	
	@Override
	public List<Equipment> selectEquipment() {
		return equipmentDao.selectEquipment();
	}

}
