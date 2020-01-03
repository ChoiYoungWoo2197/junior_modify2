package kr.or.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import kr.or.domain.Reservation;

public class ReservationValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return Reservation.class.isAssignableFrom(clazz);
		//ReservationValidator 클래스는 Reservation타입의 객체를 지원한다.
	}

	@Override
	public void validate(Object target, Errors errors) { 
						//target은 검증할 객체, errors는 검증 객체가 올바르지 않을 경우 에러정보를 저장
		Reservation reservation = (Reservation) target;
		
		String meetPurpose = reservation.getMeetPurpose();
		if(meetPurpose == null || meetPurpose.trim().isEmpty()) {
			System.out.println("목적");
			errors.rejectValue("meetPurpose", "회의목적을 입력하세요."); //rejectValue => 필드에 대한 에러코드 추가
		}
		
		int meetAttendess = reservation.getMeetAttendess();
		if(meetAttendess == Integer.parseInt("0")) {
			System.out.println("인원수");
			errors.rejectValue("meetAttendess", "회의참석자수를 선택하세요."); //rejectValue => 필드에 대한 에러코드 추가
		}
		
		int meetingRoomId = reservation.getMeetingRoomId();
		if(meetingRoomId == 0) {
			System.out.println("회의실");
			errors.rejectValue("meetingRoomId", "회의실을 선택하세요."); //rejectValue => 필드에 대한 에러코드 추가
		}
	}

}
