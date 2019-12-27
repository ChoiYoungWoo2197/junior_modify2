package kr.or.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.domain.Equipment;
import kr.or.domain.SearchCriteria;

@Repository
public class EquipmentDaoImpl implements EquipmentDao {
	private static final String namespace = "kr.or.mappers.equipmentMapper";
	
	@Autowired
	SqlSession sqlSession;
	
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
	public List<Equipment> searchEquipment(SearchCriteria searchCriteria) {
		return sqlSession.selectList(namespace + ".searchEquipment", searchCriteria);
	}

	@Override
	public int searchEquipmentCount(SearchCriteria searchCriteria) {
		return sqlSession.selectOne(namespace + ".searchEquipmentCount", searchCriteria);
	}

	@Override
	public Equipment selectEquipmentById(int equipmentId) {
		return sqlSession.selectOne(namespace + ".selectEquipmentById", equipmentId);
	}

	@Override
	public List<Equipment> selectEquipment() {
		return sqlSession.selectList(namespace + ".selectEquipment");
	}

}
