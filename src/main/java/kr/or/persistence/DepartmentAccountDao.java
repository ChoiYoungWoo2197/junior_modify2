package kr.or.persistence;


import java.util.List;
import kr.or.domain.DepartmentEmployee;

public interface DepartmentAccountDao {
	public List<DepartmentEmployee> selectAll();
	public List<DepartmentEmployee> selectSearch(String name);
}
