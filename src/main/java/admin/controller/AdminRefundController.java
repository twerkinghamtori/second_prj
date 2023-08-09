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
import dto.CancelBuy;
import dto.Order;
import dto.RefundView;
import service.IamPortService;

@Controller
@RequestMapping("admin/refund")
public class AdminRefundController {

	@Autowired
	private AdminOrderService service;
	
	@Autowired
	private IamPortService iamService;

	@RequestMapping("refundTypeList")
	@ResponseBody
	public List<RefundView> adminRefundTypeList(Integer pageNum, String f, String query, String sd, String ed, String refund_type, HttpSession session){
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if(f == null || f.equals("")) {
			f = "refund_orderId";
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
		if (refund_type == null || refund_type.equals("")) {
			refund_type="";
		}

		List<RefundView> refundList =service.getRefundList(pageNum, f, query, sd, ed, refund_type);
		return refundList;
	}

	@RequestMapping("refundDetail")
	@ResponseBody
	public Map<String, Object> adminRefundDetail(String refund_number, HttpSession session){
		Map<String, Object> map = new HashMap<>();
		RefundView refund = service.getRefund(refund_number);

		map.put("refund", refund);
		return map;
	}

	@RequestMapping("refundList")
	public ModelAndView adminRefundList(Integer pageNum, String f, String query, String sd, String ed, String refund_type, HttpSession session) {
		ModelAndView mv = new ModelAndView();

		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if(f == null || f.equals("")) {
			f = "refund_orderId";
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
		if (refund_type == null || refund_type.equals("")) {
			refund_type="";
		}

		int refundCnt = service.refundCnt(f, query, sd, ed, refund_type);

		int limit = 10;
		int maxPage = (int)((double)refundCnt/limit +0.95);
		int startPage = pageNum-(pageNum-1)%5;
		int endPage = startPage + 4;
		if(endPage > maxPage) endPage = maxPage;

		List<RefundView> refundList =service.getRefundList(pageNum, f, query, sd, ed, refund_type);

		mv.addObject("refundCnt", refundCnt);
		mv.addObject("refundList", refundList);
		mv.addObject("pageNum", pageNum);
		mv.addObject("startPage", startPage);
		mv.addObject("endPage", endPage);
		mv.addObject("maxPage", maxPage);
		mv.addObject("sd", sd);
		mv.addObject("ed", ed);
		mv.addObject("refund_type", refund_type);
		return mv;
	}

	@PostMapping("refundComp")
	@ResponseBody
	public void adminRefundCompChg(@RequestParam("refund_number") String refund_number, @RequestParam("refund_type") String refund_type, 
			@RequestParam("refund_orderId") String refund_orderId, @RequestParam("refund_price") Integer refund_price, HttpSession session) {
		try {
			String type = "";		
			//결제 취소 실패 시 메세지 보냄
			Order order = service.getOrder(refund_orderId);
			int usedPoint = order.getOrder_point();
			int totalPay = order.getOrder_totalPay();
			int refundPoint = 0;
			if(refund_type.equals("환불대기")) {				
					if(totalPay<refund_price) {
						if(refund_price > usedPoint) {
							refund_price = refund_price - usedPoint;
							refundPoint = usedPoint;
						} else {
							refundPoint = refund_price;
							refund_price = 0;										
						}
					}				
					CancelBuy cancel = iamService.cancelBuy(refund_orderId, refund_price);
					type = "환불완료";
					service.refundComp(refund_number, type);
					RefundView refund = service.getRefund(refund_number);
					if(refundPoint != 0) service.pointBack(refund.getRefund_memId(), refundPoint);	
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}					
	}
	
	@PostMapping("refundBack")
	@ResponseBody
	public void adminRefundBackChg(@RequestParam("refund_number") String refund_number, @RequestParam("refund_type") String refund_type, HttpSession session) {
		String type = "";
		
		if(refund_type.equals("환불대기")) {
			type = "환불반려";
			service.refundBack(refund_number, type);
		}
	}
	
}
