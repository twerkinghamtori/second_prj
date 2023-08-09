package admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import admin.service.AdminShopService;
import dto.Product;
import exception.ShopException;

@Controller
@RequestMapping("admin/product")
public class AdminProductController {
	
	@Autowired
	private AdminShopService service;
	
	@GetMapping("prodReg")
	public ModelAndView adminRegForm(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		mv.addObject(new Product());
		return mv;
	}
	
	@PostMapping("prodReg")
	public ModelAndView adminRegProduct(Product product, HttpServletRequest request, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		if(service.regProduct(product, request)) {
			mv.setViewName("redirect:prodList");
			return mv;
		}else {
			throw new ShopException("제품 등록 실패", "prodList");
		}
	}
	
	@GetMapping("prod{uri}")
	public ModelAndView adminProd(Integer product_number, @PathVariable String uri, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		Product product = service.getProd(product_number);
		
		if(product == null) {
			throw new ShopException("해당 제품은 존재하지 않습니다.", "prodList");
		}
		
		if(uri.equals("Detail")) {
			String[] prodPics = product.getProduct_pictures().split(",");
			mv.addObject("prodPics",prodPics);
		}
		mv.addObject("product",product);
		return mv;
	}
	
	@PostMapping("prodChg")
	public ModelAndView adminProdChg(Product product, @RequestParam("product_pictures") String product_pictures,HttpServletRequest request, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		if(product.getPicFiles().get(0).getOriginalFilename().equals("")) {
			product.setProduct_pictures(product_pictures);
		}
		if(service.updateProduct(product, request)) {
			mv.setViewName("redirect:prodList");
			return mv;
		}else {
			throw new ShopException("제품 변경 실패", "prodList");
		}
	}
	
	@PostMapping("prodDel")
	public ModelAndView adminProdDel(Integer product_number, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		if(service.deleteProduct(product_number)) {
			mv.setViewName("redirect:prodList");
			return mv;
		}else {
			throw new ShopException("제품 삭제 실패", "prodList");
		}
	}
	
	@RequestMapping("prodList")
	public ModelAndView adminProdList(Integer pageNum, String query, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if(query == null || query.equals("")) {
			query = "";
		}
		
		int prodCnt = service.getProdCnt(query);
		
		int limit = 10;
		int maxPage = (int)((double)prodCnt/limit +0.95);
		int startPage = pageNum-(pageNum-1)%5;
		int endPage = startPage + 4;
		if(endPage > maxPage) endPage = maxPage;
		
		List<Product> prodList =service.getProdList(pageNum, query);
		
		mv.addObject("prodList", prodList);
		mv.addObject("prodCnt", prodCnt);
		mv.addObject("pageNum", pageNum);
		mv.addObject("startPage", startPage);
		mv.addObject("endPage", endPage);
		mv.addObject("maxPage", maxPage);
		return mv;
	}
	
	@RequestMapping("imgupload")
	public String imgupload(MultipartFile upload, String CKEditorFuncNum, HttpServletRequest request, Model model) {
		String path=request.getServletContext().getRealPath("/")+"/upload/imgfile/";
		service.uploadFileCreate(upload, path);
		String fileName = request.getContextPath()+"/upload/imgfile/" + upload.getOriginalFilename();
		model.addAttribute("fileName", fileName);
		return "ckedit";
	}
}
