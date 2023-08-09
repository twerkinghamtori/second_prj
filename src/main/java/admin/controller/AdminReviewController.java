package admin.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import admin.service.AdminManageService;
import dto.ReviewView;
import exception.ShopException;

@Controller
@RequestMapping("admin/review")
public class AdminReviewController {

	@Autowired
	private AdminManageService service;
	
	@RequestMapping("reviewList")
	public ModelAndView adminReviewList(Integer pageNum, String f, String query, String sd, String ed, String review_state, HttpSession session) {
		ModelAndView mv = new ModelAndView();

		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if(f == null || f.equals("")) {
			f = "product_name";
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
		if (review_state == null || review_state.equals("")) {
			review_state="";
		}

		int reviewCnt = service.reviewCnt(f, query, sd, ed, review_state);

		int limit = 10;
		int maxPage = (int)((double)reviewCnt/limit +0.95);
		int startPage = pageNum-(pageNum-1)%5;
		int endPage = startPage + 4;
		if(endPage > maxPage) endPage = maxPage;

		List<ReviewView> reviewList =service.getReviewList(pageNum, f, query, sd, ed, review_state);

		mv.addObject("reviewCnt", reviewCnt);
		mv.addObject("reviewList", reviewList);
		mv.addObject("pageNum", pageNum);
		mv.addObject("startPage", startPage);
		mv.addObject("endPage", endPage);
		mv.addObject("maxPage", maxPage);
		mv.addObject("sd", sd);
		mv.addObject("ed", ed);
		mv.addObject("review_state", review_state);
		return mv;
	}
	
	@RequestMapping("reviewDetail")
	public ModelAndView adminReviewDetail(Integer review_number, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		ReviewView review = service.getReview(review_number);
		
		if(review == null) {
			throw new ShopException("해당 리뷰는 존재하지 않습니다.", "reviewList");
		}
		mv.addObject("review", review);
		return mv;
	}
	
	@RequestMapping("reviewStateChg")
	public ModelAndView adminReviewStateChg(Integer review_number, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		ReviewView review = service.getReview(review_number);
		
		if(service.reviewStateChg(review)) {
			mv.setViewName("redirect:reviewDetail?review_number="+review_number);
			return mv;
		}else {
			throw new ShopException("리뷰 포인트 지급 실패", "reviewDetail?review_number="+review_number);
		}
	}
	
	@PostMapping("reviewDel")
	public ModelAndView managerReviewDel(Integer review_number, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		if(service.reviewDel(review_number)) {
			mv.setViewName("redirect:reviewList");
			return mv;
		}else {
			throw new ShopException("리뷰 삭제 실패", "reviewDetail?review_number="+review_number);
		}
	}
	
}
