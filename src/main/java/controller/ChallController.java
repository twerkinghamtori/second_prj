package controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dto.Chall;
import dto.Mem;
import exception.ShopException;
import service.ShopService;

@Controller
@RequestMapping("chall")
public class ChallController {

	@Autowired
	private ShopService service;
	
	@GetMapping("challReg")
	public ModelAndView loginCheckChallReg(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		mv.addObject(new Chall());
		return mv;
	}
	
	@PostMapping("challReg")
	public ModelAndView loginCheckChallReg(Chall chall, HttpServletRequest request, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		String mem_id = chall.getMem_id();
		Date challRegDate = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String chall_regdate = dateFormat.format(challRegDate);
		
		Chall dbChall = service.getChall(mem_id, chall_regdate);
		
		if(dbChall != null) {
			throw new ShopException("중복 이벤트 참여 입니다.", "challList");
		}
		
		if(service.regChall(chall, request)) {
			mv.setViewName("redirect:challList");
			return mv;
		}else {
			throw new ShopException("오류 입니다.", "challList");
		}
	}
	
	@RequestMapping("challList")
	public ModelAndView challList(Integer pageNum, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		
		int challCnt = service.getChallCnt();
		
		int limit = 8;
		int maxPage = (int)((double)challCnt/limit +0.95);
		int startPage = pageNum-(pageNum-1)%5;
		int endPage = startPage + 4;
		if(endPage > maxPage) endPage = maxPage;
		
		List<Chall> challList =service.getChallList(pageNum);
		Mem mem = (Mem)session.getAttribute("loginMem");
		if(mem != null) {
			Chall myChall = service.getMyChall(mem.getMem_id());
			if(myChall != null) {
				double chall_cnt = (double)myChall.getChall_cnt()/365;
				mv.addObject("chall_cnt",chall_cnt);
				mv.addObject("myChall", myChall);
			}			
		}		
		mv.addObject("challList", challList);
		mv.addObject("pageNum", pageNum);
		mv.addObject("startPage", startPage);
		mv.addObject("endPage", endPage);
		mv.addObject("maxPage", maxPage);
		return mv;
	}
}
