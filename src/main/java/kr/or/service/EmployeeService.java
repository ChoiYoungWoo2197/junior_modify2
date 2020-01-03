package kr.or.service;

import java.util.List;

import kr.or.domain.Employee;
import kr.or.domain.Manager;
import kr.or.domain.SearchCriteria;

public interface EmployeeService {
	public void insertEmployee(Employee employee);
	public Employee checkUser(String memberId, String password);
	public Employee checkEmployeeById(String memberId);
	public Employee checkEmployeeByEmail(String email);
	public Employee checkKeyByMap(String email, String authKey);
	public void updateStateByMap(String memberId, String state);
	public void updateKeyByMap(String memberId, String authKey);
	public void updateKeyDateById(String memberId);
	public Employee checkStateByMap(String memberId, String state);
	public String encSHA256(String text);
	public Manager checkManager(int managerId);
	public List<Employee> searchEmployee(SearchCriteria criteria);
	public int searchEmployeeCount(SearchCriteria criteria);
	public void modify(Employee employee);
	public void delete(String memberId);
	public void insertManager(int employeeId);
	public void deleteManager(int employeeId);
	public Employee checkEmployeeByEmployeeId(String employeeId);
}
