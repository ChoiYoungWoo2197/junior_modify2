package kr.or.persistence;

import java.util.List;

import kr.or.domain.Equipment;

public interface EquipmentDao {
	
	public List<Equipment> listEquipment();
	public void insertEquipment(Equipment equipment);
	public void updateEquipment(Equipment equipment);
	public void deleteEquipment(int equipmentId);
	
}
