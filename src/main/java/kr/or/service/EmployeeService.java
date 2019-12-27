package kr.or.service;

import kr.or.domain.Employee;

public interface EmployeeService {
	public void insertEmployee(Employee employee);
	public Employee checkIdEmployee(String employeeId);
	public Employee checkEmailEmployee(String email);
}