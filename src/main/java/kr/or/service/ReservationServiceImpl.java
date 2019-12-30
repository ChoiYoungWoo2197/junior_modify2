package kr.or.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.domain.MeetingRoom;
import kr.or.domain.MeetingRoomEquipment;
import kr.or.persistence.MeetingRoomDao;
import kr.or.persistence.MeetingRoomEquipmentDao;

@Service
public class ReservationServiceImpl implements ReservationService {
	
	@Autowired
	MeetingRoomDao meetingRoomDao;
	
	@Autowired
	MeetingRoomEquipmentDao meetingRoomEquipmentDao;
	
	@Override
	public List<MeetingRoom> selectMeetingRoom() {
		return meetingRoomDao.selectMeetingRoom();
	}

	@Override
	public MeetingRoom selectMeetingRoomById(int meetingRoomId) {
		return meetingRoomDao.selectMeetingRoomById(meetingRoomId);
	}

	@Override
	public List<MeetingRoomEquipment> selectMeetingRoomEquipmentById(int meetingRoomId) {
		return meetingRoomEquipmentDao.selectMeetingRoomEquipmentById(meetingRoomId);
	}

	
}
