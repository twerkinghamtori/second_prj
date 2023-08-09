package admin.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import admin.dao.AdminChallDao;
import admin.dao.AdminCsDao;
import admin.dao.AdminManagerDao;
import admin.dao.AdminMemDao;
import admin.dao.AdminOrderDao;
import admin.dao.AdminPointDao;
import admin.dao.AdminQnaDao;
import admin.dao.AdminRefundDao;
import admin.dao.AdminReviewDao;
import admin.dao.AdminStatDao;
import dto.Chall;
import dto.Cs;
import dto.Delivery;
import dto.Manager;
import dto.Mem;
import dto.Point;
import dto.Qna;
import dto.ReviewView;
import dto.StatSale;

@Service
public class AdminManageService {

	@Autowired
	private AdminQnaDao qnaDao;
	@Autowired
	private AdminCsDao csDao;
	@Autowired
	private AdminManagerDao managerDao;
	@Autowired
	private AdminMemDao memDao;
	@Autowired
	private AdminPointDao pointDao;
	@Autowired
	private AdminReviewDao reviewDao;
	@Autowired
	private AdminOrderDao orderDao;
	@Autowired
	private AdminRefundDao refundDao;
	@Autowired
	private AdminStatDao statDao;
	@Autowired
	private AdminChallDao challDao;

	public boolean regQna(Qna qna) {
		return qnaDao.regQna(qna);
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

	public void qnaChg(Qna qna) {
		qnaDao.qnaChg(qna);
	}

	public void qnaDel(Integer qna_number) {
		qnaDao.qnaDel(qna_number);
	}

	public boolean managerReg(Manager manager) {
		return managerDao.managerReg(manager);
	}

	public int managerCnt(String f, String query) {
		return managerDao.managerCnt(f, query);
	}

	public List<Manager> getManagerList(Integer pageNum, String f, String query) {
		return managerDao.getManagerList(pageNum, f, query);
	}

	public Manager getManager(String manager_id) {
		return managerDao.getManager(manager_id);
	}

	public Manager getManager2(String manager_name) {
		return managerDao.getManager2(manager_name);
	}

	public Manager managerLogin(String manager_id, String manager_pass) {
		return managerDao.managerLogin(manager_id, manager_pass);
	}

	public boolean managerChg(Manager manager) {
		return managerDao.managerChg(manager);
	}

	public boolean managerDel(Integer manager_number) {
		return managerDao.managerDel(manager_number);
	}

	public int memCnt(String f, String query) {
		return memDao.memCnt(f, query);
	}

	public List<Mem> getMemList(Integer pageNum, String f, String query) {
		return memDao.getMemList(pageNum, f, query);
	}

	public Mem getMem(Integer mem_number) {
		return memDao.getMem(mem_number);
	}

	public List<Delivery> getDelList(String mem_id) {
		return memDao.getDelList(mem_id);
	}

	public boolean memDel(Integer mem_number) {
		return memDao.memDel(mem_number);
	}

	public int csCnt(String sd, String ed, String query, String cs_state) {
		return csDao.csCnt(sd, ed, query, cs_state);
	}

	public List<Cs> getCsList(Integer pageNum, String sd, String ed, String query, String cs_state) {
		return csDao.getCsList(pageNum, sd, ed, query, cs_state);
	}

	public Cs getCs(Integer cs_number) {
		return csDao.getCs(cs_number);
	}

	public boolean csReply(Cs cs) {
		return csDao.csReply(cs);
	}

	public boolean csDel(Integer cs_number) {
		return csDao.csDel(cs_number);
	}

	@Transactional
	public boolean regPoint(Point point) {
		boolean b1 = pointDao.regPoint(point);
		boolean b2 = memDao.pointChg(point);
		return b1&&b2;
	}

	public int getPointCnt(String query) {
		return pointDao.getPointCnt(query);
	}

	public List<Point> getPointList(Integer pageNum, String query) {
		return pointDao.getPointList(pageNum, query);
	}

	public Point getPoint(Integer point_number) {
		return pointDao.getPoint(point_number);
	}

	public boolean pointDel(Integer point_number) {
		return pointDao.pointDel(point_number);
	}

	public int reviewCnt(String f, String query, String sd, String ed, String review_state) {
		return reviewDao.reviewCnt(f, query, sd, ed, review_state);
	}

	public List<ReviewView> getReviewList(Integer pageNum, String f, String query, String sd, String ed,
			String review_state) {
		return reviewDao.getReviewList(pageNum, f, query, sd, ed, review_state);
	}

	public ReviewView getReview(Integer review_number) {
		return reviewDao.getReview(review_number);
	}

	@Transactional
	public boolean reviewStateChg(ReviewView review) {
		Point point = new Point();
		point.setMem_id(review.getMem_id());
		point.setPoint_type("리뷰 작성으로인한 포인트 지급");
		point.setPoint_value(500);
		boolean b1 = pointDao.regPoint(point);
		boolean b2 = reviewDao.reviewStateChg(review.getReview_number());
		boolean b3 = memDao.pointChg(point);

		return b1 && b2 && b3;
	}

	public boolean reviewDel(Integer review_number) {
		return reviewDao.reviewDel(review_number);
	}

	@Transactional
	public Map<String, Object> salesList(LocalDate date) {
		Map<String, Object> map = new HashMap<>();
		Map<String, Object> map1 = orderDao.orderPay(date);
		Map<String, Object> map2 = orderDao.cancelPay(date);
		Map<String, Object> map3 = refundDao.refundPay(date);

		String formattedDate = date.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

		map.put("date", formattedDate);
		if(map1.get("주문 금액") != null) {
			map.put("saleAmount", map1.get("주문 금액"));
		}else {
			map.put("saleAmount", 0);
		}
		map.put("saleCnt", map1.get("주문 건 수"));

		if(map2.get("취소 금액") != null) {
			map.put("cancelAmount", map2.get("취소 금액"));
		}else {
			map.put("cancelAmount", 0);
		}
		map.put("cancelCnt", map2.get("취소 건 수"));

		if(map3.get("환불 금액") != null) {
			map.put("backAmount", map3.get("환불 금액"));
		}else {
			map.put("backAmount", 0);
		}
		map.put("backCnt", map3.get("환불 건 수"));

		return map;
	}

	public Map<String, Object> orderState() {
		List<String> orderStates = Arrays.asList("결제완료", "상품준비", "배송준비", "배송중", "배송완료", "구매확정", "주문취소");

		List<Map<String, Object>> list = orderDao.orderState(); // DB에서 조회한 주문 상태별 건수 리스트

		// 주문 상태별 건수를 담을 맵 생성
		Map<String, Object> resultMap = new HashMap<>();

		// 주문 상태별 건수 리스트를 맵에 추가
		for (Map<String, Object> map : list) {
			String state = (String) map.get("state");
			Integer cnt = Integer.parseInt(map.get("cnt").toString());
			resultMap.put(state, cnt);
		}

		// 주문 상태 목록에 있는 상태 중 맵에 없는 상태는 0으로 설정하여 맵에 추가
		for (String state : orderStates) {
			if (!resultMap.containsKey(state)) {
				resultMap.put(state, 0);
			}
		}
		
		Integer refundCnt = refundDao.refundTodayCnt();
		resultMap.put("환불", refundCnt);
		
		Integer csCnt = csDao.csTodayCnt();
		resultMap.put("문의", csCnt);
		
		return resultMap;
	}

	public int statCnt(String sd, String ed) {
		return statDao.statCnt(sd, ed);
	}

	public List<StatSale> getStatSaleList(Integer pageNum, String sd, String ed) {
		return statDao.getStatSaleList(pageNum, sd, ed);
	}

	public int challCnt(String query, String sd, String ed, String chall_state) {
		return challDao.challCnt(query, sd, ed, chall_state);
	}

	public List<Chall> getChallList(Integer pageNum, String query, String sd, String ed, String chall_state) {
		return challDao.getChallList(pageNum, query, sd, ed, chall_state);
	}

	@Transactional
	public boolean payPoint(Integer chall_number, String mem_id, Integer chall_cnt) {
		Point point = new Point();
		point.setMem_id(mem_id);
		if(chall_cnt%100==0 && chall_cnt >=100) {
			point.setPoint_value(1000);
			point.setPoint_type("챌린지 이벤트 참여 100n일차 달성!!");
		}else {
			point.setPoint_value(100);
			point.setPoint_type("챌린지 이벤트 참여");
		}
		boolean b1 = memDao.pointChg(point);
		boolean b2 = pointDao.regPoint(point);
		boolean b3 = challDao.stateChg(chall_number);
		return b1&&b2&&b3;
	}

	public boolean challDel(Integer chall_number) {
		return challDao.challDel(chall_number);
	}

	public boolean memChg(Mem mem) {
		return memDao.memChg(mem);
	}
}
