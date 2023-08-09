package service;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import dao.CartDao;
import dao.ChallDao;
import dao.CsDao;
import dao.DeliveryDao;
import dao.MemDao;
import dao.OptDao;
import dao.OrderDao;
import dao.OrderItemDao;
import dao.PointDao;
import dao.ProductDao;
import dao.QnaDao;
import dao.RefundDao;
import dao.ReviewDao;
import dto.Cart;
import dto.Chall;
import dto.Cs;
import dto.Delivery;
import dto.Mem;
import dto.Opt;
import dto.Order;
import dto.OrderItem;
import dto.OrderView;
import dto.Point;
import dto.Product;
import dto.ProductOptView;
import dto.Qna;
import dto.Refund;
import dto.Review;
import dto.ReviewView;
@Service
public class ShopService {
	@Autowired
	private ProductDao productDao;
	
	@Autowired
	private OptDao optDao;
	
	@Autowired
	private CartDao cartDao;
	
	@Autowired
	private MemDao memDao;
	
	@Autowired
	private DeliveryDao deliveryDao;
	
	@Autowired
	private QnaDao qnaDao;
	
	@Autowired
	private OrderDao orderDao;
	
	@Autowired
	private OrderItemDao orderItemDao;
	
	@Autowired
	private CsDao csDao;
	
	@Autowired
	private PointDao pointDao;
	
	@Autowired
	private RefundDao refundDao;
	
	@Autowired
	private ReviewDao reviewDao;
	
	@Autowired
	private ChallDao challDao;

	public List<Product> productList(Integer pageNum, int limit, String product_type, String searchContent) {
		return productDao.list(pageNum, limit, product_type, searchContent);
	}

	public int productCount(String product_type, String searchContent) {
		return productDao.count(product_type, searchContent);
	}

	public Product getProduct(Integer product_number) {
		return productDao.getProduct(product_number);
	}

	public List<Opt> getOption(int product_number) {
		return optDao.getOption(product_number);
	}

	public Opt getOptionByNum(Integer opt_number) {
		return optDao.getOptionByNum(opt_number);
	}

	public boolean addCart(String mem_id, String optionNumber, String optionCount) {
		Cart cart = cartDao.getCart(mem_id, optionNumber);		
		if(cart != null) {
			String ogCount = cart.getOpt_count(); //기존 개수
			cartDao.updateCount(mem_id, optionNumber, optionCount, ogCount);
			return true;
		} else {
			return cartDao.addCart(mem_id, optionNumber, optionCount);
		}
	}

	public List<Cart> getCartList(String mem_id) {
		return cartDao.getCartList(mem_id);
	}

	public ProductOptView getProductOptView(int opt_number) {
		return optDao.getProductOptView(opt_number);
	}

	public boolean userInsert(Mem mem) {
		return memDao.userInsert(mem);
	}

	public Mem getMemEmail(String email) {
		return memDao.getMemEmail(email);
	}

	public int maxMemNum() {
		return memDao.maxMemNum();
	}

	public boolean cartDelete(Integer opt_number, String mem_id) {
		return cartDao.cartDelete(opt_number, mem_id);
	}

	public boolean cartMinus(Integer opt_number, String mem_id) {
		return cartDao.cartMinus(opt_number, mem_id);
	}

	public boolean cartPlus(Integer opt_number, String mem_id) {
		return cartDao.cartPlus(opt_number, mem_id);
	}

	public Cart getCart(String mem_id, Integer opt_number) {
		return cartDao.getCart(mem_id, opt_number);
	}

	public boolean addDelivery(Delivery delivery, String mem_id) {
		return deliveryDao.addDelivery(delivery, mem_id);
	}

	public List<Delivery> getDeliveryList(String mem_id) {
		return deliveryDao.getDeliveryList(mem_id);
	}

	public Delivery getDelivery(Integer selectedOption) {
		return deliveryDao.getDelivery(selectedOption);
	}
	
	public int getQnaCnt(String type) {
		return qnaDao.getQnaCnt(type);
	}
	public List<Qna> getQnaList(Integer pageNum, String type) {
		return qnaDao.getQnaList(pageNum, type);
	}
	public Qna getQna(Integer qna_number) {
		return qnaDao.getQna(qna_number);
	}
	public void addQnaHits(Integer qna_number) {
		qnaDao.addQnaHits(qna_number);
	}

	public String getMaxOrderId() {
		return orderDao.getMaxOrderId();
	}

	public boolean addOrder(String order_id, String deliver_receiver, String mem_id, String delivery_postcode,
			String delivery_address, String delivery_detailAddress, int delivery_cost, int order_point, String phoneno, String order_msg, int order_totalPay) {
		return orderDao.addOrder(order_id, deliver_receiver, mem_id, delivery_postcode, delivery_address, delivery_detailAddress, delivery_cost, order_point, phoneno, order_msg, order_totalPay);
	}

	public boolean addOrderItem(String order_id, Integer opt_number, Integer product_number, String opt_count) {
		return orderItemDao.addOrderItem(order_id, opt_number, product_number, opt_count);
	}

	public List<Order> getOrderList(String mem_id) {
		return orderDao.getOrderList(mem_id);
	}

	public OrderItem getOrderItemList(String order_id) {
		return orderItemDao.getOrderItemList(order_id);
	}

	public List<OrderView> getOv(Integer pageNum, String mem_id) {
		return orderDao.getOv(pageNum, mem_id);
	}

	public List<OrderView> getOvList(String mem_id, String order_id) {
		return orderDao.getOvList(mem_id, order_id);
	}
	
	public int orderCnt(String mem_id) {
		return orderDao.orderCnt(mem_id);
	}

	public boolean csReg(Cs cs) {
		return csDao.csReg(cs);
	}

	public void pointInsert(String mem_id) {
		pointDao.pointInsert(mem_id);		
	}

	public void usePoint(int order_point, String mem_id) {
		memDao.usePoint(order_point, mem_id);
	}

	public boolean deleteD(Integer delivery_number) {
		return deliveryDao.deleteD(delivery_number);
	}

	public boolean newD(Delivery delivery, String mem_id) {
		return deliveryDao.newD(delivery, mem_id);
	}

	public void addRefund(String order_id, int optId, String mem_id, int price) {
		refundDao.addRefund(order_id, optId, mem_id, price);
	}

	public void updateOrderState(String order_id, String order_state) {
		orderDao.updateOrderState(order_id, order_state);
	}

	public List<Refund> getRefundList(String mem_id) {
		return refundDao.getRefundList(mem_id);
	}

	public List<Refund> getRefundCancelList(String mem_id, String refund_type) {
		return refundDao.getRefundCancelList(mem_id, refund_type);
	}

	public List<Cs> getCs(String mem_id) {
		return csDao.getCs(mem_id);
	}

	public Cs getCsDetail(Integer cs_number) {
		return csDao.getCsDetail(cs_number);
	}

	public OrderView getOvIdNum(String order_id, Integer opt_number) {
		return orderDao.getOvIdNum(order_id, opt_number);
	}

	public boolean refundInsert(String order_id, Integer opt_number, Integer opt_count, String refund_memId, String refund_reason, int price) {
		return refundDao.refundInsert(order_id, opt_number, opt_count, refund_memId, refund_reason, price);
	}

	public List<Refund> getRefundListOrderId(String order_id) {
		return refundDao.getRefundListOrderId(order_id);
	}

	public void deleteOrder(String order_id) {
		orderDao.deleteOrder(order_id);
	}

	public boolean updateQ(int refund_optId, int refund_optCount) {
		return optDao.updateQ(refund_optId, refund_optCount);
	}

	public List<Refund> getRefund(String order_id, Integer opt_number) {
		return refundDao.getRefund(order_id, opt_number);
	}

	public List<Refund> getRefundListAll(String mem_id, String string) {
		return refundDao.getRefundListAll(mem_id, string);
	}

	public List<OrderView> getOvDelivered(String mem_id, String order_state) {
		return orderDao.getOvDelivered(mem_id, order_state);
	}

	public boolean addReview(Integer order_itemId, int review_value, String review_content, String mem_id) {
		return reviewDao.addReview(order_itemId, review_value, review_content, mem_id);
	}

	public List<Review> getMyReview(String mem_id) {
		return reviewDao.getMyReview(mem_id);
	}

	public OrderView getOvItemId(int order_itemId) {
		return orderDao.getOvItemId(order_itemId);
	}

	public Review getReviewNum(Integer review_number) {
		return reviewDao.getReivewNum(review_number);
	}

	public boolean updateReview(Integer review_number, int review_value, String review_content) {
		return reviewDao.updateReview(review_number, review_value, review_content);
	}

	public Review getReviewIsWritten(Integer order_itemId, String mem_id) {
		return reviewDao.getReviewIsWritten(order_itemId, mem_id);
	}

	public List<OrderView> getOvProductNum(int product_number) {
		return orderDao.getOvProductNum(product_number);
	}

	public Review getReviewOrderId(int order_itemId) {
		return reviewDao.getReviewOrderId(order_itemId);
	}

	public Review getReviewOrderIdPaging(int order_itemId, int i, int j) {
		return reviewDao.getReviewOrderIdPaging(order_itemId, i, j);
	}

	public List<ReviewView> getReviewProNum(Integer product_number) {
		return reviewDao.getReviewProNum(product_number);
	}

	public List<Product> productListAll() {
		return productDao.productListAll();
	}

	public void pointUsedStore(Integer order_point, String mem_id) {
		pointDao.pointUsedStore(order_point, mem_id);
	}

	public boolean deleteReview(Integer review_number) {
		return reviewDao.deleteReview(review_number);
	}

	public List<ReviewView> getReviewList(int product_number, int startIndex, int pageSize) {
		return reviewDao.getReviewList(product_number, startIndex, pageSize);
	}

	public boolean updateMem(Mem mem) {
		return memDao.updateMem(mem);
	}

	public boolean deleteMem(String mem_id) {
		return memDao.deleteMem(mem_id);
	}

	public boolean updatePw(String email, String mem_pw) {
		return memDao.updatePw(email, mem_pw);
	}

	public Order getOrder(String order_id) {
		return orderDao.getOrder(order_id);
	}

	public void addCancel(String order_id, String mem_id, int order_totalPay) {
		refundDao.addCancel(order_id, mem_id, order_totalPay);
	}

	@Transactional
	public void pointBack(String mem_id, int order_point) {
		memDao.pointBack(mem_id, order_point);
		pointDao.pointBack(mem_id, order_point);
	}

	public List<OrderView> getOvOi(String order_id) {
		return orderDao.getOvOi(order_id);
	}

	public boolean regChall(Chall chall, HttpServletRequest request) {
		String thumbPath = request.getServletContext().getRealPath("/") + "img/chall/";
		if(chall.getThumbFile() != null && !chall.getThumbFile().isEmpty()) {
			uploadFileCreate(chall.getThumbFile(), thumbPath);
		}
		int maxNum = challDao.maxNum();
		chall.setChall_number(maxNum+1);
		int cnt = challDao.challCnt(chall.getMem_id());
		chall.setChall_cnt(cnt+1);
		return challDao.regChall(chall);
	}
	
	public void uploadFileCreate(MultipartFile file, String path) {
		String orgFile = file.getOriginalFilename();
		File f = new File(path);
		if(!f.exists()) f.mkdirs();
		try {
			file.transferTo(new File(path+orgFile));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int getChallCnt() {
		return challDao.getChallCnt();
	}

	public List<Chall> getChallList(Integer pageNum) {
		return challDao.getChallList(pageNum);
	}

	public Chall getChall(String mem_id, String chall_regdate) {
		return challDao.getChall(mem_id, chall_regdate);
	}

	public Chall getMyChall(String mem_id) {
		return challDao.getMyChall(mem_id);
	}

	public int pointCnt(String point_type, String mem_id) {
		return pointDao.pointCnt(point_type, mem_id);
	}

	public List<Point> getPointList(Integer pageNum, String mem_id, String point_type) {
		return pointDao.getPointList(pageNum, mem_id, point_type);
	}

	public List<Chall> getMyChallList(Integer pageNum, String mem_id) {
		return challDao.getMyChallList(pageNum, mem_id);
	}

	public List<Chall> getMyChallListState(Integer pageNum, String mem_id, String chall_state) {
		return challDao.getMyChallListState(pageNum, mem_id, chall_state);
	}

	public boolean deleteChall(Integer chall_number) {
		return challDao.deleteChall(chall_number);
	}

	public int myChallCnt(String chall_state, String mem_id) {
		return challDao.myChallCnt(chall_state, mem_id);
	}

}
