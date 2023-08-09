package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.RefundMapper;
import dto.Refund;

@Repository
public class RefundDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private final Class<RefundMapper> cls = RefundMapper.class;
	
	public void addRefund(String order_id, int optId, String mem_id, int price) {
		param.clear();
		param.put("order_id", order_id);
		param.put("optId", optId);
		param.put("mem_id", mem_id);
		param.put("price", price);
		template.getMapper(cls).addRefund(param);
	}

	public List<Refund> getRefundList(String mem_id) {
		return template.getMapper(cls).getRefundList(mem_id);
	}

	public List<Refund> getRefundCancelList(String mem_id, String refund_type) {
		param.clear();
		param.put("mem_id", mem_id);
		param.put("refund_type", refund_type);
		return template.getMapper(cls).getRefundCancelList(param);
	}

	public boolean refundInsert(String order_id, Integer opt_number, Integer opt_count, String refund_memId, String refund_reason, int price) {
		param.clear();
		param.put("refund_orderId", order_id);
		param.put("refund_optId", opt_number);
		param.put("refund_optCount", opt_count);
		param.put("refund_memId", refund_memId);
		param.put("refund_reason", refund_reason);
		param.put("price", price);
		return template.getMapper(cls).refundInsert(param);
	}

	public List<Refund> getRefundListOrderId(String order_id) {
		return template.getMapper(cls).getRefundListOrderId(order_id);
	}

	public List<Refund> getRefund(String order_id, Integer opt_number) {
		param.clear();
		param.put("refund_orderId", order_id);
		param.put("refund_optId", opt_number);
		return template.getMapper(cls).getRefund(param);
	}

	public List<Refund> getRefundListAll(String mem_id, String string) {
		param.clear();
		param.put("mem_id", mem_id);
		param.put("string", string);
		return template.getMapper(cls).getRefundListAll(param);
	}

	public void addCancel(String order_id, String mem_id, int order_totalPay) {
		param.clear();
		param.put("order_id", order_id);
		param.put("mem_id", mem_id);
		param.put("order_totalPay", order_totalPay);
		template.getMapper(cls).addCancel(param);		
	}
}
