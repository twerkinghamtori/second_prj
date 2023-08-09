package admin.dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import dto.OrderView;

public interface AdminOrderItemMapper {

	@Select("select count(*) from h_orderItem where opt_number=#{value}")
	int optOrderCnt(Integer opt_number);

	@Select("select * from orderView where opt_number=#{opt_number} ORDER BY order_date DESC LIMIT #{start}, 10")
	List<OrderView> getOptOrderList(Map<String, Object> param);

}
