package kr.or.persistence;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import kr.or.domain.Employee;

@Repository
public class EmployeeDaoImpl implements EmployeeDao{
	private static final String namespace = "kr.or.mappers.employeeMapper";
	@Autowired
	private SqlSessionFactory sqlSessionFactory; 

	@Autowired
	SqlSession sqlsession;

	@Override
	public void insertData(String employeeId, String departmentId, String name, String password, String email,
			String phone) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		try(SqlSession session = sqlSessionFactory.openSession()) {
			map.put("employee_id", employeeId);
			map.put("department_id", departmentId);
			map.put("name", name);
			map.put("password", password);
			map.put("email", email);
			map.put("phone", phone);
			
			session.insert(namespace + ".insertEmployee",map);
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	@Override
	public void deleteData(String employeeId) {
		// TODO Auto-generated method stub
		try(SqlSession session = sqlSessionFactory.openSession()) {
			session.delete(namespace + ".deleteEmployee",employeeId);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	@Override
	public void updateDate(String employeeId, String departmentId, String name, String password, String email,
			String phone) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		try(SqlSession session = sqlSessionFactory.openSession()) {
			map.put("employee_id", employeeId);
			map.put("department_id", departmentId);
			map.put("name", name);
			map.put("password", password);
			map.put("email", email);
			map.put("phone", phone);
			
			session.update(namespace + ".updateEmployee",map);
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	@Override
	public List<Employee> selectAll() {
		// TODO Auto-generated method stub
		List<Employee> employeeList = new ArrayList<Employee>();
		try(SqlSession session = sqlSessionFactory.openSession()) {
			employeeList = session.selectList(namespace + ".selectEmployee");
		} catch (Exception e) {
			// TODO: handle exception
		}
		return employeeList;
	}

	@Override
	public boolean checkAccount(String employeeId, String password) {
		// TODO Auto-generated method stub
		boolean result = false;
		Map<String, Object> map = new HashMap<>();
		
		try(SqlSession session = sqlSessionFactory.openSession()) {
			map.put("employee_id", employeeId);
			map.put("password", password);
			
			System.out.println("실행됨?2");
			result = session.selectOne(namespace + ".selectAccountEmployee", map);
			System.out.println(result);
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.toString());
		}
		return result;
	}
}
