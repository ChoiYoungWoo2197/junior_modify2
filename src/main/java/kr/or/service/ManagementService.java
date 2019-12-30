package kr.or.service;

import java.util.List;

import kr.or.domain.Department;
import kr.or.domain.Equipment;
import kr.or.domain.SearchCriteria;

public interface ManagementService {
	
	//Equipment
	public List<Equipment> searchEquipment(SearchCriteria criteria);
	public int searchEquipmentCount(SearchCriteria criteria);
	public void insertEquipment(Equipment equipment);
	public Equipment selectEquipmentById(int equipmentId);
	public void updateEquipment(Equipment equipment);
	public void deleteEquipment(int equipmentId);
	
	//Department
	public List<Department> searchDepartment(SearchCriteria searchCriteria);
	public int searchDepartmentCount(SearchCriteria searchCriteria);
	public void insertDepartment(Department department);
	public Department selectDepartmentById(int departmentId);
	public void updateDepartment(Department department);
	public int selectEmployeeCountById(int departmentId);
	public void deleteDepartment(int departmentId);
	
}
