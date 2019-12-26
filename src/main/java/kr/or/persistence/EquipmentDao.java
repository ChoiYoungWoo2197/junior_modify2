package kr.or.persistence;

import java.util.List;

import kr.or.domain.Equipment;
import kr.or.domain.SearchCriteria;

public interface EquipmentDao {
	
	public List<Equipment> searchEquipment(SearchCriteria searchCriteria);
	public int searchEquipmentCount(SearchCriteria searchCriteria);
	public void insertEquipment(Equipment equipment);
	public Equipment selectEquipmentById(int equipmentId);
	public void updateEquipment(Equipment equipment);
	public void deleteEquipment(int equipmentId);
	
	public List<Equipment> selectEquipment();
	
}
