package admin.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import admin.service.AdminManageService;
import dto.Mem;
import dto.Point;
import exception.ShopException;

@Controller
@RequestMapping("admin/point")
public class AdminPointController {
	
	@Autowired
	private AdminManageService service;
	
	@GetMapping("pointReg")
	public ModelAndView adminPointReg(Integer mem_number, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		Mem mem = service.getMem(mem_number);
		
		if(mem == null) {
			throw new ShopException("해당 회원은 존재하지 않습니다.", "../point/pointList");
		}
		mv.addObject("mem",mem);
		return mv;
	}
	
	@PostMapping("pointReg")
	public ModelAndView adminPointReg(Point point, Integer mem_number,HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		if(service.regPoint(point)) {
			mv.setViewName("redirect:pointList");
			return mv;
		}else {
			throw new ShopException("포인트 등록 실패", "pointReg?mem_number="+mem_number);
		}
	}
	
	@RequestMapping("pointList")
	public ModelAndView adminProdList(Integer pageNum, String query, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if(query == null || query.equals("")) {
			query = "";
		}
		
		int pointCnt = service.getPointCnt(query);
		
		int limit = 10;
		int maxPage = (int)((double)pointCnt/limit +0.95);
		int startPage = pageNum-(pageNum-1)%5;
		int endPage = startPage + 4;
		if(endPage > maxPage) endPage = maxPage;
		
		List<Point> pointList =service.getPointList(pageNum, query);
		
		mv.addObject("pointCnt", pointCnt);
		mv.addObject("pointList", pointList);
		mv.addObject("pageNum", pageNum);
		mv.addObject("startPage", startPage);
		mv.addObject("endPage", endPage);
		mv.addObject("maxPage", maxPage);
		return mv;
	}
	
	@PostMapping("pointDel")
	public ModelAndView managerPointDel(Integer point_number, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		if(service.pointDel(point_number)) {
			mv.setViewName("redirect:pointList");
			return mv;
		}else {
			throw new ShopException("포인트 지급 내역 삭제 실패", "pointList");
		}
	}
}
