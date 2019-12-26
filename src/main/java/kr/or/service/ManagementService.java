package kr.or.service;

import java.util.List;

import kr.or.domain.Criteria;
import kr.or.domain.Department;
import kr.or.domain.Equipment;
import kr.or.domain.SearchCriteria;

public interface ManagementService {
	
	// equipment
	//public List<Equipment> listEquipment(Criteria criteria);
	public void insertEquipment(Equipment equipment);
	public void updateEquipment(Equipment equipment);
	public void deleteEquipment(int equipmentId);
	//public int listEquipmentCount();
	public List<Equipment> searchEquipment(SearchCriteria criteria);
	public int searchEquipmentCount(SearchCriteria criteria);
	public Equipment selectEquipmentById(int equipmentId);
	
	//department
	public List<Department> searchDepartment(SearchCriteria searchCriteria);
	public int searchDepartmentCount(SearchCriteria searchCriteria);
	public void insertDepartment(Department department);
	public Department selectDepartmentById(int departmentId);
	public void updateDepartment(Department department);
	public void deleteDepartment(int departmentId);
}
