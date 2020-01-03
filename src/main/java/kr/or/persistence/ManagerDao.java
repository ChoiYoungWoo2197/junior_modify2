package kr.or.persistence;

import kr.or.domain.Manager;

public interface ManagerDao {
	public Manager checkManager(int managerId);
	public void insertManager(int employeeId);
	public void deleteManager(int employeeId);

}
