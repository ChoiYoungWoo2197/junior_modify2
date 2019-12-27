package kr.or.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.domain.Department;
import kr.or.domain.Equipment;
import kr.or.domain.SearchCriteria;
import kr.or.persistence.DepartmentDao;
import kr.or.persistence.EquipmentDao;

@Service
public class ManagementServiceImpl implements ManagementService {
	
	@Autowired
	EquipmentDao equipmentDao;
	
	@Autowired
	DepartmentDao departmentDao;
	
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
	public List<Equipment> searchEquipment(SearchCriteria criteria) {
		return equipmentDao.searchEquipment(criteria);
	}

	@Override
	public int searchEquipmentCount(SearchCriteria criteria) {
		return equipmentDao.searchEquipmentCount(criteria);
	}

	@Override
	public Equipment selectEquipmentById(int equipmentId) {
		return equipmentDao.selectEquipmentById(equipmentId);
	}

	@Override
	public List<Department> searchDepartment(SearchCriteria searchCriteria) {
		return departmentDao.searchDepartment(searchCriteria);
	}
	
	@Override
	public int searchDepartmentCount(SearchCriteria searchCriteria) {
		return departmentDao.searchDepartmentCount(searchCriteria);
	}

	@Override
	public void insertDepartment(Department department) {
		departmentDao.insertDepartment(department);
	}

	@Override
	public Department selectDepartmentById(int departmentId) {
		return departmentDao.selectDepartmentById(departmentId);
	}

	@Override
	public void updateDepartment(Department department) {
		departmentDao.updateDepartment(department);
	}
	
	@Override
	public int selectEmployeeCountById(int departmentId) {
		return departmentDao.selectEmployeeCountById(departmentId);
	}

	@Override
	public void deleteDepartment(int departmentId) {
		departmentDao.deleteDepartment(departmentId);
	}

}
