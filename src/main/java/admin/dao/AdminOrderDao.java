package admin.dao;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import admin.dao.mapper.AdminOrderMapper;
import dto.Order;
import dto.OrderView;

@Repository
public class AdminOrderDao {
	
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private final Class<AdminOrderMapper> cls = AdminOrderMapper.class;

	public int orderCnt(String f, String query, String sd, String ed, String order_state) {
		param.clear();
		param.put("f", f);
		param.put("query", query);
		param.put("sd", sd);
		param.put("ed", ed);
		param.put("order_state", order_state);
		
		return template.getMapper(cls).orderCnt(param);
	}

	public List<Order> getOrderList(Integer pageNum, String f, String query, String sd, String ed, String order_state) {
		param.clear();
		param.put("f", f);
		param.put("query", query);
		param.put("sd", sd);
		param.put("ed", ed);
		param.put("order_state", order_state);
		param.put("start", (pageNum -1) * 10);
		param.put("limit", 10);
		
		return template.getMapper(cls).getOrderList(param);
	}

	public Order getOrder(String order_id) {
		return template.getMapper(cls).getOrder(order_id);
	}

	public List<OrderView> getOrderItem(String order_id) {
		return template.getMapper(cls).getOrderItem(order_id);
	}

	public void orderStateChg(String order_id, String state) {
		param.clear();
		param.put("order_id", order_id);
		param.put("state", state);
		
		template.getMapper(cls).orderStateChg(param);
	}

	public Map<String, Object> orderPay(LocalDate date) {
		return template.getMapper(cls).orderPay(date);
	}

	public Map<String, Object> cancelPay(LocalDate date) {
		return template.getMapper(cls).cancelPay(date);
	}

	public List<Map<String, Object>> orderState() {
		return template.getMapper(cls).orderState();
	}

}
