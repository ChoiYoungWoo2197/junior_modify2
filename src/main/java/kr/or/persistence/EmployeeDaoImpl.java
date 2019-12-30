package kr.or.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import kr.or.domain.Employee;

@Repository
public class EmployeeDaoImpl implements EmployeeDao{
	private static final String namespace = "kr.or.mappers.employeeMapper";
	@Autowired
	SqlSession sqlsession;

	@Override
	public void insertData(Employee employee) {
		sqlsession.insert(namespace + ".insertEmployee",employee);
	}

	@Override
	public List<Employee> selectAll() {
		return sqlsession.selectList(namespace + ".selectEmployee");
	}

	@Override
	public Employee checkUser(String memberId, String password) {
		Map<String, Object> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("password", password);
		return sqlsession.selectOne(namespace + ".checkUser", map);
	}

	@Override
	public Employee checkIdEmployee(String employeeId) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne(namespace + ".selectCheckIdEmployee", employeeId);
	}

	@Override
	public Employee checkEmailEmployee(String email) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne(namespace + ".selectCheckEmailEmployee", email);
	}

	@Override
	public Employee checkKey(String email, String authKey) {
		Map<String, Object> map = new HashMap<>();
		map.put("email", email);
		map.put("authkey", authKey);
		return sqlsession.selectOne(namespace + ".selectCheckKeyEmployee", map);
	}

	@Override
	public void modifyState(String memberId, String state) {
		Map<String, Object> map = new HashMap<>();
		map.put("state", state);
		map.put("memberId", memberId);
		sqlsession.update(namespace + ".modifyStateEmployee", map);
		
	}

	@Override
	public void modifyKey(String memberId, String authKey) {
		Map<String, Object> map = new HashMap<>();
		map.put("authKey", authKey);
		map.put("memberId", memberId);
		sqlsession.update(namespace + ".modifyKeyEmployee", map);
		
	}

	@Override
	public Employee checkState(String memberId, String state) {
		Map<String, Object> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("state", state);
		return sqlsession.selectOne(namespace + ".checkState", map);
	}

	@Override
	public void modifyAuthKeyDate(String memberId) {
		sqlsession.update(namespace + ".modifyAuthKeyDate", memberId);
	}
}
