package kr.or.service;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.domain.Employee;
import kr.or.domain.Manager;
import kr.or.persistence.EmployeeDao;
import kr.or.persistence.ManagerDao;

@Service
public class EmployeeServiceImpl implements  EmployeeService{

	@Autowired
	EmployeeDao employeeDao;

	@Autowired
	ManagerDao managerDao;
	
	
	@Override
	public void insertEmployee(Employee employee) {
		// TODO Auto-generated method stub
		employeeDao.insertData(employee);
	}


	@Override
	public Employee checkIdEmployee(String employeeId) {
		// TODO Auto-generated method stub
		return employeeDao.checkIdEmployee(employeeId);
	}


	@Override
	public Employee checkEmailEmployee(String email) {
		// TODO Auto-generated method stub
		return employeeDao.checkEmailEmployee(email);
	}


	@Override
	public Employee checkKey(String email, String authKey) {
		// TODO Auto-generated method stub
		return employeeDao.checkKey(email, authKey);
	}


	@Override
	public void modifyState(String memberId, String state) {
		// TODO Auto-generated method stub
		employeeDao.modifyState(memberId, state);
	}


	@Override
	public void modifyKey(String memberId, String authKey) {
		// TODO Auto-generated method stub
		employeeDao.modifyKey(memberId, authKey);
	}


	@Override
	public Employee checkUser(String memberId, String password) {
		// TODO Auto-generated method stub
		return employeeDao.checkUser(memberId, password);
	}
	
	@Override
	public Employee checkState(String memberId, String state) {
		// TODO Auto-generated method stub
		return employeeDao.checkState(memberId, state);
	}

	@Override
	public String encSHA256(String text) {
		// TODO Auto-generated method stub
		StringBuffer buf = new StringBuffer();
		MessageDigest mDigest;

		try {
			mDigest = MessageDigest.getInstance("SHA-256");
			mDigest.update(text.getBytes());

			byte[] msgStr = mDigest.digest();
			for (int i = 0; i < msgStr.length; i++) {
				byte tmpStrByte = msgStr[i];
				String tmpEncTxt = Integer.toString((tmpStrByte & 0xff) + 0x100,16).substring(1);
				buf.append(tmpEncTxt);
			}
		} catch (NoSuchAlgorithmException e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		return buf.toString();
	}


	@Override
	public Manager checkManager(int managerId) {
		// TODO Auto-generated method stub
		return managerDao.checkManager(managerId);
	}


	@Override
	public void modifyAuthKeyDate(String memberId) {
		// TODO Auto-generated method stub
		employeeDao.modifyAuthKeyDate(memberId);
	}
}
