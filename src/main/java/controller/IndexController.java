package controller;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dto.Cs;
import dto.Mem;
import dto.Product;
import exception.ShopException;
import service.ShopService;

@Controller
@RequestMapping("/*")
public class IndexController {
	
	@Autowired
	private ShopService service;
	
    @RequestMapping("/index")
    public ModelAndView root() {
    	ModelAndView mav = new ModelAndView();
    	List<Product> productList = service.productListAll();
    	Collections.sort(productList, (p1, p2) -> {
    	    int size1 = service.getOvProductNum(p1.getProduct_number()).size();
    	    int size2 = service.getOvProductNum(p2.getProduct_number()).size();
    	    return size2 - size1;
    	});

    	List<Product> top4Products = productList.subList(0, Math.min(productList.size(), 4));
    	mav.addObject("top4Products", top4Products);
    	mav.setViewName("main");
        return mav;
    }
    
    @RequestMapping("/qna")
    public String qna() {
        return "qna";
    }
    
    @GetMapping("/cs")
    public ModelAndView cs(HttpSession session) {
    	ModelAndView mv = new ModelAndView();
    	Mem loginMem = (Mem) session.getAttribute("loginMem");
    	mv.addObject("loginMem", loginMem);
        return mv;
    }
    
    @PostMapping("/csQ")
    public ModelAndView csQ(Cs cs,HttpSession session){
    	ModelAndView mv = new ModelAndView();
    	if(service.csReg(cs)) {
    		mv.setViewName("redirect:mypage/cs?mem_id="+cs.getMem_id());
			return mv;
		}else {
			throw new ShopException("문의 내용 전송 실패", "cs");
		}
    }
    
}
