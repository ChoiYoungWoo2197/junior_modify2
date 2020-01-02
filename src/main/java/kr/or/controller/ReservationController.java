package kr.or.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.domain.MeetingRoom;
import kr.or.domain.MeetingRoomEquipment;
import kr.or.domain.Reservation;
import kr.or.domain.SearchCriteria;
import kr.or.service.ReservationService;

@Controller
@RequestMapping("/reservation/*")
public class ReservationController {
	
	private static final Logger logger = LoggerFactory.getLogger(ReservationController.class);
	
	@Autowired
	ReservationService reservationService;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(SearchCriteria searchCriteria, Model model) {
		logger.info("list");
		
		List<Reservation> reservationList = reservationService.searchReservation(searchCriteria);
		model.addAttribute("reservationList", reservationList);
		
		return "reservation/list";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String insertPage(Model model) {
		logger.info("insertPage");
		
		List<MeetingRoom> meetingRoomList = reservationService.selectMeetingRoom();
		model.addAttribute("meetingRoomList", meetingRoomList);
		
		return "reservation/insert";
	}
	
	@RequestMapping(value = "/infoMeet", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> infoMeet(int meetingRoomId) {
		logger.info("infoMeet & meetingRoomId : " + meetingRoomId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		MeetingRoom meetingRoom = reservationService.selectMeetingRoomById(meetingRoomId);
		List<MeetingRoomEquipment> meetingRoomEquipmentList = reservationService.selectMeetingRoomEquipmentById(meetingRoomId);
		
		map.put("meetingRoom", meetingRoom);
		map.put("meetingRoomEquipmentList", meetingRoomEquipmentList);
		
		return map;
	}
	
	@RequestMapping(value = "/infoReserve", method = RequestMethod.GET)
	public @ResponseBody List<Reservation> infoReserve(int meetingRoomId, String choiceDay) {
		logger.info("infoReserve & meetingRoomId : " + meetingRoomId);
		logger.info("infoReserve & choiceDay : " + choiceDay);
		
		String startDate = choiceDay.substring(0, 4)+"-"+choiceDay.substring(4, 6)+"-"+choiceDay.substring(6, 8);
		List<Reservation> reservationList = reservationService.selectReservationByMeetAndDate(meetingRoomId, startDate);
		
		return reservationList;
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insert() {
		logger.info("insert");
		
		
		return "redirect:/reservation/list";
	}
}
