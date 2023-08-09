package admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import admin.dao.AdminMemDao;
import admin.dao.AdminOptDao;
import admin.dao.AdminOrderDao;
import admin.dao.AdminPointDao;
import admin.dao.AdminRefundDao;
import dto.Order;
import dto.OrderView;
import dto.RefundView;

@Service
public class AdminOrderService {
	
	@Autowired
	private AdminOrderDao orderDao;
	@Autowired
	private AdminRefundDao refundDao;
	@Autowired
	private AdminOptDao optDao;
	@Autowired
	private AdminMemDao memDao;
	@Autowired
	private AdminPointDao pointDao;

	public int orderCnt(String f, String query, String sd, String ed, String order_state) {
		return orderDao.orderCnt(f, query, sd, ed, order_state);
	}

	public List<Order> getOrderList(Integer pageNum, String f, String query, String sd, String ed, String order_state) {
		return orderDao.getOrderList(pageNum, f, query, sd, ed, order_state);
	}

	public Order getOrder(String order_id) {
		return orderDao.getOrder(order_id);
	}

	public List<OrderView> getOrderItem(String order_id) {
		return orderDao.getOrderItem(order_id);
	}

	public void orderStateChg(String order_id, String state) {
		orderDao.orderStateChg(order_id, state);
	}

	public int refundCnt(String f, String query, String sd, String ed, String refund_type) {
		return refundDao.refundCnt(f, query, sd, ed, refund_type);
	}

	public List<RefundView> getRefundList(Integer pageNum, String f, String query, String sd, String ed,
			String refund_type) {
		return refundDao.getRefundList(pageNum, f, query, sd, ed, refund_type);
	}

	public boolean refundBack(String refund_number, String type) {
		return refundDao.refundBack(refund_number, type);
	}

	public RefundView getRefund(String refund_number) {
		return refundDao.getRefund(refund_number);
	}

	@Transactional
	public void refundComp(String refund_number, String type) {
		RefundView refund = refundDao.getRefund(refund_number);
		refundDao.refundBack(refund_number, type);
		if(!refund.getRefund_reason().equals("제품 결함")) {
			optDao.addQuantity(refund.getRefund_optId(), refund.getRefund_optCount());
		}
	}
	
	@Transactional
	public void pointBack(String refund_memId, int refundPoint) {
		memDao.pointBack(refund_memId, refundPoint);
		pointDao.pointBack(refund_memId, refundPoint);
	}
}
