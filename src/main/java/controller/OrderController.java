package controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dto.Mem;
import dto.ProductOptView;
import exception.ShopException;
import service.ShopService;

@Controller
@RequestMapping("order")
public class OrderController {
	@Autowired
	private ShopService service;
	
	@RequestMapping("orderConfiguration")
	public ModelAndView idCheckorderConfiguration(Mem mem, String deliver_receiver, String delivery_postcode, 
			String delivery_address, String delivery_detailAddress, String receiver_phoneNo1, 
			String receiver_phoneNo2, String receiver_phoneNo3, String order_msg, String order_msgSelf, Integer order_totalPay, Integer order_point, Integer delivery_cost,
			Integer[] opt_number, Integer[] product_number, String[] opt_count, ProductOptView pov, String mem_id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if(order_point == null) order_point = 0;
		if(delivery_cost == null) delivery_cost=0;
		//배송정보
		// 주문번호 생성
		LocalDate today = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMdd");
		String formattedDate = today.format(formatter);
		String order_id = "";
		if (service.getMaxOrderId().equals("1"))
			order_id = formattedDate + "0001";
		else {
			int num = Integer.parseInt(service.getMaxOrderId().substring(6));
			if(num == 9999) num=1;
			String formattedNumber = String.format("%04d", num + 1);
			order_id = formattedDate + formattedNumber;
		}
		String phoneno = receiver_phoneNo1 + receiver_phoneNo2 + receiver_phoneNo3;
		String orderMsg = order_msg;
		order_totalPay = order_totalPay - order_point;
		if(order_msg.equals("직접입력")) orderMsg=order_msgSelf;
		if(service.addOrder(order_id, deliver_receiver, mem.getMem_id(), delivery_postcode, delivery_address, delivery_detailAddress,
				delivery_cost, order_point, phoneno, orderMsg, order_totalPay)) {
			if(order_point != 0) {
				service.usePoint(order_point, mem.getMem_id());
				service.pointUsedStore(order_point, mem.getMem_id());
			}		
			
		} else {
			throw new ShopException("죄송합니다. 주문 시 오류가 발생했습니다.", "/second_prj/cart/cartAdd");
		}
		//주문 제품 정보
		for(int i=0; i<opt_number.length; i++) {
			if(service.addOrderItem(order_id, opt_number[i], product_number[i], opt_count[i])) {
//				System.out.println("주문정보 저장 성공");
			} else {
				throw new ShopException("죄송합니다. 주문 시 오류가 발생했습니다.", "/second_prj/cart/cartAdd");
			}
		}
		mav.addObject("order_id", order_id);
		Mem newMem = service.getMemEmail(mem_id);
		session.setAttribute("loginMem", newMem);
		return mav;
	}
	
//	@GetMapping("orderConfiguration")
//	public ModelAndView orderConfiguration(String order_id) {
//		ModelAndView mav = new ModelAndView();
//		mav.addObject("order_id", order_id);
//		return mav;
//	}
}
