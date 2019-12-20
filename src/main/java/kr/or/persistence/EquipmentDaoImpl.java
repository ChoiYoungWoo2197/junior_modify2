package kr.or.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.domain.Equipment;

@Repository
public class EquipmentDaoImpl implements EquipmentDao {
	private static final String namespace = "kr.or.mappers.equipmentMapper";
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<Equipment> listEquipment() {
		return sqlSession.selectList(namespace + ".listEquipment");
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

}
