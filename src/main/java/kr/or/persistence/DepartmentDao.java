package kr.or.persistence;


import java.util.List;
import kr.or.domain.Department;
import kr.or.domain.SearchCriteria;

public interface DepartmentDao {
	public void insertData(Department department);
	public void deleteData(String departmentId);
	public void updateDate(String departmentId, String name);
	public List<Department> selectAll();
	
	
	public List<Department> searchDepartment(SearchCriteria searchCriteria);
	public int searchDepartmentCount(SearchCriteria searchCriteria);
}
