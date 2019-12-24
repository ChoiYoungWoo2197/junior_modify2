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
	public boolean checkAccount(String employeeId, String password) {
		Map<String, Object> map = new HashMap<>();
		map.put("employee_id", employeeId);
		map.put("password", password);
		return sqlsession.selectOne(namespace + ".selectAccountEmployee", map);
	}
}
