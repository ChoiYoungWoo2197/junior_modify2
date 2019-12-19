package kr.or.test;


import java.sql.Connection;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


@RunWith(SpringJUnit4ClassRunner.class) //-> 스프링의 테스트 컨텍스트 프레임워크의 JUnit 확장기능 지정
/*
 * JUnit은 각각의 테스트가 서로 영향을 주지 않고 독립적으로 실행됨을 기본으로 하기에 각각의 테스트 클래스마다 매번 오브젝트를 생성한다.
 * 그러므로 각각의 테스트 클래스에 지정한 ApplicationContext도 매번 새로 생성이 되는 상황이 발생된다. 
 * 그러나 @RunWith annotation은 각각의 테스트별로 오브젝트가 생성이 되더라도 싱글톤의 ApplicationContext를 보장하는 역할을 한다.
 */
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/root-context.xml"}) //참고할 컨텍스트의 위치 지정
public class DBConnectionTest {

	@Autowired
	private DataSource dataSource;
	
	@Test
	public void test() {
		Connection connection = null;
		try {
			connection = dataSource.getConnection();
            System.out.println(connection);
        } catch(Exception e) {
            e.printStackTrace();
        }
	}

}
