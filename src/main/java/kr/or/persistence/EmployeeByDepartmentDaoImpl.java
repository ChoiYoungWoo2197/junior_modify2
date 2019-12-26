package kr.or.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.domain.EmployeeByDepartment;
import kr.or.domain.SearchCriteria;

@Repository
public class EmployeeByDepartmentDaoImpl implements EmployeeByDepartmentDao {
	private static final String namespace = "kr.or.mappers.EmployeeByDepartmentMapper";
	
	@Autowired
	SqlSession sqlsession;

	@Override
	public List<EmployeeByDepartment> searchEmployeeByDepartment(SearchCriteria searchCriteria) {
		return sqlsession.selectList(namespace + ".searchEmployeeByDepartment", searchCriteria);
	}

	@Override
	public List<EmployeeByDepartment> selectEmployeeByDepartmentById(int departmentId) {
		return sqlsession.selectList(namespace + ".selectEmployeeByDepartmentById", departmentId);
	}

}
