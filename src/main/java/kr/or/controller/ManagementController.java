package kr.or.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.domain.Department;
import kr.or.domain.Equipment;
import kr.or.domain.Page;
import kr.or.domain.SearchCriteria;
import kr.or.service.ManagementService;

@Controller
@RequestMapping("/management")
public class ManagementController {
	
	//private static final Logger logger = LoggerFactory.getLogger(ManagementController.class);
	
	@Autowired
	ManagementService managementServcice;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(SearchCriteria searchCriteria, Model model, String management) throws UnsupportedEncodingException {
		if(management.equals("equipment")) {
			List<Equipment> equipmentList = managementServcice.searchEquipment(searchCriteria);
			model.addAttribute("equipmentList", equipmentList);
			
			model.addAttribute("page", new Page(managementServcice.searchEquipmentCount(searchCriteria), searchCriteria));
			model.addAttribute("management", management);
			
			if(searchCriteria.getSearchContent() != null) {
				model.addAttribute("searchContent", URLEncoder.encode(searchCriteria.getSearchContent(), "UTF-8"));
			}
		} else if(management.equals("department")) {
			List<Department> employeeByDepartmentList = managementServcice.searchDepartment(searchCriteria);
			model.addAttribute("employeeByDepartmentList", employeeByDepartmentList);
			
			model.addAttribute("page", new Page(managementServcice.searchDepartmentCount(searchCriteria), searchCriteria));
			model.addAttribute("management", management);
			
			if(searchCriteria.getSearchContent() != null) {
				model.addAttribute("searchContent", URLEncoder.encode(searchCriteria.getSearchContent(), "UTF-8"));
			}
		}
		return "management/list";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String insertPage(Model model, String management) {
		model.addAttribute("management", management);
		return "management/insert";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insert(String management, String name) {
		if(management.equals("equipment")) {
			Equipment equipment = new Equipment();
			equipment.setName(name);
			equipment.setRegisterDate(new Date());
			
			managementServcice.insertEquipment(equipment);
		} else if(management.equals("department")) {
			Department department = new Department();
			department.setName(name);
			department.setRegisterDate(new Date());
			
			managementServcice.insertDepartment(department);
		}
		
		return "redirect:/management/list?management="+management;
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public String modifyPage(Model model, String management, int managementId) {
		if(management.equals("equipment")) {
			Equipment equipment = managementServcice.selectEquipmentById(managementId);
			model.addAttribute("equipment", equipment);
		} else if(management.equals("department")) {
			Department department = managementServcice.selectDepartmentById(managementId);
			model.addAttribute("department", department);
		}
		model.addAttribute("management", management);
		
		return "management/modify";
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.POST) 
	public String modify(Equipment equipment, Department department, String management) {
		if(management.equals("equipment")) {
			managementServcice.updateEquipment(equipment);
		} else if(management.equals("department")) {
			managementServcice.updateDepartment(department);
		}
		
		return "redirect:/management/list?management="+management;
	}
	
	@RequestMapping(value = "/countEmp", method = RequestMethod.GET)
	public @ResponseBody String countEmp(String management, int managementId) {
		int employeeCount = managementServcice.selectEmployeeCountById(managementId);
		String deleteAvailable = "false";
		if(employeeCount == 0) {
			deleteAvailable = "true";
		}
		
		return deleteAvailable;
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String delete(int managementId, String management) {
		if(management.equals("equipment")) {
			managementServcice.deleteEquipment(managementId);
		} else if(management.equals("department")) {
			managementServcice.deleteDepartment(managementId);
		}
		
		return "redirect:/management/list?management="+management;
	}
}
