package dao.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import dto.OrderItem;

public interface OrderItemMapper {
	@Insert("insert into h_orderItem (order_id, product_number, opt_number, opt_count) values (#{order_id}, #{product_number}, #{opt_number}, #{opt_count})")
	boolean addOrderItem(Map<String, Object> param);

	@Select("select * from h_orderItem where order_id=#{value}")
	OrderItem getOrderItemList(String order_id);
}
