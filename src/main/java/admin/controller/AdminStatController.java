package admin.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import admin.service.AdminManageService;
import dto.StatSale;

@Controller
@RequestMapping("admin/stat")
public class AdminStatController {

	@Autowired
	private AdminManageService service;

	@RequestMapping("sale")
	public ModelAndView adminSaleList(Integer pageNum, String sd, String ed, HttpSession session) {
		ModelAndView mv = new ModelAndView();

		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if (sd == null || sd.equals("")) {
			sd = "";
		}
		if (ed == null || ed.equals("")) {
			ed = "";
		}

		int statCnt = service.statCnt(sd, ed);

		int limit = 10;
		int maxPage = (int)((double)statCnt/limit +0.95);
		int startPage = pageNum-(pageNum-1)%5;
		int endPage = startPage + 4;
		if(endPage > maxPage) endPage = maxPage;

		List<StatSale> statSaleList =service.getStatSaleList(pageNum, sd, ed);

		if(!sd.equals("") && !ed.equals("")) {
			try {
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				Date startDate = dateFormat.parse(sd);
				Date endDate = dateFormat.parse(ed);

				long diff = endDate.getTime() - startDate.getTime();
				int diffDay = ((int)diff / (24 * 60 * 60 * 1000)) +1; 

				int sumSale = 0;
				int sumCancel = 0;
				int sumRefund = 0;
				for(StatSale s : statSaleList) {
					sumSale += s.getOrder_pay();
					sumCancel += s.getOrderCancel_pay();
					sumRefund += s.getRefund_pay();
				}
				int avgSale = sumSale/diffDay;
				int avgCancel = sumCancel/diffDay;
				int avgRefund = sumRefund/diffDay;
				
				mv.addObject("sumSale", sumSale);
				mv.addObject("sumCancel", sumCancel);
				mv.addObject("sumRefund", sumRefund);
				mv.addObject("avgSale", avgSale);
				mv.addObject("avgCancel", avgCancel);
				mv.addObject("avgRefund", avgRefund);

			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		mv.addObject("statSaleList", statSaleList);
		System.out.println(statSaleList);
		mv.addObject("statCnt", statCnt);
		mv.addObject("pageNum", pageNum);
		mv.addObject("startPage", startPage);
		mv.addObject("endPage", endPage);
		mv.addObject("maxPage", maxPage);
		mv.addObject("sd", sd);
		mv.addObject("ed", ed);
		return mv;
	}
}
