package kr.or.test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.or.domain.Department;
import kr.or.domain.Employee;

@RunWith(SpringJUnit4ClassRunner.class) //-> 스프링의 테스트 컨텍스트 프레임워크의 JUnit 확장기능 지정
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/root-context.xml"}) //참고할 컨텍스트의 위치 지정
public class EmployeeTest {
	private static final String namespace = "kr.or.mappers.employeeMapper";
	@Autowired
	private SqlSessionFactory sqlSessionFactory; 
	
	@Test
	public void testInsertSession() {
		Map<String, Object> map = new HashMap<>();
		try(SqlSession session = sqlSessionFactory.openSession()) {
			map.put("employee_id", "1");
			map.put("department_id", "2");
			map.put("name", "test");
			map.put("password", "test");
			map.put("email", "test");
			map.put("phone", "test");
			
			session.insert(namespace + ".insertEmployee",map);
			
			System.out.println("insert");
		} catch (Exception e) {
			// TODO: handle exception
		}
	}


	
	
	@Test
	public void testUpdateSession() {
		Map<String, Object> map = new HashMap<>();
		try(SqlSession session = sqlSessionFactory.openSession()) {
			map.put("employee_id", "1");
			map.put("department_id", "3");
			map.put("name", "test3");
			map.put("password", "test3");
			map.put("email", "test3");
			map.put("phone", "test3");
			
			session.update(namespace + ".updateEmployee",map);
			System.out.println("update");
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	
	@Test
	public void testSelectAllSession() {
		try(SqlSession session = sqlSessionFactory.openSession()) {
			
			List<Employee> employeeList = session.selectList(namespace + ".selectEmployee");
			
			for (int i = 0; i < employeeList.size(); i++) {
				System.out.println(employeeList.get(i).getName());
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.toString());
		}
	}
	

	
	
	@Test
	public void testDeleteSession() {
		try(SqlSession session = sqlSessionFactory.openSession()) {
			String employeeId = "1";
			session.delete(namespace + ".deleteEmployee",employeeId);
			System.out.println("delete");
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	

}
