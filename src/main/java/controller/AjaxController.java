package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dto.CancelBuy;
import dto.Cart;
import dto.Cs;
import dto.Delivery;
import dto.Mem;
import dto.Opt;
import dto.Order;
import dto.OrderView;
import dto.Product;
import dto.ProductOptView;
import dto.Refund;
import dto.ReviewView;
import exception.CloseException;
import exception.ShopException;
import service.IamPortService;
import service.ShopService;

@Controller
@RequestMapping("ajax")
public class AjaxController {
	@Autowired
	private ShopService service;
	@Autowired
	private IamPortService iamService;
	
	@RequestMapping("optionSelect")
	public ModelAndView optionSelect(@RequestParam(name = "opt_number") Integer opt_number) {
		ModelAndView mav = new ModelAndView();
		Opt opt = service.getOptionByNum(opt_number);
		Product product = service.getProduct(opt.getProduct_number());
		int product_price = product.getProduct_price();
		int product_discountRate = product.getProduct_discountRate();
		String discountedPrice = Integer.toString(product_price * (100-product_discountRate)/100);
		mav.addObject("opt_number",opt.getOpt_number());
		mav.addObject("opt_name", opt.getOpt_name());
		mav.addObject("discountedPrice",discountedPrice);
		return mav;
	}
	
	@RequestMapping("cartAdd")
	@ResponseBody
	public String cartAdd(@RequestParam(value="opt_number", required=false)String[] opt_number, @RequestParam(value="quantity", required=false)String[] quantity, HttpSession session) {
		Mem loginMem = (Mem) session.getAttribute("loginMem");
		String msg = "";
		if(loginMem == null) {
			msg = "shouldLogin";
			return msg;
		} else {
			String mem_id = loginMem.getMem_id(); 		
			if(opt_number!=null || quantity != null) {
				for(int i=0; i<opt_number.length; i++) {
					String optionNumber = opt_number[i];
					String optionCount = quantity[i];
					if(!service.addCart(mem_id, optionNumber, optionCount)) { //addCart : 장바구니 insert, update
						throw new ShopException("장바구니 등록 시 오류 발생", "../product/productList");
					} 			
				}
			} 
			return msg;
		}		
	}
	
	@RequestMapping("passChk")
	public ModelAndView passChk(String pass, String pass2) {
		ModelAndView mav = new ModelAndView();
		boolean b = true;
		String emptyChk = null;
		String emptyChk2 = null;
		if(pass2==null || pass2.equals("")){
			emptyChk="emptyChk";
		 } else{
			 emptyChk="";
		 }
		if(pass.equals(pass2)) {
			b=true;
		} else {
			b=false;			 
		} 
		mav.addObject("b", b);
		mav.addObject("emptyChk", emptyChk);
		mav.addObject("emptyChk2", emptyChk2);
		mav.setViewName("ajax/passChk");
		return mav;
	}
	@RequestMapping("corrPassChk")
	public ModelAndView corrPassChk(String pass, String pass2) {
		ModelAndView mav = new ModelAndView();
		String pattern = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d).{8,16}$";
		boolean b = true;
		String emptyChk = null;
		if(pass==null || pass.equals("")){
			emptyChk="emptyChk";
		} else {
			 emptyChk="";
		}
		if(pass.matches(pattern)) {
			b=true;
		} else {
			b=false;
		}
		mav.addObject("b", b);
		mav.addObject("emptyChk", emptyChk);
		mav.setViewName("ajax/corrPassChk");
		return mav;
	}
	
	@RequestMapping("cartDelete")
	@ResponseBody
	public String cartDelete(Integer opt_number, HttpSession session) {
		Mem mem = (Mem)session.getAttribute("loginMem");
		String mem_id = mem.getMem_id();
		if(service.cartDelete(opt_number, mem_id)) {
			return "[ajax] 장바구니 삭제 성공";
		} else {
			return "[ajax] 장바구니 삭제 실패";
		}		
	}
	
	@RequestMapping("cartMinus")
	@ResponseBody
	public String cartMinus(Integer opt_number, HttpSession session) {
		Mem mem = (Mem)session.getAttribute("loginMem");
		String mem_id = mem.getMem_id();
		if(service.cartMinus(opt_number, mem_id)) {
			return "[ajax] 장바구니 수량 - 성공";
		} else {
			return "[ajax] 장바구니 수량 - 실패";
		}
		
	}
	
	@RequestMapping("cartPlus")
	@ResponseBody
	public Integer cartPlus(Integer opt_number, Integer opt_count, HttpSession session) {
		Mem mem = (Mem)session.getAttribute("loginMem");
		String mem_id = mem.getMem_id();
		Cart cart = service.getCart(mem_id, opt_number);
		Opt opt = service.getOptionByNum(opt_number);
		if(opt_count < opt.getOpt_quantity()) {
			service.cartPlus(opt_number, mem_id);
		}
		return opt.getOpt_quantity();
	}
	
	@RequestMapping("cartCalculate")
	@ResponseBody
	public Map<String, Object> cartCalculate(@RequestBody String[] optNumbers, HttpSession session) {
	    Map<String, Object> map = new HashMap<>();
	    Mem mem = (Mem)session.getAttribute("loginMem");
	    String mem_id = mem.getMem_id();
	    List<Cart> cartList = new ArrayList<>();
	    for(String i : optNumbers) {
	        cartList.add(service.getCart(mem_id, Integer.parseInt(i)));
	    }
	    int total = 0;
	    int discounted = 0;
	    for(Cart c : cartList) {            
	        ProductOptView pov = service.getProductOptView(c.getOpt_number());
	        total += pov.getProduct_price()* Integer.parseInt(c.getOpt_count());
	        discounted += pov.getProduct_price()* Integer.parseInt(c.getOpt_count()) * ((double)pov.getProduct_discountRate()/100);
	    }
	    map.put("total", total);
	    map.put("discounted", discounted);
	    return map;
	}
	
	@RequestMapping(value = "deliverySave", produces = "text/plain; charset=UTF-8")
	@ResponseBody
	public String deliverySave(Delivery delivery, HttpSession session) {
		String msg = "";
		Mem mem = (Mem) session.getAttribute("loginMem");
		String mem_id = mem.getMem_id();
		if(service.addDelivery(delivery, mem_id)) {
			msg = "배송지가 저장되었습니다.";
		} else {
			msg = "죄송합니다. 배송지 저장에 실패했습니다.";
		}
		return msg;
	}
	
	@RequestMapping("deliverySelect")
	@ResponseBody
	public Delivery deliverySelect(@RequestParam("selectedOption") Integer selectedOption) {
	    Delivery delivery = service.getDelivery(selectedOption);
	    return delivery;
	}
	
	@RequestMapping("orderDetail")
	@ResponseBody
	public List<OrderView> loginCheckorderDetail(String order_id, HttpSession session) {
		Mem mem = (Mem)session.getAttribute("loginMem");
		List<OrderView> orderDetailList = service.getOvList(mem.getMem_id(), order_id);
		return orderDetailList;
	}
	
	@RequestMapping("deleteD")
	@ResponseBody
	public String deleteD(Integer delivery_number) {
		if(service.deleteD(delivery_number)) {
			return "배송지 정보 삭제 성공";
		} else {
			return "배송지 정보 삭제 실패";
		}		
	}
	
	@RequestMapping("newD")
	@ResponseBody
	public String loginChecknewD(Delivery delivery, HttpSession session) {
		Mem sessionMem = (Mem) session.getAttribute("loginMem");
		if(service.newD(delivery, sessionMem.getMem_id())) {
			throw new CloseException("배송지가 추가되었습니다.");
		}
		return "배송지 추가 성공";
	}
	
	@RequestMapping(value="cancelOrder", produces = "text/plain; charset=UTF-8")
	@ResponseBody
	public String loginCheckCancel(String order_id, HttpSession session) {		
		Mem sessionMem = (Mem) session.getAttribute("loginMem");
		Order order = service.getOrder(order_id);
		String msg = "";
		CancelBuy cancel = iamService.cancelBuy(order_id, order.getOrder_totalPay());
		//취소 실패시 cancel msg 보내고 return
		if(cancel.getCode() != "0") {
			msg = cancel.getMessage();
			return msg;
		}
		service.addCancel(order_id, sessionMem.getMem_id(), order.getOrder_totalPay());
		service.updateOrderState(order_id, "주문취소");        
        service.pointBack(order.getMem_id(), order.getOrder_point());
		return "주문이 취소되었습니다. 취소내역은 마이페이지 > 주문 취소 내역에서 확인가능합니다.";
	}
	
	@RequestMapping(value="orderConfig", produces = "text/plain; charset=UTF-8")
	@ResponseBody
	public String loginCheckorderConfig(String order_id, HttpSession session) {
		List<Refund> refundList = service.getRefundListOrderId(order_id);
		if(refundList.size()!=0) {
			return "환불신청 내역이 있는 주문은 구매확정할 수 없습니다.";
		} else {
			service.updateOrderState(order_id, "구매확정");
			return "감사합니다. 주문이 확정되었습니다.";
		}		
	}
	
	@RequestMapping("csDetail")
	@ResponseBody
	public Cs loginCheckcsDetail(Integer cs_number, HttpSession session) {
		Cs cs = service.getCsDetail(cs_number);
		return cs;
	}
	
	@RequestMapping("opt_quantityCheck")
	@ResponseBody
	public Integer QuantityCheck(Integer opt_number, HttpSession session) {
		Opt opt = service.getOptionByNum(opt_number);
		return opt.getOpt_quantity();
	}
	
	@RequestMapping("ov_quantityChk")
	@ResponseBody
	public Integer ov_quantityChk(String order_id, Integer opt_number, HttpSession session) {
		OrderView ov = service.getOvIdNum(order_id, opt_number);
		return Integer.parseInt(ov.getOpt_count());
	}
	
	@RequestMapping("reviewAjax")
	@ResponseBody
	public List<ReviewView> reviewAjax(@RequestParam("pageNum") int pageNum, int product_number) {
		int pageSize = 3; // 한 페이지에 표시되는 리뷰 수
    	int startIndex = (pageNum - 1) * pageSize; // 현재 페이지의 시작 인덱스 계산
		List<ReviewView> reviewList = service.getReviewList(product_number, startIndex, pageSize);
		int maxpage = (int)((double)reviewList.size()/pageSize + 0.95);
		int endpage = startIndex + 2;
		if (endpage > maxpage) endpage = maxpage;
		return reviewList;
	}
	
	@RequestMapping("deleteChall")
	@ResponseBody
	public String deleteChall(Integer chall_number) {
		if(service.deleteChall(chall_number)) {
			return "배송지 정보 삭제 성공";
		} else {
			return "배송지 정보 삭제 실패";
		}		
	}
}
