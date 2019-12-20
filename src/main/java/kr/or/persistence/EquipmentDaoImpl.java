package kr.or.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.domain.Criteria;
import kr.or.domain.Equipment;
import kr.or.domain.SearchCriteria;

@Repository
public class EquipmentDaoImpl implements EquipmentDao {
	private static final String namespace = "kr.or.mappers.equipmentMapper";
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<Equipment> listEquipment(Criteria criteria) {
		return sqlSession.selectList(namespace + ".listEquipment", criteria);
	}
	
	@Override
	public void insertEquipment(Equipment equipment) {
		sqlSession.insert(namespace + ".insertEquipment", equipment);
	}

	@Override
	public void updateEquipment(Equipment equipment) {
		sqlSession.update(namespace + ".updateEquipment", equipment);
	}

	@Override
	public void deleteEquipment(int equipmentId) {
		sqlSession.update(namespace + ".deleteEquipment", equipmentId);
	}

	@Override
	public int listEquipmentCount() {
		return sqlSession.selectOne(namespace + ".listEquipmentCount");
	}

	@Override
	public List<Equipment> searchEquipment(SearchCriteria criteria) {
		return sqlSession.selectList(namespace + ".searchEquipment", criteria);
	}

	@Override
	public int searchEquipmentCount(SearchCriteria criteria) {
		return sqlSession.selectOne(namespace + ".searchEquipmentCount", criteria);
	}

}
