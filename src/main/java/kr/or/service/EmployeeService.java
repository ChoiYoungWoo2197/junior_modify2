package kr.or.service;

import java.util.List;

import kr.or.domain.Employee;
import kr.or.domain.Manager;
import kr.or.domain.SearchCriteria;

public interface EmployeeService {
	public void insertEmployee(Employee employee);
	public Employee checkUser(String memberId, String password);
	public Employee checkIdEmployee(String employeeId);
	public Employee checkEmailEmployee(String email);
	public Employee checkKey(String email, String authKey);
	public void modifyState(String memberId, String state);
	public void modifyKey(String memberId, String authKey);
	public void modifyAuthKeyDate(String memberId);
	public Employee checkState(String memberId, String state);
	public String encSHA256(String text);
	public Manager checkManager(int managerId);
	public List<Employee> searchEmployee(SearchCriteria criteria);
	public int searchEmployeeCount(SearchCriteria criteria);
}
