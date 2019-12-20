package kr.or.controller;

import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
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
	public void list(@ModelAttribute("criteria") Criteria criteria, Model model) {
		logger.info("equipment list");
		
		List<Equipment> equipmentList = equipmentService.listEquipment(criteria);
		model.addAttribute("equipmentList", equipmentList);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(criteria);
		pageMaker.setTotalCount(equipmentService.listEquipmentCount());
		model.addAttribute("pageMaker", pageMaker);
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public @ResponseBody List<Equipment> insertEquipment(@ModelAttribute("criteria") Criteria criteria, String name) {
		logger.info("equipment insert & name : " + name);
		
		Equipment equipment = new Equipment();
		equipment.setName(name);
		equipment.setRegisterDate(new Date());
		
		equipmentService.insertEquipment(equipment);
		
		List<Equipment> equipmentList = equipmentService.listEquipment(criteria);
		return equipmentList;
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public @ResponseBody List<Equipment> deleteEquipment(@ModelAttribute("criteria") Criteria criteria, int equipmentId) {
		logger.info("equipment delete & equipmentId : " + equipmentId);
		
		equipmentService.deleteEquipment(equipmentId);
		
		List<Equipment> equipmentList = equipmentService.listEquipment(criteria);
		return equipmentList;
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST) 
	public @ResponseBody List<Equipment> updateEquipment(@ModelAttribute("criteria") Criteria criteria, String name, int equipmentId) {
		logger.info("equipment update & name : " + name + " & equipmentId : " + equipmentId);
		
		Equipment equipment = new Equipment();
		equipment.setEquipmentId(equipmentId);
		equipment.setName(name);

		equipmentService.updateEquipment(equipment);
		
		List<Equipment> equipmentList = equipmentService.listEquipment(criteria);
		return equipmentList;
	}
	
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public @ResponseBody List<Equipment> searchEquipment(@ModelAttribute("criteria") SearchCriteria criteria, Model model) {
		logger.info("equipment search & searchContent : " + criteria.getSearchContent());
		
		List<Equipment> equipmentList = equipmentService.searchEquipment(criteria);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(criteria);
		pageMaker.setTotalCount(equipmentService.searchEquipmentCount(criteria));
		model.addAttribute("pageMaker", pageMaker);
		
		return equipmentList;
	}
}
