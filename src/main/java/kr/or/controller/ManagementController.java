package kr.or.controller;

import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.domain.Department;
import kr.or.domain.Equipment;
import kr.or.domain.PageMaker;
import kr.or.domain.SearchCriteria;
import kr.or.service.ManagementService;

@Controller
@RequestMapping("/management/*")
public class ManagementController {
	
	private static final Logger logger = LoggerFactory.getLogger(ManagementController.class);
	
	@Autowired
	ManagementService managementServcice;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(SearchCriteria searchCriteria, Model model, String mgt) {
		logger.info("management list & searchContent : " + searchCriteria.getSearchContent());
		
		if(mgt.equals("equipment")) {
			List<Equipment> equipmentList = managementServcice.searchEquipment(searchCriteria);
			model.addAttribute("equipmentList", equipmentList);
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCriteria(searchCriteria);
			pageMaker.setTotalCount(managementServcice.searchEquipmentCount(searchCriteria));
			model.addAttribute("pageMaker", pageMaker);
			model.addAttribute("criteria", searchCriteria);
			
			model.addAttribute("mgt", mgt);
		} else if(mgt.equals("department")) {
			List<Department> departmentList = managementServcice.searchDepartment(searchCriteria);
			model.addAttribute("departmentList", departmentList);
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCriteria(searchCriteria);
			pageMaker.setTotalCount(managementServcice.searchDepartmentCount(searchCriteria));
			model.addAttribute("pageMaker", pageMaker);
			model.addAttribute("criteria", searchCriteria);
			model.addAttribute("mgt", mgt);
		}
		return "management/list";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String insertPage(Model model, String mgt) {
		logger.info("insertPage");
		
		model.addAttribute("mgt", mgt);
		return "management/insert";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insert(String mgt, String name) {
		logger.info("equipment insert & name : " + name);
		
		if(mgt.equals("equipment")) {
			Equipment equipment = new Equipment();
			equipment.setName(name);
			
			managementServcice.insertEquipment(equipment);
		} else if(mgt.equals("department")) {
			Department department = new Department();
			department.setName(name);
			
			managementServcice.insertDepartment(department);
		}
		
		return "redirect:/management/list?mgt="+mgt;
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public String modifyPage(Model model, String mgt, int managementId) {
		logger.info("insertPage & managementId : " + managementId);
		
		if(mgt.equals("equipment")) {
			Equipment equipment = managementServcice.selectEquipmentById(managementId);
			model.addAttribute("equipment", equipment);
		} else if(mgt.equals("department")) {
			Department department = managementServcice.selectDepartmentById(managementId);
			model.addAttribute("department", department);
		}
		model.addAttribute("mgt", mgt);
		
		return "management/modify";
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.POST) 
	public String modify(Equipment equipment, Department department, String mgt) {
		logger.info("equipment update & name : " + equipment.getName() + " & equipmentId : " + equipment.getEquipmentId());
		logger.info("equipment update & name : " + department.getName() + " & equipmentId : " + department.getDepartmentId());
		
		if(mgt.equals("equipment")) {
			managementServcice.updateEquipment(equipment);
		} else if(mgt.equals("department")) {
			managementServcice.updateDepartment(department);
		}
		
		return "redirect:/management/list?mgt="+mgt;
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String delete(int managementId, String mgt) {
		logger.info("equipment delete & managementId : " + managementId);
		
		if(mgt.equals("equipment")) {
			managementServcice.deleteEquipment(managementId);
		} else if(mgt.equals("department")) {
			managementServcice.deleteDepartment(managementId);
		}
		
		return "redirect:/management/list?mgt="+mgt;
	}
}
