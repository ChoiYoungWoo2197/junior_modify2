package kr.or.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.domain.Criteria;
import kr.or.domain.Equipment;
import kr.or.domain.SearchCriteria;
import kr.or.persistence.EquipmentDao;

@Service
public class EquipmentServiceImpl implements EquipmentService {
	
	@Autowired
	EquipmentDao equipmentDao;
	
	@Override
	public List<Equipment> listEquipment(Criteria criteria) {
		return equipmentDao.listEquipment(criteria);
	}

	@Override
	public void insertEquipment(Equipment equipment) {
		equipmentDao.insertEquipment(equipment);
	}

	@Override
	public void updateEquipment(Equipment equipment) {
		equipmentDao.updateEquipment(equipment);
	}

	@Override
	public void deleteEquipment(int equipmentId) {
		equipmentDao.deleteEquipment(equipmentId);
	}

	@Override
	public int listEquipmentCount() {
		return equipmentDao.listEquipmentCount();
	}

	@Override
	public List<Equipment> searchEquipment(SearchCriteria criteria) {
		return equipmentDao.searchEquipment(criteria);
	}

	@Override
	public int searchEquipmentCount(SearchCriteria criteria) {
		return equipmentDao.searchEquipmentCount(criteria);
	}

}
