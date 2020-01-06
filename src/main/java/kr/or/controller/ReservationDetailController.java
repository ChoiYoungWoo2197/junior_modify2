package kr.or.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
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

import kr.or.domain.Department;
import kr.or.domain.Employee;
import kr.or.domain.Extend;
import kr.or.domain.MeetingRoom;
import kr.or.domain.Reservation;
import kr.or.service.EmployeeService;
import kr.or.service.ManagementService;
import kr.or.service.MeetingRoomService;
import kr.or.service.ReservationDetailService;

@Controller
@RequestMapping("/reservationDetail/*")
public class ReservationDetailController {

	private static final Logger logger = LoggerFactory.getLogger(ReservationDetailController.class);

	@Autowired
	EmployeeService employeeService;

	@Autowired
	ReservationDetailService reservationDetailService;

	@Autowired
	ManagementService managementServcice;

	@Autowired
	MeetingRoomService meetingRoomService;

	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String read(Model model,HttpServletRequest request) {
		//logger.info("reservation ID : " + request.getParameter("reservationId"));

		Reservation reservation =  reservationDetailService.searchReservationById(Integer.parseInt(request.getParameter("reservationId")));
		Employee employee = employeeService.checkEmployeeByEmployeeId(Integer.toString(reservation.getEmployeeId()));
		Department department = managementServcice.selectDepartmentById(Integer.parseInt(employee.getDepartmentId()));
		MeetingRoom meetingRoom = meetingRoomService.selectMeetingRoomById(reservation.getMeetingRoomId());
		Extend extend =  reservationDetailService.searchExtendReasonById(reservation.getReservationId());
		boolean extendIspossible = (reservationDetailService.searchNextReservationById(reservation.getReservationId()) > 0)? false : true ;
		
		reservation.setEmployeeName(employee.getName());
		reservation.setDepartmentName(department.getName());
		reservation.setMeetingRoomName(meetingRoom.getName());
		/*
		Date date1 = setTime("2020.01.06 8:30");
		Date date2 = setTime("2020.01.06 20:30"); 
		
		reservation.setStartDate(date1);
		reservation.setEndDate(date2);
		*/
		
		model.addAttribute("reservation", reservation);
		model.addAttribute("extend", extend);
		model.addAttribute("extendIspossible", extendIspossible);
		return "reservationDetail/read";
	}

	@RequestMapping(value = "/cancel", method = RequestMethod.POST)
	public String cancel(HttpServletRequest request, HttpSession session) {
		logger.info("예약취소 사유 : " + request.getParameter("cancelReason") + " 예약번호 : " + request.getParameter("reservationId"));
		Map<String, Object> map =  (Map<String, Object>) session.getAttribute("loginUser");
		int reservationId = Integer.parseInt(request.getParameter("reservationId"));
		Reservation reservation =  reservationDetailService.searchReservationById(reservationId);
		Employee employee = (Employee) map.get("user");

		String cancelApplicant = employee.getName();
		String cancelReason = request.getParameter("cancelReason");

		reservationDetailService.updateCancelReasonByMap(reservationId, cancelApplicant, cancelReason);
		reservationDetailService.updateStateByMap(reservationId, "RC");
		return "redirect:/";
	}

	@RequestMapping(value = "/exit", method = RequestMethod.POST)
	public String exit(HttpServletRequest request, HttpSession session) {
		logger.info("조기종료 : " +request.getParameter("exitTimeHours") + " " + request.getParameter("exitTimeMinutes"));
		//Enumeration enums = request.getParameterNames();
		Map<String, Object> map =  (Map<String, Object>) session.getAttribute("loginUser");
		int reservationId = Integer.parseInt(request.getParameter("reservationId"));
		Reservation reservation =  reservationDetailService.searchReservationById(reservationId);
		
		Date actualEndDate = reservation.getStartDate();
		actualEndDate.setHours(Integer.parseInt(request.getParameter("exitTimeHours")));
		actualEndDate.setMinutes(Integer.parseInt(request.getParameter("exitTimeMinutes")));
		
		Employee employee = (Employee) map.get("user");
		String validateApplicant = employee.getName();
		
		reservationDetailService.updateExitByMap(reservationId, validateApplicant, actualEndDate);
		reservationDetailService.updateStateByMap(reservationId, "F");
		
		return "redirect:/";
	}


	@RequestMapping(value = "/extand", method = RequestMethod.POST)
	public String extand(HttpServletRequest request) {
		logger.info("연장신청");
		Enumeration enums = request.getParameterNames();
		int reservationId = Integer.parseInt(request.getParameter("reservationId"));
		Reservation reservation =  reservationDetailService.searchReservationById(reservationId);
		Extend extend = new Extend();
		
		Date endDate = reservation.getStartDate();
		endDate.setHours(Integer.parseInt(request.getParameter("extandTimeHours")));
		endDate.setMinutes(Integer.parseInt(request.getParameter("extandTimeMinutes")));
		extend.setReservationId(reservationId);
		extend.setEndDate(endDate);
		extend.setExtendReason(request.getParameter("extandReason"));
		
		reservationDetailService.insertExtendByMap(extend);
		reservationDetailService.updateStateByMap(reservationId, "E");
		return "redirect:/";
	}

	public Date setTime(String time) {
		Date temp = new Date();
		try {
			DateFormat sdFormat = new SimpleDateFormat("yyyy.MM.dd kk:mm");
			temp = sdFormat.parse(time);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return temp;
	}
	

}
