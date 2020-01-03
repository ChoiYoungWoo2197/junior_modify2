package kr.or.persistence;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.domain.Manager;

@Repository
public class ManagerDaoImpl implements ManagerDao {
	private static final String namespace = "kr.or.mappers.managerMapper";
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public Manager checkManager(int managerId) {
		return sqlSession.selectOne(namespace + ".checkManager", managerId);
	}

	@Override
	public void insertManager(int employeeId) {
		sqlSession.insert(namespace + ".insert",employeeId);
	}

	@Override
	public void deleteManager(int employeeId) {
		sqlSession.delete(namespace + ".delete",employeeId);
	}

}
