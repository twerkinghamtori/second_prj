package admin.dao.mapper;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.Order;
import dto.OrderView;

public interface AdminOrderMapper {

	@Select({"<script> ",
		" select count(*) from h_order where ${f} like '%${query}%' ",
		" <if test='sd != null and sd != \"\"'>",
		"  AND order_date &gt;= #{sd} ",
		" </if>",
		" <if test='ed != null and ed != \"\"'> ",
		"  AND order_date &lt;= #{ed} ",
		" </if>",
		" <if test='order_state != null and order_state != \"\"'> ",
		"  AND order_state = #{order_state} ",
		" </if>",
	" </script>"})
	int orderCnt(Map<String, Object> param);

	@Select({"<script> ",
		"SELECT * FROM h_order where ${f} like '%${query}%' ",
		" <if test='sd != null and sd != \"\"'>",
		"  AND order_date &gt;= #{sd} ",
		" </if>",
		" <if test='ed != null and ed != \"\"'> ",
		"  AND order_date &lt;= #{ed} ",
		" </if>",
		" <if test='order_state != null and order_state != \"\"'> ",
		"  AND order_state = #{order_state} ",
		" </if>",
		" ORDER BY order_date DESC, order_id DESC LIMIT #{start}, 10",
		"</script>"
	})	
	List<Order> getOrderList(Map<String, Object> param);

	@Select("select * from h_order where order_id=#{value}")
	Order getOrder(String order_id);

	@Select("select * from orderView where order_id = #{value}")
	List<OrderView> getOrderItem(String order_id);

	@Update("update h_order set order_state=#{state} where order_id=#{order_id}")
	void orderStateChg(Map<String, Object> param);

	@Select("SELECT COUNT(*) AS '주문 건 수', SUM(order_totalPay) AS '주문 금액' "
			+ " FROM h_order "
			+ " WHERE order_state != '주문취소' and order_date = #{date}")
	Map<String, Object> orderPay(LocalDate date);

	@Select("SELECT COUNT(*) AS '취소 건 수', SUM(order_totalPay) AS '취소 금액' "
			+ " FROM h_order "
			+ " WHERE order_state = '주문취소' and order_date = #{date}")
	Map<String, Object> cancelPay(LocalDate date);

	@Select("SELECT order_state AS 'state', COUNT(*) AS 'cnt' "
			+ " FROM orderView "
			+ " WHERE date(order_date) = CURDATE() "
			+ " GROUP BY order_state ")
	List<Map<String, Object>> orderState();

}
