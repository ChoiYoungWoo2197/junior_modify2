package kr.or.persistence;

import kr.or.domain.Manager;

public interface ManagerDao {
	public Manager checkManager(int managerId);
	public void insert(int employeeId);
	public void delete(int employeeId);

}
