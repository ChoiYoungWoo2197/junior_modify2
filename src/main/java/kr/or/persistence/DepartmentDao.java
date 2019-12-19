package kr.or.persistence;


import java.util.List;
import kr.or.domain.Department;

public interface DepartmentDao {
	public void insertData(String name);
	public void deleteData(String departmentId);
	public void updateDate(String departmentId, String name);
	public List<Department> selectAll();
}
