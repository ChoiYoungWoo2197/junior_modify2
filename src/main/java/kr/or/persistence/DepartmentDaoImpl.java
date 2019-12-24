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
import kr.or.domain.SearchCriteria;

@Repository
public class DepartmentDaoImpl implements DepartmentDao {
	private static final String namespace = "kr.or.mappers.departmentMapper";
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void insertData(Department department) {
		// TODO Auto-generated method stub
		sqlSession.insert(namespace + ".insertDepartment", department);
	}

	@Override
	public void deleteData(String departmentId) {
		// TODO Auto-generated method stub
		sqlSession.delete(namespace + ".deleteDepartment", departmentId);
	}

	@Override
	public void updateDate(String departmentId, String name) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		map.put("departmentId", departmentId);
		map.put("name", name);
		
		sqlSession.update(namespace + ".updateDepartment", map);
		
	}

	@Override
	public List<Department> selectAll() {
		// TODO Auto-generated method stub
		List<Department> departmentList = new ArrayList<Department>();
		/*
		try(SqlSession session = sqlSessionFactory.openSession()) {
			departmentList = session.selectList(namespace + ".selectDepartment");
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.toString());
		}
		*/
		return departmentList;
	}

	@Override
	public List<Department> searchDepartment(SearchCriteria searchCriteria) {
		return sqlSession.selectList(namespace + ".searchDepartment", searchCriteria);
	}

	@Override
	public int searchDepartmentCount(SearchCriteria searchCriteria) {
		return sqlSession.selectOne(namespace + ".searchDepartmentCount", searchCriteria);
	}


}
