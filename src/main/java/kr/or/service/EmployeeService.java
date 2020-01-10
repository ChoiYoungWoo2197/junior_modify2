package kr.or.service;

import java.util.Date;
import java.util.List;

import kr.or.domain.Employee;
import kr.or.domain.Manager;
import kr.or.domain.SearchCriteria;

public interface EmployeeService {
	public void insertEmployee(Employee employee);
	public String encSHA256(String text);
	public Employee checkEmployeeById(String memberId);
	public Employee checkEmployeeByEmail(String email);
	public Employee checkUser(String memberId, String password);
	public Employee checkStateByMap(String memberId, String state);
	public Manager checkManager(int managerId);
	public Employee checkKeyByMap(String email, String authKey);
	public void updateStateByMap(String memberId, String state);
	public void updateKeyByMap(String memberId, String authKey);
	public void updateKeyDateByMap(String memberId, Date currentTime);
	public List<Employee> searchEmployee(SearchCriteria criteria);
	public int searchEmployeeCount(SearchCriteria criteria);
	public void modifyEmployee(Employee employee);
	public void deleteEmployee(String memberId);
	public void insertManager(int employeeId);
	public void deleteManager(int employeeId);
	public Employee checkEmployeeByEmployeeId(String employeeId);
}
