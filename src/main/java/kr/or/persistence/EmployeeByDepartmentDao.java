package kr.or.persistence;


import java.util.List;
import kr.or.domain.EmployeeByDepartment;
import kr.or.domain.SearchCriteria;

public interface EmployeeByDepartmentDao {
	
	public List<EmployeeByDepartment> searchEmployeeByDepartment(SearchCriteria searchCriteria);
	public List<EmployeeByDepartment> selectEmployeeByDepartmentById(int departmentId);
	
}
