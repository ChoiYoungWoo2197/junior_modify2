package kr.or.persistence;


import java.util.List;
import kr.or.domain.Employee;

public interface EmployeeDao {
	public void insertData(Employee employee);
	public Employee checkUser(String memberId, String password);
	public Employee checkIdEmployee(String employeeId);
	public Employee checkEmailEmployee(String email);
	public Employee checkKey(String email, String authKey);
	public void modifyState(String memberId, String state);
	public void modifyKey(String memberId, String authKey);
	public void modifyAuthKeyDate(String memberId);
	public Employee checkState(String memberId, String state);
	public List<Employee> selectAll();
}
