package kr.or.test;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.or.domain.MeetingRoom;
import kr.or.persistence.MeetingRoomDao;

@RunWith(SpringJUnit4ClassRunner.class) //-> 스프링의 테스트 컨텍스트 프레임워크의 JUnit 확장기능 지정
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/root-context.xml"}) //참고할 컨텍스트의 위치 지정
public class MeetingRoomTest {
	
	@Autowired
	MeetingRoomDao meetingRoomDao;
	
	/*@Test
	public void testList() {
		List<MeetingRoom> list = meetingRoomDao.listMeetingRoom();
		
		for(MeetingRoom meetingRoom : list) {
			System.out.println(meetingRoom.getName());
		}
	}*/
	
	//@Test
	public void testInsert() {
		MeetingRoom meetingRoom = new MeetingRoom();
		meetingRoom.setManagerId(1111);
		meetingRoom.setName("1踰덊쉶�쓽�떎");
		meetingRoom.setSeats(10);
		meetingRoom.setAvailability(true);
		
		meetingRoomDao.insertMeetingRoom(meetingRoom);
		System.out.println(meetingRoom.getName());
	}
	
	@Test
	public void testUpdate() {
		MeetingRoom meetingRoom = new MeetingRoom();
		meetingRoom.setMeetingRoomId(4);
		meetingRoom.setManagerId(1111);
		meetingRoom.setName("1踰덊쉶�쓽�떎�엯�땲�떎!~~");
		meetingRoom.setSeats(7);
		meetingRoom.setAvailability(true);
		
		meetingRoomDao.updateMeetingRoom(meetingRoom);
		System.out.println(meetingRoom.getName());
	}
	
	//@Test
	public void testDelete() {
		meetingRoomDao.deleteMeetingRoom(4);
	}
}
