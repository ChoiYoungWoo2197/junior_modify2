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
import kr.or.domain.DepartmentEmployee;
import kr.or.domain.SearchCriteria;

@Repository
public class DepartmentDaoImpl implements DepartmentDao {
	private static final String namespace = "kr.or.mappers.departmentMapper";
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<Department> searchDepartment(SearchCriteria searchCriteria) {
		return sqlSession.selectList(namespace + ".searchDepartment", searchCriteria);
	}

	@Override
	public int searchDepartmentCount(SearchCriteria searchCriteria) {
		return sqlSession.selectOne(namespace + ".searchDepartmentCount", searchCriteria);
	}

	@Override
	public void insertDepartment(Department department) {
		sqlSession.insert(namespace + ".insertDepartment", department);
	}

	@Override
	public Department selectDepartmentById(int departmentId) {
		return sqlSession.selectOne(namespace + ".selectDepartmentById", departmentId);
	}

	@Override
	public void updateDepartment(Department department) {
		sqlSession.update(namespace + ".updateDepartment", department);
	}

	@Override
	public void deleteDepartment(int departmentId) {
		sqlSession.delete(namespace + ".deleteDepartment", departmentId);
	}


}
