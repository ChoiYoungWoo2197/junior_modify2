package kr.or.persistence;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.domain.Department;
import kr.or.domain.DepartmentAccount;

@Repository
public class DepartmentAccountDaoImpl implements DepartmentAccountDao {
	private static final String namespace = "kr.or.mappers.departmentAccountMapper";
	
	@Autowired
	SqlSession sqlsession;
	
	@Override
	public List<DepartmentAccount> selectAll() {
		return sqlsession.selectList(namespace + ".selectDepartmentAccount");
	}



	@Override
	public List<DepartmentAccount> selectSearch(String name) {
		// TODO Auto-generated method stub
		List<DepartmentAccount> departmentList = new ArrayList<DepartmentAccount>();
		
		departmentList = sqlsession.selectList(namespace + ".selectSearchDepartmentAccount",name);
		return departmentList;
	}


}
