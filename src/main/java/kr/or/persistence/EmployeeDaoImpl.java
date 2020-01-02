package kr.or.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import kr.or.domain.Employee;
import kr.or.domain.SearchCriteria;

@Repository
public class EmployeeDaoImpl implements EmployeeDao{
	private static final String namespace = "kr.or.mappers.employeeMapper";
	@Autowired
	SqlSession sqlsession;

	@Override
	public void insertEmployee(Employee employee) {
		sqlsession.insert(namespace + ".insertEmployee",employee);
	}

	@Override
	public Employee checkUser(String memberId, String password) {
		Map<String, Object> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("password", password);
		return sqlsession.selectOne(namespace + ".checkUser", map);
	}

	@Override
	public Employee checkEmployeeById(String memberId) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne(namespace + ".checkEmployeeById", memberId);
	}

	@Override
	public Employee checkEmployeeByEmail(String email) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne(namespace + ".checkEmployeeByEmail", email);
	}

	@Override
	public Employee checkKeyByMap(String email, String authKey) {
		Map<String, Object> map = new HashMap<>();
		map.put("email", email);
		map.put("authkey", authKey);
		return sqlsession.selectOne(namespace + ".checkKeyByMap", map);
	}

	@Override
	public void updateStateByMap(String memberId, String state) {
		Map<String, Object> map = new HashMap<>();
		map.put("state", state);
		map.put("memberId", memberId);
		sqlsession.update(namespace + ".updateStateByMap", map);
		
	}

	@Override
	public void updateKeyByMap(String memberId, String authKey) {
		Map<String, Object> map = new HashMap<>();
		map.put("authKey", authKey);
		map.put("memberId", memberId);
		sqlsession.update(namespace + ".updateKeyByMap", map);
		
	}

	@Override
	public Employee checkStateByMap(String memberId, String state) {
		Map<String, Object> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("state", state);
		return sqlsession.selectOne(namespace + ".checkStateByMap", map);
	}

	@Override
	public void updateKeyDateById(String memberId) {
		sqlsession.update(namespace + ".updateKeyDateById", memberId);
	}

	@Override
	public List<Employee> searchEmployee(SearchCriteria searchCriteria) {
		return sqlsession.selectList(namespace + ".searchEmployee", searchCriteria);
	}

	@Override
	public int searchEmployeeCount(SearchCriteria searchCriteria) {
		return sqlsession.selectOne(namespace + ".searchEmployeeCount", searchCriteria);
	}

	@Override
	public void modify(Employee employee) {
		Map<String, Object> map = new HashMap<>();
		map.put("employeeId", employee.getEmployeeId());
		map.put("departmentId", employee.getDepartmentId());
		map.put("name", employee.getName());
		map.put("memberId", employee.getMemberId());
		map.put("password", employee.getPassword());
		map.put("email", employee.getEmail());
		map.put("phone", employee.getPhone());
		
		sqlsession.update(namespace + ".modify", map);
	}

	@Override
	public void delete(int memberId) {
		sqlsession.delete(namespace + ".delete", memberId);
		
	}

	@Override
	public Employee checkEmployeeByEmployeeId(String employeeId) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne(namespace + ".checkEmployeeByEmployeeId", employeeId);
	}


}
