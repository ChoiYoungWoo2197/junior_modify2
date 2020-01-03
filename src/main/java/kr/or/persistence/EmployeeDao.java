package kr.or.persistence;


import java.util.List;
import kr.or.domain.Employee;
import kr.or.domain.SearchCriteria;

public interface EmployeeDao {
	public void insertEmployee(Employee employee);
	public Employee checkEmployeeById(String memberId);
	public Employee checkEmployeeByEmail(String email);
	public Employee checkUser(String memberId, String password);
	public Employee checkStateByMap(String memberId, String state);
	public Employee checkKeyByMap(String email, String authKey);
	public void updateStateByMap(String memberId, String state);
	public void updateKeyByMap(String memberId, String authKey);
	public void updateKeyDateById(String memberId);
	public List<Employee> searchEmployee(SearchCriteria searchCriteria);
	public int searchEmployeeCount(SearchCriteria searchCriteria);
	public Employee checkEmployeeByEmployeeId(String employeeId);
	public void modify(Employee employee);
	public void delete(String memberId);
}
