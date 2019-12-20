package kr.or.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.domain.MeetingRoom;
import kr.or.domain.MeetingRoomEquipment;
import kr.or.persistence.MeetingRoomDao;
import kr.or.persistence.MeetingRoomEquipmentDao;

@Service
public class MeetingRoomServiceImpl implements MeetingRoomService {
	
	@Autowired
	MeetingRoomDao meetingRoomDao;
	
	@Autowired
	MeetingRoomEquipmentDao meetingRoomEquipmentDao;
	
	@Override
	@Transactional
	public void insertMeetingRoom(MeetingRoom meetingRoom, MeetingRoomEquipment meetingRoomEquipment) {
		meetingRoomDao.insertMeetingRoom(meetingRoom);
		meetingRoomEquipmentDao.insertMeetingRoomEquipment(meetingRoomEquipment);
	}

}
