package kr.or.test;

import java.util.Date;
import java.util.List;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.or.domain.Equipment;
import kr.or.persistence.EquipmentDao;

@RunWith(SpringJUnit4ClassRunner.class) //-> 스프링의 테스트 컨텍스트 프레임워크의 JUnit 확장기능 지정
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/root-context.xml"}) //참고할 컨텍스트의 위치 지정
public class EquipmentTest {
	
	@Autowired
	EquipmentDao equipmentDao;
	
	//@Test
	public void testList() {
		List<Equipment> list = equipmentDao.listEquipment();
		
		for(Equipment equipment : list) {
			System.out.println(equipment.getName());
		}
	}
	
	//@Test
	public void testInsert() {
		Equipment equipment = new Equipment();
		equipment.setName("화이트보드");
		equipment.setRegisterDate(new Date());
		
		equipmentDao.insertEquipment(equipment);
		System.out.println(equipment.getName());
	}
	
	//@Test
	public void testUpdate() {
		Equipment equipment = new Equipment();
		equipment.setEquipmentId(1);
		equipment.setName("whiteBoard");
		
		equipmentDao.updateEquipment(equipment);
		System.out.println(equipment.getName());
	}
	
	@Test
	public void testDelete() {
		equipmentDao.deleteEquipment(1);
	}

}
