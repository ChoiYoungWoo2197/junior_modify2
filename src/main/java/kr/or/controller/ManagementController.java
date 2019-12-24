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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.domain.Criteria;
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
	public String list(SearchCriteria searchCriteria, Model model, String mgn) {
		logger.info("equipment list & searchContent : " + searchCriteria.getSearchContent());
		logger.info("mgn : " + mgn);
		
		if(mgn.equals("equipment")) {
			List<Equipment> equipmentList = managementServcice.searchEquipment(searchCriteria);
			model.addAttribute("equipmentList", equipmentList);
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCriteria(searchCriteria);
			pageMaker.setTotalCount(managementServcice.searchEquipmentCount(searchCriteria));
			model.addAttribute("pageMaker", pageMaker);
			model.addAttribute("criteria", searchCriteria);
			
			return "management/list";
		} else if(mgn.equals("department")) {
			List<Department> departmentList = managementServcice.searchDepartment(searchCriteria);
			model.addAttribute("departmentList", departmentList);
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCriteria(searchCriteria);
			pageMaker.setTotalCount(managementServcice.searchDepartmentCount(searchCriteria));
			model.addAttribute("pageMaker", pageMaker);
			model.addAttribute("criteria", searchCriteria);
			
			return "management/list";
		}
		return null;
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String insertPage() {
		logger.info("insertPage");
		
		return "management/insert";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insert(String name) {
		logger.info("equipment insert & name : " + name);
		
		Equipment equipment = new Equipment();
		equipment.setName(name);
		equipment.setRegisterDate(new Date());
		
		managementServcice.insertEquipment(equipment);
		
		return "redirect:/management/list";
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public String modifyPage(Model model, int equipmentId) {
		logger.info("insertPage & equipmentId : " + equipmentId);
		
		Equipment equipment = managementServcice.selectEquipmentById(equipmentId);
		model.addAttribute("equipment", equipment);
		
		return "management/modify";
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.POST) 
	public String modify(Equipment equipment) {
		logger.info("equipment update & name : " + equipment.getName() + " & equipmentId : " + equipment.getEquipmentId());
		
		managementServcice.updateEquipment(equipment);
		
		return "redirect:/management/list";
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public @ResponseBody List<Equipment> deleteManagement(Criteria criteria, int equipmentId) {
		logger.info("equipment delete & equipmentId : " + equipmentId);
		
		managementServcice.deleteEquipment(equipmentId);
		
		List<Equipment> equipmentList = managementServcice.listEquipment(criteria);
		return equipmentList;
	}
	
	
	
	/*@RequestMapping(value = "/search", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> searchEquipment(SearchCriteria searchCriteria, Model model) {
		logger.info("equipment search & searchContent : " + searchCriteria.getSearchContent());
		
		List<Equipment> equipmentList = equipmentService.searchEquipment(searchCriteria);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(searchCriteria);
		pageMaker.setTotalCount(equipmentService.searchEquipmentCount(searchCriteria));
		model.addAttribute("pageMaker", pageMaker);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("equipmentList", equipmentList);
		map.put("pageMaker", pageMaker);
		
		System.out.println(map);
		
		return map;
	}*/
}
