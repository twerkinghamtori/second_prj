package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import dto.Qna;
import service.ShopService;

@RestController
@RequestMapping("qna")
public class QnaRestController {
	
	@Autowired
	private ShopService service;

	@GetMapping("qnaList")
	public Map<String, Object> qnaList(Integer pageNum, String type, HttpSession session){
		Map<String, Object> map = new HashMap<>();
		
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if(type == null || type.equals("") || type.equals("전체")) {
			type = "";
		}
		
		int qnaCnt = service.getQnaCnt(type);
		
		int limit = 10;
		int maxPage = (int)((double)qnaCnt/limit +0.95);
		int startPage = pageNum-(pageNum-1)%5;
		int endPage = startPage + 4;
		if(endPage > maxPage) endPage = maxPage;
		
		List<Qna> qnaList = service.getQnaList(pageNum, type);
		
		map.put("qnaList", qnaList);
		map.put("qnaCnt", qnaCnt);
		map.put("type", type);
		map.put("maxPage", maxPage);
		map.put("endPage", endPage);
		map.put("startPage", startPage);
		map.put("pageNum", pageNum);
		return map;
	}
	
	@GetMapping("qnaDetail")
	public Qna qnaDetail(Integer qna_number) {
		return service.getQna(qna_number);
	}
	
	@PostMapping("qnaHits")
	public Qna qnaHits(Integer qna_number) {
		service.addQnaHits(qna_number);
		return service.getQna(qna_number);
	}
}
