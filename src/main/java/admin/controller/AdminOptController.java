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

import admin.service.AdminShopService;
import dto.Opt;
import dto.OrderView;
import dto.Product;
import dto.ProductOptView;
import dto.Stock;
import exception.ShopException;

@Controller
@RequestMapping("admin/opt")
public class AdminOptController {

	@Autowired
	private AdminShopService service;
	
	@GetMapping("optReg")
	public ModelAndView adminOprReg(Integer product_number,HttpSession session) {
		ModelAndView mv = new ModelAndView();
		Product product = service.getProd(product_number);
		if(product == null) {
			throw new ShopException("해당 제품은 존재하지 않습니다.", "../product/prodList");
		}
		mv.addObject("product",product);
		return mv;
	}
	
	@PostMapping("optReg")
	public ModelAndView adminOprReg(Opt opt, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		if(service.regProductOpt(opt)) {
			mv.setViewName("redirect:optList");
			return mv;
		}else {
			throw new ShopException("옵션 등록 실패", "optReg?product_number="+opt.getProduct_number());
		}
	}
	
	@RequestMapping("optList")
	public ModelAndView adminOptList(Integer pageNum, String query, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if(query == null || query.equals("")) {
			query = "";
		}
		
		int optCnt = service.getOptCnt(query);
		
		int limit = 10;
		int maxPage = (int)((double)optCnt/limit +0.95);
		int startPage = pageNum-(pageNum-1)%5;
		int endPage = startPage + 4;
		if(endPage > maxPage) endPage = maxPage;
		
		List<ProductOptView> optList =service.getOptList(pageNum, query);
		
		mv.addObject("optList", optList);
		mv.addObject("optCnt", optCnt);
		mv.addObject("pageNum", pageNum);
		mv.addObject("startPage", startPage);
		mv.addObject("endPage", endPage);
		mv.addObject("maxPage", maxPage);
		return mv;
	}
	
	@GetMapping("optDetail")
	public ModelAndView adminOptDetail(Integer opt_number, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		ProductOptView opt = service.getProdOpt(opt_number);
		
		if(opt == null) {
			throw new ShopException("해당 제품은 존재하지 않습니다.", "optList");
		}
		
		mv.addObject("opt",opt);
		return mv;
	}
	
	@GetMapping("optOrder")
	@ResponseBody
	public Map<String,Object> adminOptOrder(Integer opt_number, Integer pageNum, HttpSession session) {
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		
		int optOrderCnt = service.optOrderCnt(opt_number);
		
		int limit = 10;
		int maxPage = (int)((double)optOrderCnt/limit +0.95);
		int startPage = pageNum-(pageNum-1)%5;
		int endPage = startPage + 4;
		if(endPage > maxPage) endPage = maxPage;
		
		List<OrderView> optOrerList =service.getOptOrderList(opt_number, pageNum);
		
		Map<String,Object> map = new HashMap<>();
		map.put("optOrerList", optOrerList);
		map.put("maxPage", maxPage);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		map.put("opt_number", opt_number);
		map.put("pageNum", pageNum);
		
		return map;
	}
	
	@GetMapping("optStock")
	@ResponseBody
	public Map<String,Object> adminOptStock(Integer opt_number, Integer pageNum, HttpSession session) {
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		
		int optStockCnt = service.optStockCnt(opt_number);
		
		int limit = 10;
		int maxPage = (int)((double)optStockCnt/limit +0.95);
		int startPage = pageNum-(pageNum-1)%5;
		int endPage = startPage + 4;
		if(endPage > maxPage) endPage = maxPage;
		
		List<Stock> optStockList =service.getOptStockList(opt_number, pageNum);
		
		Map<String,Object> map = new HashMap<>();
		map.put("optStockList", optStockList);
		map.put("maxPage", maxPage);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		map.put("opt_number", opt_number);
		map.put("pageNum", pageNum);
		
		return map;
	}
	
	@GetMapping("optChg")
	public ModelAndView adminOptChg(Integer opt_number, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		ProductOptView opt = service.getProdOpt(opt_number);
		
		if(opt == null) {
			throw new ShopException("해당 제품은 존재하지 않습니다.", "optList");
		}
		
		mv.addObject("opt",opt);
		return mv;
	}
	
	@PostMapping("optChg")
	public ModelAndView adminOptChg(Opt opt, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		if(service.updateOpt(opt)) {
			mv.setViewName("redirect:optList");
			return mv;
		}else {
			throw new ShopException("옵션 변경 실패", "optList");
		}
	}
	
	@PostMapping("optDel")
	public ModelAndView adminProdDel(Integer opt_number, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		if(service.deleteOpt(opt_number)) {
			mv.setViewName("redirect:optList");
			return mv;
		}else {
			throw new ShopException("옵션 삭제 실패", "optList");
		}
	}
}
