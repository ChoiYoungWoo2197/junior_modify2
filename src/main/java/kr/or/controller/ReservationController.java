package kr.or.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.Session;

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
@RequestMapping("/reservation")
public class ReservationController {
	
	//private static final Logger logger = LoggerFactory.getLogger(ReservationController.class);
	
	@Autowired
	ReservationService reservationService;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(SearchCriteria searchCriteria, Model model) throws UnsupportedEncodingException {
		List<Reservation> reservationList = reservationService.searchReservation(searchCriteria);
		
		model.addAttribute("reservationList", reservationList);
		
		List<MeetingRoom> meetingRoomList = reservationService.selectMeetingRoom();
		model.addAttribute("meetingRoomList", meetingRoomList);
		
		model.addAttribute("searchCriteria", searchCriteria);
		model.addAttribute("page", new Page(reservationService.searchReservationCount(searchCriteria), searchCriteria));
		if(searchCriteria.getSearchContent()!=null){
	         model.addAttribute("searchContent", URLEncoder.encode(searchCriteria.getSearchContent(),"UTF-8"));
	      }
		
		
		if(searchCriteria.getSearchContent() != null) {
			model.addAttribute("searchContent", URLEncoder.encode(searchCriteria.getSearchContent(), "UTF-8"));
		}
		return "reservation/list";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String insertPage(Model model) {
		List<MeetingRoom> meetingRoomList = reservationService.selectMeetingRoom();
		model.addAttribute("meetingRoomList", meetingRoomList);
		
		return "reservation/insert";
	}
	
	@RequestMapping(value = "/infoMeet", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> infoMeet(int meetingRoomId) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		MeetingRoom meetingRoom = reservationService.selectMeetingRoomById(meetingRoomId);
		List<MeetingRoomEquipment> meetingRoomEquipmentList = reservationService.selectMeetingRoomEquipmentById(meetingRoomId);
		//int meetingRoomSeats = reservationService.selectMeetingRoomSeatsById(meetingRoomId);
		
		map.put("meetingRoom", meetingRoom);
		map.put("meetingRoomEquipmentList", meetingRoomEquipmentList);
		
		return map;
	}
	
	@RequestMapping(value = "/infoReserve", method = RequestMethod.GET)
	public @ResponseBody List<Reservation> infoReserve(int meetingRoomId, String choiceDay) throws ParseException {
		String startDate = choiceDay.substring(0, 4)+"-"+choiceDay.substring(4, 6)+"-"+choiceDay.substring(6, 8);
		List<Reservation> reservationList = reservationService.selectReservationByMeetAndDate(meetingRoomId, startDate);
		
		//yyyy-MM-dd kk:mm 저장했으니깐 같은형태로 만들어준다.?
		
		for(int i=0; i<reservationList.size()-1; i++) {
			Reservation reservation = reservationList.get(i);
			Reservation reservation2 = reservationList.get(i+1);
			if(reservation.getReservationId() == reservation2.getReservationId()) {
				reservationList.remove(i+1);
			}
		}
		return reservationList;
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insert(Model model, Reservation reservation, String start, String end) {
		Date startDate = null;
		Date endDate = null;
		try {
			startDate = new SimpleDateFormat("yyyy-MM-dd kk:mm").parse(start); //String -> Date : parse & Date -> String : format
			endDate = new SimpleDateFormat("yyyy-MM-dd kk:mm").parse(end);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		reservation.setStartDate(startDate);
		reservation.setEndDate(endDate);
		reservation.setReservationDate(new Date());
		reservation.setActualEndDate(endDate);
		
		reservationService.insertReservation(reservation);
		
		return "redirect:/reservation/list";
	}
	
	@RequestMapping(value = "/checkTime", method = RequestMethod.GET, produces = "application/json; charset=utf8")
	public @ResponseBody Map<String, String> checkTime(String choiceDay, String start, String end, String meetingRoomId, String reservationId, String employeeId) {
		String result = "true";
		Map<String, String> map = new HashMap<String, String>();

		String choiceDate = choiceDay.substring(0, 4)+"-"+choiceDay.substring(4, 6)+"-"+choiceDay.substring(6, 8);
		List<Reservation> reservationList = reservationService.selectReservationByMeetAndDate(Integer.parseInt(meetingRoomId), choiceDate);
		
		Date startDate = null;
		Date endDate = null;
		try {
			startDate = new SimpleDateFormat("yyyy-MM-dd kk:mm").parse(start); //String -> Date : parse & Date -> String : format
			endDate = new SimpleDateFormat("yyyy-MM-dd kk:mm").parse(end);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		map.put("meetingRoom", "none");
		if(reservationId == null) { //등록
			Reservation reservation = reservationService.selectReservationByMemeberAndTime(Integer.parseInt(employeeId), startDate, endDate);
			if(reservation != null) {
				map.put("meetingRoom", reservation.getMeetingRoomName());
				result = "false";
			}
		}
		
		if(result.equals("true")) {
			for(Reservation reservation : reservationList) {
				boolean b;
				
				if(reservationId != null) {
					if(Integer.parseInt(reservationId) != reservation.getReservationId()) {
						b = reservationService.availableReservation(reservation, startDate, endDate);
						result = String.valueOf(b);
					}
				} else {
					b = reservationService.availableReservation(reservation, startDate, endDate);
					result = String.valueOf(b);
				}
			}
		}
		map.put("result", result);
		
		return map;
	}

	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public String updatePage(int reservationId, Model model) {
		List<MeetingRoom> meetingRoomList = reservationService.selectMeetingRoom();
		model.addAttribute("meetingRoomList", meetingRoomList);
		
		Reservation reservation = reservationService.selectReservationById(reservationId);
		model.addAttribute("reservation", reservation);
		
		List<MeetingRoomEquipment> meetingRoomEquipmentList = reservationService.selectMeetingRoomEquipmentById(reservation.getMeetingRoomId());
		model.addAttribute("meetingRoomEquipmentList", meetingRoomEquipmentList);
		
		for(MeetingRoom meetingRoom : meetingRoomList) {
			if(meetingRoom.getMeetingRoomId() == reservation.getMeetingRoomId()) {
				model.addAttribute("seats", meetingRoom.getSeats());
			}
		}
		
		Date startDate = reservation.getStartDate();
		String start = new SimpleDateFormat("yyyy-MM-dd").format(startDate);
		List<Reservation> reservationList = reservationService.selectReservationByMeetAndDate(reservation.getMeetingRoomId(), start);
		model.addAttribute("reservationList", reservationList);
		
		return "reservation/modify";
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(Reservation reservation, String start, String end) {
		Date startDate = null;
		Date endDate = null;
		try {
			startDate = new SimpleDateFormat("yyyy-MM-dd kk:mm").parse(start); //String -> Date : parse & Date -> String : format
			endDate = new SimpleDateFormat("yyyy-MM-dd kk:mm").parse(end);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		reservation.setStartDate(startDate);
		reservation.setEndDate(endDate);
		reservation.setActualEndDate(endDate);
		reservation.setModifyDate(new Date());
		
		reservationService.updateReservation(reservation);
		
		return "redirect:/reservationDetail/read?reservationId="+reservation.getReservationId();
	}
}
