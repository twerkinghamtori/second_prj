package admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import admin.service.AdminOrderService;
import admin.service.AdminShopService;
import dto.Order;
import dto.OrderView;
import exception.ShopException;

@Controller
@RequestMapping("admin/order")
public class AdminOrderController {

	@Autowired
	private AdminOrderService service;
	@Autowired
	private AdminShopService service2;

	@RequestMapping("orderStateList")
	@ResponseBody
	public List<Order> adminOrderStateList(Integer pageNum, String f, String query, String sd, String ed, String order_state, HttpSession session){
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if(f == null || f.equals("")) {
			f = "order_id";
		}
		if(query == null || query.equals("")) {
			query = "";
		}
		if (sd == null || sd.equals("")) {
			sd = "";
		}
		if (ed == null || ed.equals("")) {
			ed="";
		}
		if (order_state == null || order_state.equals("")) {
			order_state="";
		}

		List<Order> orderList =service.getOrderList(pageNum, f, query, sd, ed, order_state);
		return orderList;
	}

	@RequestMapping("orderDetail")
	@ResponseBody
	public Map<String, Object> adminOrderDetail(String order_id, HttpSession session){
		Map<String, Object> map = new HashMap<>();
		Order order = service.getOrder(order_id);
		List<OrderView> orderItem = service.getOrderItem(order_id);

		map.put("order", order);
		map.put("orderItem", orderItem);
		return map;
	}

	@RequestMapping("orderList")
	public ModelAndView adminOrderList(Integer pageNum, String f, String query, String sd, String ed, String order_state, HttpSession session) {
		ModelAndView mv = new ModelAndView();

		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if(f == null || f.equals("")) {
			f = "order_id";
		}
		if(query == null || query.equals("")) {
			query = "";
		}
		if (sd == null || sd.equals("")) {
			sd = "";
		}
		if (ed == null || ed.equals("")) {
			ed="";
		}
		if (order_state == null || order_state.equals("")) {
			order_state="";
		}

		int orderCnt = service.orderCnt(f, query, sd, ed, order_state);

		int limit = 10;
		int maxPage = (int)((double)orderCnt/limit +0.95);
		int startPage = pageNum-(pageNum-1)%5;
		int endPage = startPage + 4;
		if(endPage > maxPage) endPage = maxPage;

		List<Order> orderList =service.getOrderList(pageNum, f, query, sd, ed, order_state);

		mv.addObject("orderCnt", orderCnt);
		mv.addObject("orderList", orderList);
		mv.addObject("pageNum", pageNum);
		mv.addObject("startPage", startPage);
		mv.addObject("endPage", endPage);
		mv.addObject("maxPage", maxPage);
		mv.addObject("sd", sd);
		mv.addObject("ed", ed);
		mv.addObject("order_state", order_state);
		return mv;
	}

	@PostMapping("orderStateChg")
	@ResponseBody
	public void adminOrderStateChg(@RequestParam("order_id") String order_id, @RequestParam("order_state") String order_state, HttpSession session) {
		String state = "";
		
		if(order_state.equals("결제완료")) {
			state = "상품준비";
		}else if(order_state.equals("상품준비")) {
			state = "배송준비";
		}else if(order_state.equals("배송준비")) {
			state = "배송중";
		}else if(order_state.equals("배송중")) {
			state = "배송완료";
			List<OrderView> orderItem = service.getOrderItem(order_id);
			for(OrderView o : orderItem) {
				int opt_number = o.getOpt_number();
				int diffQuantity = Integer.parseInt(o.getOpt_count());
				if(!service2.diffQuantity(opt_number, diffQuantity)) {
					throw new ShopException("배송완료 실패", "orderList");
				}
			}
		}

		service.orderStateChg(order_id, state);
	}

}
