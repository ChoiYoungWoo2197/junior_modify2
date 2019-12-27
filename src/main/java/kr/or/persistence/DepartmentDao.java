package kr.or.persistence;


import kr.or.domain.Department;
import kr.or.domain.SearchCriteria;

public interface DepartmentDao {

	public int searchDepartmentCount(SearchCriteria searchCriteria);
	public void insertDepartment(Department department);
	public Department selectDepartmentById(int departmentId);
	public void updateDepartment(Department department);
	public void deleteDepartment(int departmentId);
	
}
