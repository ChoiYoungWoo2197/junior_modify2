package kr.or.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.or.domain.Employee;
import kr.or.persistence.EmployeeDao;

@Service
public class EmployeeServiceImpl implements  EmployeeService{

	@Autowired
	EmployeeDao employeeDao;
	
	
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
	


}
