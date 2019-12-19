package kr.or.persistence;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import kr.or.domain.Department;

public class DepartmentDaoImpl implements DepartmentDao {
	private static final String namespace = "kr.or.mappers.departmentMapper";
	@Autowired
	private SqlSessionFactory sqlSessionFactory; 
	
	@Autowired
	SqlSession sqlsession;
	
	@Override
	public void insertData(String name) {
		// TODO Auto-generated method stub
		try(SqlSession session = sqlSessionFactory.openSession()) {
			sqlsession.insert(namespace + ".insertDepartment", name);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	@Override
	public void deleteData(String departmentId) {
		// TODO Auto-generated method stub
		try(SqlSession session = sqlSessionFactory.openSession()) {
			session.delete(namespace + ".deleteDepartment",departmentId);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	@Override
	public void updateDate(String departmentId, String name) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		
		try(SqlSession session = sqlSessionFactory.openSession()) {
			map.put("departmentId", departmentId);
			map.put("name", name);
			
			session.update(namespace + ".updateDepartment",map);
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	@Override
	public List<Department> selectAll() {
		// TODO Auto-generated method stub
		List<Department> departmentList = new ArrayList<Department>();
		
		try(SqlSession session = sqlSessionFactory.openSession()) {
			departmentList = session.selectList(namespace + ".selectDepartment");
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return departmentList;
	}

}
