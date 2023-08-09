package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.OrderMapper;
import dto.Order;
import dto.OrderView;

@Repository
public class OrderDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private final Class<OrderMapper> cls = OrderMapper.class;
	
	public String getMaxOrderId() {
		return template.getMapper(cls).getMaxOrderId();
	}

	public boolean addOrder(String order_id, String deliver_receiver, String mem_id, String delivery_postcode,
			String delivery_address, String delivery_detailAddress, int delivery_cost, int order_point, String phoneno, String order_msg, int order_totalPay) {
		param.clear();
		param.put("order_id", order_id);
		param.put("deliver_receiver", deliver_receiver);
		param.put("mem_id", mem_id);
		param.put("delivery_postcode", delivery_postcode);
		param.put("delivery_address", delivery_address);
		param.put("delivery_detailAddress", delivery_detailAddress);
		param.put("phoneno", phoneno);
		param.put("order_msg", order_msg);
		param.put("delivery_cost", delivery_cost);
		param.put("order_point", order_point);
		param.put("order_totalPay", order_totalPay);
		return template.getMapper(cls).addOrder(param);
	}

	public List<Order> getOrderList(String mem_id) {
		return template.getMapper(cls).getOrderList(mem_id);
	}

	public List<OrderView> getOv(Integer pageNum, String mem_id) {
		param.clear();
		param.put("start", (pageNum -1) * 10);
		param.put("limit", 10);
		param.put("mem_id", mem_id);
		return template.getMapper(cls).getOv(param);
	}

	public List<OrderView> getOvList(String mem_id, String order_id) {
		param.clear();
		param.put("mem_id", mem_id);
		param.put("order_id", order_id);
		return template.getMapper(cls).getOvList(param);
	}

	public void updateOrderState(String order_id, String order_state) {
		param.clear();
		param.put("order_id", order_id);
		param.put("order_state", order_state);
		template.getMapper(cls).updateOrderState(param);
	}

	public OrderView getOvIdNum(String order_id, Integer opt_number) {
		param.clear();
		param.put("order_id", order_id);
		param.put("opt_number", opt_number);
		return template.getMapper(cls).getOvIdNum(param);
	}
	
	public void deleteOrder(String order_id) {
		template.getMapper(cls).deleteOrder(order_id);
	}

	public List<OrderView> getOvDelivered(String mem_id, String order_state) {
		param.clear();
		param.put("mem_id", mem_id);
		param.put("order_state", order_state);
		return template.getMapper(cls).getOvDelivered(param);
	}

	public OrderView getOvItemId(int order_itemId) {
		return template.getMapper(cls).getOvItemId(order_itemId);
	}

	public List<OrderView> getOvProductNum(int product_number) {
		return template.getMapper(cls).getOvProducdtNum(product_number);
	}

	public Order getOrder(String order_id) {
		return template.getMapper(cls).getOrder(order_id);
	}

	public List<OrderView> getOvOi(String order_id) {
		return template.getMapper(cls).getOvOi(order_id);
	}

	public int orderCnt(String mem_id) {
		return template.getMapper(cls).orderCnt(mem_id);
	}
}
