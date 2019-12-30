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
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace + ".checkManager", managerId);
	}

}
