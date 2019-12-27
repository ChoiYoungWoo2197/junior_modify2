package kr.or.persistence;


import java.util.List;

import kr.or.domain.Department;
import kr.or.domain.SearchCriteria;

public interface DepartmentDao {
	
	public List<Department> searchDepartment(SearchCriteria searchCriteria);
	public int searchDepartmentCount(SearchCriteria searchCriteria);
	public void insertDepartment(Department department);
	public Department selectDepartmentById(int departmentId);
	public void updateDepartment(Department department);
	public int selectEmployeeCountById(int departmentId);
	public void deleteDepartment(int departmentId);
	
}
