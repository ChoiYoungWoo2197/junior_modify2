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
import kr.or.domain.Equipment;
import kr.or.domain.PageMaker;
import kr.or.domain.SearchCriteria;
import kr.or.service.EquipmentService;

@Controller
@RequestMapping("/equipment/*")
public class EquipmentController {
	
	private static final Logger logger = LoggerFactory.getLogger(EquipmentController.class);
	
	@Autowired
	EquipmentService equipmentService;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(SearchCriteria searchCriteria, Model model) {
		logger.info("equipment list & searchContent : " + searchCriteria.getSearchContent());
		
		List<Equipment> equipmentList = equipmentService.searchEquipment(searchCriteria);
		model.addAttribute("equipmentList", equipmentList);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(searchCriteria);
		pageMaker.setTotalCount(equipmentService.searchEquipmentCount(searchCriteria));
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("criteria", searchCriteria);
		
		return "equipment/listEquipment";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insertEquipment(Criteria criteria, String name) {
		logger.info("equipment insert & name : " + name);
		
		Equipment equipment = new Equipment();
		equipment.setName(name);
		equipment.setRegisterDate(new Date());
		
		equipmentService.insertEquipment(equipment);
		
		return "redirect:/equipment/list";
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public @ResponseBody List<Equipment> deleteEquipment(Criteria criteria, int equipmentId) {
		logger.info("equipment delete & equipmentId : " + equipmentId);
		
		equipmentService.deleteEquipment(equipmentId);
		
		List<Equipment> equipmentList = equipmentService.listEquipment(criteria);
		return equipmentList;
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST) 
	public String updateEquipment(Criteria criteria, String name, int equipmentId) {
		logger.info("equipment update & name : " + name + " & equipmentId : " + equipmentId);
		
		Equipment equipment = new Equipment();
		equipment.setEquipmentId(equipmentId);
		equipment.setName(name);

		equipmentService.updateEquipment(equipment);
		
		return "redirect:/equipment/list";
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
