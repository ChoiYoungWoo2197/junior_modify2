package kr.or.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.domain.Department;
import kr.or.domain.Employee;
import kr.or.domain.Extend;
import kr.or.domain.MeetingRoom;
import kr.or.domain.Reservation;
import kr.or.service.EmployeeService;
import kr.or.service.ManagementService;
import kr.or.service.MeetingRoomService;
import kr.or.service.ReservationDetailService;
import kr.or.service.ReservationService;
 
@Controller
@RequestMapping("/reservationDetail")
public class ReservationDetailController {
	//private static final Logger logger = LoggerFactory.getLogger(ReservationDetailController.class);
	@Autowired
	EmployeeService employeeService;

	@Autowired
	ReservationDetailService reservationDetailService;

	@Autowired
	ManagementService managementServcice;

	@Autowired
	MeetingRoomService meetingRoomService;
	
	@Autowired
	ReservationService reservationService;

	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String read(Model model,HttpServletRequest request, HttpSession session) {
		String oldUrl = request.getHeader("referer");
		Map<String, Object> map =  (Map<String, Object>) session.getAttribute("loginUser");
		Employee who = (Employee) map.get("user");// 세션값을 이용해서 자신이 누구인지 알아낸다.
		
		Reservation reservation =  reservationDetailService.searchReservationById(Integer.parseInt(request.getParameter("reservationId")));
		Employee register = employeeService.checkEmployeeByEmployeeId(Integer.toString(reservation.getEmployeeId()));
		Department department = managementServcice.selectDepartmentById(Integer.parseInt(register.getDepartmentId()));
		MeetingRoom meetingRoom = meetingRoomService.selectMeetingRoomById(reservation.getMeetingRoomId());
		Extend extend =  reservationDetailService.searchExtendReasonById(reservation.getReservationId());
		reservation.setEmployeeName(register.getName());
		reservation.setDepartmentName(department.getName());
		reservation.setMeetingRoomName(meetingRoom.getName());
		
		long date2 = reservation.getActualEndDate().getTime()+60000;
		Date actualEndDate2  = new Date(date2);
		
		List<Reservation> extendIspossible = reservationDetailService.searchNextReservationById(reservation.getMeetingRoomId(), reservation.getActualEndDate(), actualEndDate2);
		List<Reservation> limitReservationList = reservationDetailService.limitExtendById(reservation.getMeetingRoomId());
		
		Date limitReservation = null;
		/*
		 * if((extendIspossible.size() == 0) && limitReservationList.size() >1) {
		 * for(int i=0; i<limitReservationList.size(); i++) {
		 * if(limitReservationList.get(i).getReservationId() ==
		 * reservation.getReservationId()) { limitReservation =
		 * limitReservationList.get(i+1).getStartDate(); break; } } }
		 */

		
		//본인이 등록한 예약건을 선택한 경우
		boolean isSelfReservation = false;
		if(who.getName().equals(register.getName()) == true) {
			isSelfReservation = true;
		}
		
		model.addAttribute("isSelfReservation", isSelfReservation);
		model.addAttribute("reservation", reservation);
		model.addAttribute("extend", extend);
		model.addAttribute("extendIspossible", (extendIspossible.size() == 0)? true : false);
		model.addAttribute("limitReservation", limitReservation);
		model.addAttribute("oldUrl", oldUrl);
		return "reservationDetail/read";
	}

	@RequestMapping(value = "/cancel", method = RequestMethod.POST)
	public String cancel(HttpServletRequest request, HttpSession session) {
		Map<String, Object> map =  (Map<String, Object>) session.getAttribute("loginUser");
		int reservationId = Integer.parseInt(request.getParameter("reservationId"));
		Reservation reservation =  reservationDetailService.searchReservationById(reservationId);
		Employee employee = (Employee) map.get("user");

		String cancelApplicant = employee.getName();
		String cancelReason = request.getParameter("cancelReason");
		Date cancelDate = new Date();

		reservationDetailService.updateCancelReasonByMap(reservationId, cancelApplicant, cancelReason, cancelDate);
		reservationDetailService.updateStateByMap(reservationId, "RC");
		return "redirect:/reservation/list";
	}

	@RequestMapping(value = "/exit", method = RequestMethod.POST)
	public String exit(HttpServletRequest request, HttpSession session) {
		//Enumeration enums = request.getParameterNames();
		Map<String, Object> map =  (Map<String, Object>) session.getAttribute("loginUser");
		int reservationId = Integer.parseInt(request.getParameter("reservationId"));
		Reservation reservation =  reservationDetailService.searchReservationById(reservationId);
		
		Date actualEndDate = reservation.getEndDate();
		actualEndDate.setHours(Integer.parseInt(request.getParameter("exitTimeHours")));
		actualEndDate.setMinutes(Integer.parseInt(request.getParameter("exitTimeMinutes")));
		
		Employee employee = (Employee) map.get("user");
		String validateApplicant = employee.getName();
		
		reservationDetailService.updateExitByMap(reservationId, validateApplicant, actualEndDate);
//		reservationDetailService.updateStateByMap(reservationId, "F");
		
		return "redirect:/reservation/list";
	}

	@RequestMapping(value = "/checkTime", method = RequestMethod.GET, produces = "application/text; charset=utf8")
	public @ResponseBody String checkTime(HttpServletRequest request, String end, String meetingRoomId, String reservationId) {
		String result = "true";
		//Enumeration enums = request.getParameterNames();
		try {
			int id = Integer.parseInt(reservationId);
			int roomId = Integer.parseInt(meetingRoomId);
			Reservation reservation =  reservationDetailService.searchReservationById(id);
			SimpleDateFormat smdf = new SimpleDateFormat("yyyy-MM-dd");
			String strDate = smdf.format(reservation.getActualEndDate());
			List<Reservation> reservationList = reservationService.selectReservationByMeetAndDate(roomId, strDate);
			Reservation findNextReservation = new Reservation();
			boolean availableExtend = true;
			
			//reservationList -> 현재 회의실에 대해 예약이나, 연장된 내용을 가져오는 리스트.(같은 날짜대)
			for(int i=reservationList.size()-1; i>=0; i--) {
				if(reservationList.get(i).getReservationId() == id) {
					if(i != reservationList.size()-1) {
						findNextReservation = reservationList.get(i+1);
						Date extendDate = null;
						extendDate = new SimpleDateFormat("yyyy-MM-dd kk:mm").parse(end); //String -> Date : parse & Date -> String : format
						
						availableExtend = reservationService.availableReservation(extendDate, reservationList.get(i+1).getStartDate());
						
						break;
					}
					else {
						availableExtend = true;
						break;
					}
				}
			}
			
			
			
			result = String.valueOf(availableExtend);
		} catch (Exception e) {
			// TODO: handle exception
		}

		return result;
	}
	

	@RequestMapping(value = "/extend", method = RequestMethod.POST)
	public String extend(HttpServletRequest request) {
		Enumeration enums = request.getParameterNames();
		int reservationId = Integer.parseInt(request.getParameter("reservationId"));
		Reservation reservation =  reservationDetailService.searchReservationById(reservationId);
		Extend extend = new Extend();
		
	
		Date actualEndDate = reservation.getEndDate();
		actualEndDate.setHours(Integer.parseInt(request.getParameter("extendTimeHours")));
		actualEndDate.setMinutes(Integer.parseInt(request.getParameter("extendTimeMinutes")));
		extend.setReservationId(reservationId);
		extend.setEndDate(actualEndDate);
		extend.setExtendReason(request.getParameter("extendReason"));
		
		reservationDetailService.insertExtendByMap(extend);
		reservationDetailService.updateExitByMap(reservationId, "", actualEndDate);
		reservationDetailService.updateStateByMap(reservationId, "E");
		return "redirect:/reservation/list";
	}
	

	@RequestMapping(value = "/exitCheck", method = RequestMethod.POST)
	public String exitCheck(HttpServletRequest request, HttpSession session) {
		Map<String, Object> map =  (Map<String, Object>) session.getAttribute("loginUser");
		int reservationId = Integer.parseInt(request.getParameter("reservationId"));
		Reservation reservation =  reservationDetailService.searchReservationById(reservationId);
		
		Employee employee = (Employee) map.get("user");
		String validateChecker = employee.getName();
		Date validateTime = new Date();
		String abnormality = request.getParameter("abnormality");
		
		reservationDetailService.updateExitCheckByMap(reservationId, validateChecker, validateTime, abnormality);
		reservationDetailService.updateStateByMap(reservationId, "FV");
		
		return "redirect:/reservation/list";
		
	}
}
