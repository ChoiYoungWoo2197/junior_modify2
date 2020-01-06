package kr.or.persistence;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.domain.Extend;

@Repository
public class ExtendDaoImpl implements ExtendDao {
	private static final String namespace = "kr.or.mappers.extendMapper";
	@Autowired
	SqlSession sqlsession;
	@Override
	public void insertExtendByMap(Extend extend) {
		// TODO Auto-generated method stub
		sqlsession.insert(namespace + ".insertExtendByMap", extend);
	}

}
