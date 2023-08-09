package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.Order;
import dto.OrderView;

public interface OrderMapper {

	@Select("select ifnull(max(order_id), 1) from h_order")
	String getMaxOrderId();

	@Insert("insert into h_order (order_id, order_receiver, mem_id, delivery_postcode, delivery_address, delivery_detailAddress, order_state, delivery_cost, order_point, order_date, order_phoneno, order_msg, order_totalPay)"
			+ " values (#{order_id}, #{deliver_receiver}, #{mem_id}, #{delivery_postcode}, #{delivery_address}, #{delivery_detailAddress}, '결제완료', #{delivery_cost}, #{order_point}, now(), #{phoneno}, #{order_msg}, #{order_totalPay})")
	boolean addOrder(Map<String, Object> param);

	@Select("select * from h_order where mem_id=#{value}")
	List<Order> getOrderList(String mem_id);

	@Select("select * from orderView where mem_id=#{mem_id} order by order_id desc LIMIT #{start}, 10")
	List<OrderView> getOv(Map<String, Object> param);

	@Select("select * from orderView where mem_id=#{mem_id} and order_id=#{order_id} order by order_id desc")
	List<OrderView> getOvList(Map<String, Object> param);

	@Update("update h_order set order_state = #{order_state} where order_id = #{order_id}")
	void updateOrderState(Map<String, Object> param);

	@Select("select * from orderView where order_id=#{order_id} and opt_number=#{opt_number}")
	OrderView getOvIdNum(Map<String, Object> param);

	@Delete("delete from h_order where order_id=#{value}")
	void deleteOrder(String order_id);

	@Select("select * from orderView where mem_id=#{mem_id} and order_state=#{order_state} order by order_date desc")
	List<OrderView> getOvDelivered(Map<String, Object> param);

	@Select("select * from orderView where order_itemId=#{value}")
	OrderView getOvItemId(int order_itemId);

	@Select("select * from orderView where product_number=#{value}")
	List<OrderView> getOvProducdtNum(int product_number);

	@Select("select * from h_order where order_id=#{value}")
	Order getOrder(String order_id);

	@Select("select * from orderView where order_id=#{value}")
	List<OrderView> getOvOi(String order_id);

	@Select("select count(*) from orderView where mem_id=#{value}")
	int orderCnt(String mem_id);
}
