package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import dto.Refund;

public interface RefundMapper {

	@Insert("insert into refund (refund_orderId, refund_optId, refund_memId, refund_reason, refund_price, refund_type) "
			+ " values (#{order_id}, #{optId}, #{mem_id}, '사용자 주문취소', #{price}, '결제 및 주문 취소')")
	void addRefund(Map<String, Object> param);

	@Select("select * from refund where refund_memId = #{value}")
	List<Refund> getRefundList(String mem_id);

	@Select("select * from refund where refund_memId = #{mem_id} and refund_type = #{refund_type} order by refund_date desc")
	List<Refund> getRefundCancelList(Map<String, Object> param);

	@Insert("insert into refund (refund_orderId, refund_optId, refund_optCount, refund_memId, refund_reason, refund_price, refund_type) "
			+ " values (#{refund_orderId}, #{refund_optId}, #{refund_optCount}, #{refund_memId}, #{refund_reason}, #{price}, '환불대기')")
	boolean refundInsert(Map<String, Object> param);

	@Select("select * from refund where refund_orderId = #{value}")
	List<Refund> getRefundListOrderId(String order_id);

	@Select("select * from refund where refund_orderId = #{refund_orderId} and refund_optId=#{refund_optId}")
	List<Refund> getRefund(Map<String, Object> param);

	@Select("select * from refund WHERE refund_memId=#{mem_id} AND refund_type != #{string} order by refund_date desc")
	List<Refund> getRefundListAll(Map<String, Object> param);

	@Insert("insert into refund (refund_orderId, refund_memId, refund_reason, refund_price, refund_type) "
			+ " values (#{order_id}, #{mem_id}, '사용자 주문취소', #{order_totalPay}, '결제 및 주문 취소')")
	void addCancel(Map<String, Object> param);
}
