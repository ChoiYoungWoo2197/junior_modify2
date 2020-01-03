package kr.or.service;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.domain.Employee;
import kr.or.domain.Manager;
import kr.or.domain.SearchCriteria;
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
		employeeDao.insertEmployee(employee);
	}

	@Override
	public Employee checkEmployeeById(String memberId) {
		// TODO Auto-generated method stub
		return employeeDao.checkEmployeeById(memberId);
	}


	@Override
	public Employee checkEmployeeByEmail(String email) {
		// TODO Auto-generated method stub
		return employeeDao.checkEmployeeByEmail(email);
	}


	@Override
	public Employee checkKeyByMap(String email, String authKey) {
		// TODO Auto-generated method stub
		return employeeDao.checkKeyByMap(email, authKey);
	}


	@Override
	public void updateStateByMap(String memberId, String state) {
		// TODO Auto-generated method stub
		employeeDao.updateStateByMap(memberId, state);
	}


	@Override
	public void updateKeyByMap(String memberId, String authKey) {
		// TODO Auto-generated method stub
		employeeDao.updateKeyByMap(memberId, authKey);
	}


	@Override
	public Employee checkUser(String memberId, String password) {
		// TODO Auto-generated method stub
		return employeeDao.checkUser(memberId, password);
	}
	
	@Override
	public Employee checkStateByMap(String memberId, String state) {
		// TODO Auto-generated method stub
		return employeeDao.checkStateByMap(memberId, state);
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
	public void updateKeyDateById(String memberId) {
		// TODO Auto-generated method stub
		employeeDao.updateKeyDateById(memberId);
	}


	@Override
	public List<Employee> searchEmployee(SearchCriteria criteria) {
		// TODO Auto-generated method stub
		return employeeDao.searchEmployee(criteria);
	}


	@Override
	public int searchEmployeeCount(SearchCriteria criteria) {
		// TODO Auto-generated method stub
		return employeeDao.searchEmployeeCount(criteria);
	}

	@Override
	public void modify(Employee employee) {
		employeeDao.modify(employee);
	}

	@Override
	public void insertManager(int employeeId) {
		// TODO Auto-generated method stub
		managerDao.insert(employeeId);
	}

	@Override
	public void deleteManager(int employeeId) {
		// TODO Auto-generated method stub
		managerDao.delete(employeeId);
	}

	@Override
	public void delete(String memberId) {
		// TODO Auto-generated method stub
		employeeDao.delete(memberId);
	}

	@Override
	public Employee checkEmployeeByEmployeeId(String employeeId) {
		// TODO Auto-generated method stub
		return employeeDao.checkEmployeeByEmployeeId(employeeId);
	}
}
