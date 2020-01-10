package kr.or.controller;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.domain.Equipment;
import kr.or.domain.MeetingRoom;
import kr.or.domain.MeetingRoomEquipment;
import kr.or.domain.Page;
import kr.or.domain.SearchCriteria;
import kr.or.service.MeetingRoomService;

@Controller
@RequestMapping("/meetingRoom")
public class MeetingRoomController {
	
	//private static final Logger logger = LoggerFactory.getLogger(MeetingRoomController.class);
	
	@Autowired
	MeetingRoomService meetingRoomService;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(SearchCriteria searchCriteria, Model model) {
		List<MeetingRoom> meetingRoomList = meetingRoomService.searchMeetingRoom(searchCriteria);
		model.addAttribute("meetingRoomList", meetingRoomList);
		
		model.addAttribute("searchCriteria", searchCriteria);
		model.addAttribute("page", new Page(meetingRoomService.searchMeetingRoomCount(searchCriteria), searchCriteria));
		
		return "meetingRoom/list";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String insertPage(Model model) {
		List<Equipment> equipmentList = meetingRoomService.selectEquipment();
		model.addAttribute("equipmentList", equipmentList);
		
		return "meetingRoom/insert";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insert(MeetingRoom meetingRoom, String checkTrue) {
		meetingRoom.setRegisterDate(new Date());
		meetingRoomService.insertMeetingRoom(meetingRoom);
		
		if(!checkTrue.equals("")) {
			List<String> equipmentList = Arrays.asList(checkTrue.split(","));
			
			int meetingRoomId = meetingRoom.getMeetingRoomId();
			meetingRoomService.insertMeetingRoomEquipment(meetingRoomId, equipmentList);
		}
		
		return "redirect:/meetingRoom/list";
	}
	
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String read(Model model, int meetingRoomId) {
		MeetingRoom meetingRoom = meetingRoomService.selectMeetingRoomById(meetingRoomId);
		model.addAttribute("meetingRoom", meetingRoom);
		
		List<MeetingRoomEquipment> meetingRoomEquipmentList = meetingRoomService.selectMeetingRoomEquipmentById(meetingRoomId);
		model.addAttribute("meetingRoomEquipmentList", meetingRoomEquipmentList);

		return "meetingRoom/read";
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public String modifyPage(Model model, int meetingRoomId) {
		MeetingRoom meetingRoom = meetingRoomService.selectMeetingRoomById(meetingRoomId);
		model.addAttribute("meetingRoom", meetingRoom);
		
		List<MeetingRoomEquipment> meetingRoomEquipmentList = meetingRoomService.selectMeetingRoomEquipmentById(meetingRoomId);
		model.addAttribute("meetingRoomEquipmentList", meetingRoomEquipmentList);
		
		List<Equipment> equipmentList = meetingRoomService.selectEquipment();
		model.addAttribute("equipmentList", equipmentList);
		
		return "meetingRoom/modify";
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.POST) 
	public String modify(MeetingRoom meetingRoom, String checkTrue) {
		meetingRoomService.updateMeetingRoom(meetingRoom);
		
		if(!checkTrue.equals("")) {
			List<String> equipmentList = Arrays.asList(checkTrue.split(","));
			
			meetingRoomService.deleteMeetingRoomEquipment(meetingRoom.getMeetingRoomId());
			meetingRoomService.insertMeetingRoomEquipment(meetingRoom.getMeetingRoomId(), equipmentList);
		}
		
		return "redirect:/meetingRoom/read?meetingRoomId="+meetingRoom.getMeetingRoomId();
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String delete(Model model, int meetingRoomId) {
		meetingRoomService.deleteMeetingRoomEquipment(meetingRoomId);
		meetingRoomService.deleteMeetingRoom(meetingRoomId);
		
		return "redirect:/meetingRoom/list";
	}
}
