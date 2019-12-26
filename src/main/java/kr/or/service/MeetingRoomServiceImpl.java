package kr.or.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.domain.Equipment;
import kr.or.domain.MeetingRoom;
import kr.or.domain.MeetingRoomEquipment;
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
	public int insertMeetingRoom(MeetingRoom meetingRoom) {
		return meetingRoomDao.insertMeetingRoom(meetingRoom);
	}

	@Override
	public void insertMeetingRoomEquipment(int meetingRoomId, List<String> equipmentList) {
		for(String equipmentId : equipmentList) {
			System.out.println(meetingRoomId + "&-----------------------------");
			System.out.println(equipmentId + "&-----------------------------");
			meetingRoomEquipmentDao.insertMeetingRoomEquipment(Integer.parseInt(equipmentId), meetingRoomId);
		}
	}
	
	@Override
	public List<Equipment> selectEquipment() {
		return equipmentDao.selectEquipment();
	}

	


	

}
