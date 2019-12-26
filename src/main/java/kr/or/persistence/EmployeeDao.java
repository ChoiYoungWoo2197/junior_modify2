package kr.or.persistence;


import java.util.List;
import kr.or.domain.Employee;

public interface EmployeeDao {
	public void insertData(Employee employee);
	public boolean checkAccount(String employeeId, String password);
	public Employee checkIdEmployee(String employeeId);
	public Employee checkEmailEmployee(String email);
	public List<Employee> selectAll();
}
