package kr.or.persistence;

import java.util.List;

import kr.or.domain.Equipment;
import kr.or.domain.SearchCriteria;

public interface EquipmentDao {
	
	public int searchEquipmentCount(SearchCriteria criteria);
	public void insertEquipment(Equipment equipment);
	public void updateEquipment(Equipment equipment);
	public void deleteEquipment(int equipmentId);
	public List<Equipment> searchEquipment(SearchCriteria criteria);
	public Equipment selectEquipmentById(int equipmentId);
	
}
