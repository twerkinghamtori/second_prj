package admin.controller;
// jjk test
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import admin.service.AdminManageService;
import dto.Delivery;
import dto.Mem;
import exception.ShopException;

@Controller
@RequestMapping("admin/mem")
public class AdminMemController {

	@Autowired
	private AdminManageService service;
	
	@RequestMapping("memList")
	public ModelAndView adminMemList(Integer pageNum, String f, String query, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if(f == null || f.equals("")) {
			f = "mem_id";
		}
		if(query == null || query.equals("")) {
			query = "";
		}
		
		int memCnt = service.memCnt(f, query);
		
		int limit = 10;
		int maxPage = (int)((double)memCnt/limit +0.95);
		int startPage = pageNum-(pageNum-1)%5;
		int endPage = startPage + 4;
		if(endPage > maxPage) endPage = maxPage;
		
		List<Mem> memList =service.getMemList(pageNum, f, query);
		
		mv.addObject("memCnt", memCnt);
		mv.addObject("memList", memList);
		mv.addObject("pageNum", pageNum);
		mv.addObject("startPage", startPage);
		mv.addObject("endPage", endPage);
		mv.addObject("maxPage", maxPage);
		return mv;
	}
	
	@GetMapping("memChg")
	public ModelAndView adminMemChg(Integer mem_number,  HttpSession session) {
		ModelAndView mv = new ModelAndView();
		Mem mem = service.getMem(mem_number);
		
		if(mem == null) {
			throw new ShopException("해당 회원은 존재하지 않습니다.", "memList");
		}
		
		List<Delivery> delList = service.getDelList(mem.getMem_id());
		
		mv.addObject("mem",mem);
		mv.addObject("delList",delList);
		return mv;
	}
	
	@PostMapping("memChg")
	public ModelAndView adminMemChg(Mem mem,  HttpSession session) {
		ModelAndView mv = new ModelAndView();
		if(service.memChg(mem)) {
			mv.setViewName("redirect:memChg?mem_number="+mem.getMem_number());
			return mv;
		}else {
			throw new ShopException("회원 정보 변경 실패", "memChg?mem_number="+mem.getMem_number());
		}
	}
	
	@PostMapping("memDel")
	public ModelAndView managerMemDel(Integer mem_number, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		if(service.memDel(mem_number)) {
			mv.setViewName("redirect:memList");
			return mv;
		}else {
			throw new ShopException("회원 탈퇴 실패", "memList");
		}
	}
}
