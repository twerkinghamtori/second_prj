package admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import admin.service.AdminManageService;
import dto.Manager;
import exception.ShopException;

@Controller
@RequestMapping("admin/manager")
public class AdminManagerController {

	@Autowired
	private AdminManageService service;
	
	@GetMapping("managerReg")
	public ModelAndView managerRegForm(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		mv.addObject(new Manager());
		return mv;
	}
	
	@PostMapping("managerReg")
	public ModelAndView managerReg(Manager manager, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		if(service.managerReg(manager)) {
			mv.setViewName("redirect:managerList");
			return mv;
		}else {
			throw new ShopException("매니저 등록 실패", "managerList");
		}
	}
	
	@RequestMapping("managerList")
	public ModelAndView managerList(Integer pageNum, String f, String query, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if(f == null || f.equals("")) {
			f = "manager_name";
		}
		if(query == null || query.equals("")) {
			query = "";
		}
		
		int managerCnt = service.managerCnt(f, query);
		
		int limit = 10;
		int maxPage = (int)((double)managerCnt/limit +0.95);
		int startPage = pageNum-(pageNum-1)%5;
		int endPage = startPage + 4;
		if(endPage > maxPage) endPage = maxPage;
		
		List<Manager> managerList =service.getManagerList(pageNum, f, query);
		
		mv.addObject("managerList", managerList);
		mv.addObject("managerCnt", managerCnt);
		mv.addObject("pageNum", pageNum);
		mv.addObject("startPage", startPage);
		mv.addObject("endPage", endPage);
		mv.addObject("maxPage", maxPage);
		return mv;
	}
	
	@PostMapping("managerIdDup")
	@ResponseBody
	public Map<String, String> managerIdDup(String manager_id){
		Map<String, String> map = new HashMap<>();
		
		Manager manager = service.getManager(manager_id);
		
		if(manager == null) {
			map.put("isDup", "0");
			map.put("msg", "해당 아이디는 사용 가능합니다.");
		}else {
			map.put("isDup", "1");
			map.put("msg", "해당 아이디는 중복입니다.");
		}
		return map;
	}
	
	@PostMapping("managerNameDup")
	@ResponseBody
	public Map<String, String> managerNameDup(String manager_name){
		Map<String, String> map = new HashMap<>();
		
		Manager manager = service.getManager2(manager_name);
		
		if(manager == null) {
			map.put("isDup", "0");
			map.put("msg", "해당 매니저명은 사용 가능합니다.");
		}else {
			map.put("isDup", "1");
			map.put("msg", "해당 매니저명은 중복입니다.");
		}
		return map;
	}
	
	@GetMapping("managerChg")
	public ModelAndView managerChg(String manager_id,HttpSession session) {
		ModelAndView mv = new ModelAndView();
		Manager manager = service.getManager(manager_id);
		mv.addObject("manager", manager);
		return mv;
	}
	
	@PostMapping("managerChg")
	public ModelAndView managerChg(Manager manager, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		if(service.managerChg(manager)) {
			mv.setViewName("redirect:managerList");
			return mv;
		}else {
			throw new ShopException("매니저 정보 변경 실패", "managerList");
		}
	}
	
	@PostMapping("managerDel")
	public ModelAndView managerDel(Integer manager_number, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		if(service.managerDel(manager_number)) {
			mv.setViewName("redirect:managerList");
			return mv;
		}else {
			throw new ShopException("매니저 탈퇴 실패", "managerList");
		}
	}
}
