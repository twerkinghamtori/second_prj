package admin.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
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
@RequestMapping("admin")
public class AdminMainController {

	@Autowired
	private AdminManageService service;

	@RequestMapping("main")
	public ModelAndView adminMain(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		Date today = new Date();
		mv.addObject("today", today);
		return mv;
	}

	@RequestMapping("qna")
	public String adminMqna(HttpSession session) {
		return "admin/qna";
	}

	@GetMapping("login")
	public String login() {
		return "admin/login";
	}

	@PostMapping("login")
	public ModelAndView login(String manager_id, String manager_pass, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		Manager dbManager = service.managerLogin(manager_id, manager_pass);

		if(dbManager == null) {
			throw new ShopException("아이디 또는 비밀번호를 확인하세요.", "login");
		}else {
			session.setAttribute("loginManager", dbManager);
			mv.setViewName("redirect:main");
		}

		return mv;
	}

	@RequestMapping("logout")
	public String adminLogout(HttpSession session) {
		session.invalidate();
		return "redirect:login";
	}

	@RequestMapping("salesList")
	@ResponseBody
	public List<Map<String, Object>> salesList(){
		List<Map<String, Object>> list = new ArrayList<>();

		LocalDate currentDate = LocalDate.now();

		for (int i = 0; i < 7; i++) {
			LocalDate date = currentDate.minusDays(i);
			Map<String, Object> map = service.salesList(date);
			list.add(map);
		}

		return list;
	}
	
	@RequestMapping("orderState")
	@ResponseBody
	public Map<String, Object> orderState(){
		Map<String, Object> map = service.orderState();
		return map;
	}
}
