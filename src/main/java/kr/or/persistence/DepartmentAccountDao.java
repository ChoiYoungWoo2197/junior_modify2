package kr.or.persistence;


import java.util.List;
import kr.or.domain.DepartmentAccount;

public interface DepartmentAccountDao {
	public List<DepartmentAccount> selectAll();
	
}
