package kr.or.persistence;


import java.util.List;

import kr.or.domain.Department;
import kr.or.domain.Employee;

public interface EmployeeDao {
	public void insertData(String employeeId, String departmentId, String name, String password, String email, String phone);
	public void deleteData(String employeeId);
	public void updateDate(String employeeId, String departmentId, String name, String password, String email, String phone);
	public List<Employee> selectAll();
}
