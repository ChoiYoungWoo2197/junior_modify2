package kr.or.controller;

import java.util.Arrays;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.domain.Equipment;
import kr.or.domain.MeetingRoom;
import kr.or.domain.MeetingRoomEquipment;
import kr.or.service.MeetingRoomService;

@Controller
@RequestMapping("/meetingRoom/*")
public class MeetingRoomController {
	
	private static final Logger logger = LoggerFactory.getLogger(MeetingRoomController.class);
	
	@Autowired
	MeetingRoomService meetingRoomService;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model) {
		logger.info("meetingRoom list");
		
		return "meetingRoom/list";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String insertPage(Model model) {
		logger.info("insertPage");
		
		List<Equipment> equipmentList = meetingRoomService.selectEquipment();
		model.addAttribute("equipmentList", equipmentList);
		
		return "meetingRoom/insert";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insert(MeetingRoom meetingRoom, String checkTrue) {
		logger.info("insert & checkTrue : " + checkTrue);
		logger.info("name : " + meetingRoom.getName() + " & seats : " + meetingRoom.getSeats());
		
		List<String> equipmentList = Arrays.asList(checkTrue.split(","));
		
		int meetingRoomId = meetingRoomService.insertMeetingRoom(meetingRoom);
		meetingRoomService.insertMeetingRoomEquipment(meetingRoomId, equipmentList);
		
		return "redirect:/meetingRoom/list";
	}
}
