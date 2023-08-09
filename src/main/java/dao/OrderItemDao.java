package dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.OrderItemMapper;
import dto.OrderItem;

@Repository
public class OrderItemDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private final Class<OrderItemMapper> cls = OrderItemMapper.class;
	
	public boolean addOrderItem(String order_id, Integer opt_number, Integer product_number, String opt_count) {
		param.clear();
		param.put("order_id", order_id);
		param.put("opt_number", opt_number);
		param.put("product_number", product_number);
		param.put("opt_count", opt_count);
		return template.getMapper(cls).addOrderItem(param);
	}

	public OrderItem getOrderItemList(String order_id) {
		return template.getMapper(cls).getOrderItemList(order_id);
	}
}
