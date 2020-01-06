package kr.or.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import kr.or.domain.Page;
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
		
		List<MeetingRoom> meetingRoomList = reservationService.selectMeetingRoom();
		model.addAttribute("meetingRoomList", meetingRoomList);
		
		model.addAttribute("searchCriteria", searchCriteria);
		model.addAttribute("page", new Page(reservationService.searchReservationCount(searchCriteria), searchCriteria));
		
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
		//int meetingRoomSeats = reservationService.selectMeetingRoomSeatsById(meetingRoomId);
		
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
	public String insert(Model model, Reservation reservation, String start, String end) {
		logger.info("insert");
		
//		String choiceDate = choiceDay.substring(0, 4)+"-"+choiceDay.substring(4, 6)+"-"+choiceDay.substring(6, 8);
//		List<Reservation> reservationList = reservationService.selectReservationByMeetAndDate(reservation.getMeetingRoomId(), choiceDate);
		
		Date startDate = null;
		Date endDate = null;
		try {
			startDate = new SimpleDateFormat("yyyy-MM-dd kk:mm").parse(start); //String -> Date : parse & Date -> String : format
			endDate = new SimpleDateFormat("yyyy-MM-dd kk:mm").parse(end);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		System.out.println(startDate);
		System.out.println(endDate);
		
		/*
		for(Reservation res : reservationList) {
			if(res.getStartDate().getTime() <= startDate.getTime() && startDate.getTime() <= res.getEndDate().getTime()) {
				System.out.println("예약불가1");
				model.addAttribute("msg", "이미 예약된 건이 있습니다. 다른 시간을 선택해주세요..");
				return "reservation/insert";
			}
			if(res.getStartDate().getTime() <= endDate.getTime() && endDate.getTime() <= res.getEndDate().getTime()) {
				System.out.println("예약불가2");
				model.addAttribute("msg", "이미 예약된 건이 있습니다. 다른 시간을 선택해주세요..");
				return "reservation/insert";
			}
			
		}
		*/
		
		reservation.setStartDate(startDate);
		reservation.setEndDate(endDate);
		
		reservationService.insertReservation(reservation);
		
		return "redirect:/reservation/list";
	}
	
	@RequestMapping(value = "/check", method = RequestMethod.GET)
	public @ResponseBody String check(String choiceDay) {
		logger.info("check");
		
//		String choiceDate = choiceDay.substring(0, 4)+"-"+choiceDay.substring(4, 6)+"-"+choiceDay.substring(6, 8);
//		List<Reservation> reservationList = reservationService.selectReservationByMeetAndDate(reservation.getMeetingRoomId(), choiceDate);
//		
//		for(Reservation res : reservationList) {
//			if(res.getStartDate().getTime() <= startDate.getTime() && startDate.getTime() <= res.getEndDate().getTime()) {
//				return "false";
//			}
//			if(res.getStartDate().getTime() <= endDate.getTime() && endDate.getTime() <= res.getEndDate().getTime()) {
//				return "false";
//			}
//		}
		
		return "false";
	}
}
