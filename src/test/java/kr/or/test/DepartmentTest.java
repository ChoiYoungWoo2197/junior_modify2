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

@RunWith(SpringJUnit4ClassRunner.class) //-> 스프링의 테스트 컨텍스트 프레임워크의 JUnit 확장기능 지정
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/root-context.xml"}) //참고할 컨텍스트의 위치 지정
public class DepartmentTest {
	private static final String namespace = "kr.or.mappers.departmentMapper";
	@Autowired
	private SqlSessionFactory sqlSessionFactory; 

	@Test
	public void testInsertSession() {
		try(SqlSession session = sqlSessionFactory.openSession()) {
			System.out.println("1. Insert 실행");
			session.insert(namespace + ".insertDepartment","wow");
			//session.commit();

			System.out.println("인서트 성공");
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.toString());
		}
	}

	@Test
	public void testUpdateSession() {
		try(SqlSession session = sqlSessionFactory.openSession()) {
			System.out.println("2. Update 실행");
			Map<String, Object> map = new HashMap<>();
			map.put("departmentId", "2");
			map.put("name", "test3");


			session.delete(namespace + ".updateDepartment",map);
			//session.commit();

			System.out.println("업데이트 성공");
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.toString());
		}
	}


	@Test
	public void testSelectAllSession() {
		try(SqlSession session = sqlSessionFactory.openSession()) {
			System.out.println("3. Select 실행");

			List<Department> departmentList = session.selectList(namespace + ".selectDepartment");

			for (int i = 0; i < departmentList.size(); i++) {
				System.out.println(departmentList.get(i).getDepartmentId() + " : " + departmentList.get(i).getName());
			}
			//session.commit();

			System.out.println("셀렉트 성공");
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.toString());
		}
	}


	@Test
	public void testDeleteSession() {
		try(SqlSession session = sqlSessionFactory.openSession()) {
			System.out.println("2. Delete 실행");
			String id = "1";
			session.delete(namespace + ".deleteDepartment",id);
			//session.commit();

			System.out.println("딜리트 성공");
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.toString());
		}
	}

}
