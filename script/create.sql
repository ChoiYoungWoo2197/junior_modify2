-- 부서
CREATE TABLE department (
	department_id INTEGER AUTO_INCREMENT, 	-- 부서번호
	name VARCHAR(30) NOT NULL, 							-- 부서명
	register_date DATETIME DEFAULT(NOW()),	-- 등록일시
	PRIMARY KEY (department_id)
);

-- 회원
CREATE TABLE employee (
	employee_id INTEGER,						-- 사원번호
	department_id INTEGER NOT NULL,	-- 부서번호
	name VARCHAR(20) NOT NULL,			-- 사원명
	password CHAR(41) NOT NULL,	-- 비밀번호
	email VARCHAR(30) NOT NULL,			-- 이메일
	phone VARCHAR(13),							-- 전화번호
	PRIMARY KEY (employee_id),
	FOREIGN KEY (department_id) REFERENCES department (department_id)
);

-- 관리자 권한
CREATE TABLE manager (
	manager_id INTEGER,											-- 사원번호(관리자번호)
	register_date DATETIME DEFAULT(NOW()),	-- 등록일시
	PRIMARY KEY (manager_id),
	FOREIGN KEY (manager_id) REFERENCES employee (employee_id)
);

-- 회의실
CREATE TABLE meeting_room (
	meeting_room_id INTEGER AUTO_INCREMENT,	-- 회의실번호
	manager_id INTEGER NOT NULL,						-- 사원번호(관리자번호)
	name VARCHAR(30) NOT NULL,							-- 회의실명
	seats INTEGER NOT NULL,									-- 좌석수
	availability TINYINT NOT NULL,					-- 예약가능여부
	register_date DATETIME DEFAULT(NOW()),	-- 등록일시
	PRIMARY KEY (meeting_room_id),
	FOREIGN KEY (manager_id) REFERENCES manager (manager_id)
);

-- 장비
CREATE TABLE equipment (
	equipment_id INTEGER AUTO_INCREMENT,		-- 장비번호
	name VARCHAR(30) NOT NULL,							-- 장비명
	register_date DATETIME DEFAULT(NOW()),	-- 등록일시
	PRIMARY KEY (equipment_id)
);

-- 회의실_장비
CREATE TABLE meeting_room_equipment (
	equipment_id INTEGER,			-- 장비번호
	meeting_room_id INTEGER,	-- 회의실번호
	PRIMARY KEY (equipment_id, meeting_room_id),
	FOREIGN KEY (equipment_id) REFERENCES equipment (equipment_id),
	FOREIGN KEY (meeting_room_id) REFERENCES meeting_room (meeting_room_id)
);

-- 예약
CREATE TABLE reservation (
	reservation_id INTEGER AUTO_INCREMENT,		-- 예약번호
	employee_id INTEGER NOT NULL,							-- 사원번호
	meeting_room_id INTEGER NOT NULL,					-- 회의실번호
	meet_purpose VARCHAR(100) NOT NULL,				-- 회의목적
	meet_attendess INTEGER NOT NULL,					-- 회의참석자
	start_date DATETIME NOT NULL,							-- 시작일시
	end_date DATETIME NOT NULL,								-- 종료일시
	reservation_date DATETIME DEFAULT(NOW()),	-- 신청일시
	state VARCHAR(15) NOT NULL,								-- 예약상태
	modify_date DATETIME DEFAULT(NOW()),			-- 수정일시
	actual_end_date DATETIME NOT NULL,				-- 실제종료시간
	validate_time DATETIME DEFAULT(NOW()),		-- 종료확인시간
	validate_applicant VARCHAR(20),						-- 종료신청자
	validate_checker VARCHAR(20),							-- 종료확인자
	abnormality TEXT,													-- 이상유무
	cancel_applicant VARCHAR(20),							-- 취소신청자
	cancel_date DATETIME DEFAULT(NOW()),			-- 취소신청일시
	cancel_reason TEXT,												-- 취소사유
	PRIMARY KEY (reservation_id),
	FOREIGN KEY (employee_id) REFERENCES employee (employee_id),
	FOREIGN KEY (meeting_room_id) REFERENCES meeting_room (meeting_room_id)
);

-- 연장
CREATE TABLE extend (
	extend_id INTEGER AUTO_INCREMENT,					-- 연장번호
	reservation_id INTEGER NOT NULL,					-- 예약번호
	application_date DATETIME DEFAULT(NOW()),	-- 신청일시
	end_date DATETIME NOT NULL,								-- 종료일시
	extend_reason TEXT,												-- 연장사유
	PRIMARY KEY (extend_id),
	FOREIGN KEY (reservation_id) REFERENCES reservation (reservation_id)
);
