package kr.or.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.domain.Department;
import kr.or.domain.Employee;
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
		
		reservation.setEmployeeName(employee.getName());
		reservation.setDepartmentName(department.getName());
		reservation.setMeetingRoomName(meetingRoom.getName());
		
		
		Date date1 = setTime("2020.01.03 16:30");
		Date date2 = setTime("2020.01.03 19:30");
		//reservationDetailService.checkTime(reservation.getStartDate(), reservation.getEndDate(), new Date(), reservation.getState());
		reservationDetailService.checkTime(date1, date2, new Date(), reservation.getState());
		model.addAttribute("reservation", reservation);

		return "reservationDetail/read";
	}
	
	@RequestMapping(value = "/cancel", method = RequestMethod.POST)
	public String cancel(HttpServletRequest request) {
		logger.info("예약취소 사유 : " + request.getParameter("reason") + " 예약번호 : " + request.getParameter("reservationId"));
		int reservationId = Integer.parseInt(request.getParameter("reservationId"));
		Reservation reservation =  reservationDetailService.searchReservationById(reservationId);
		Employee employee = employeeService.checkEmployeeByEmployeeId(Integer.toString(reservation.getEmployeeId()));
		
		String person = employee.getName();
		String reason = request.getParameter("reason");

		reservationDetailService.updateCancelReasonByMap(reservationId, person, reason);
		reservationDetailService.updateStateByMap(reservationId, "RC");
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
