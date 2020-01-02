package kr.or.controller;

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
import kr.or.service.ReservationService;

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
		model.addAttribute("reservation", reservation);

		return "reservationDetail/read";
	}

}
