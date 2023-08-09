package admin.dao;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import admin.dao.mapper.AdminRefundMapper;
import dto.RefundView;

@Repository
public class AdminRefundDao {

	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private final Class<AdminRefundMapper> cls = AdminRefundMapper.class;
	
	public int refundCnt(String f, String query, String sd, String ed, String refund_type) {
		param.clear();
		param.put("f", f);
		param.put("query", query);
		param.put("sd", sd);
		param.put("ed", ed);
		param.put("refund_type", refund_type);
		
		return template.getMapper(cls).refundCnt(param);
	}
	public List<RefundView> getRefundList(Integer pageNum, String f, String query, String sd, String ed,
			String refund_type) {
		param.clear();
		param.put("f", f);
		param.put("query", query);
		param.put("sd", sd);
		param.put("ed", ed);
		param.put("refund_type", refund_type);
		param.put("start", (pageNum -1) * 10);
		param.put("limit", 10);
		
		return template.getMapper(cls).getRefundList(param);
	}
	public boolean refundBack(String refund_number, String type) {
		param.clear();
		param.put("refund_number", refund_number);
		param.put("type", type);		
		return template.getMapper(cls).refundBack(param);
	}
	public RefundView getRefund(String refund_number) {
		return template.getMapper(cls).getRefund(refund_number);
	}
	public Map<String, Object> refundPay(LocalDate date) {
		return template.getMapper(cls).refundPay(date);
	}
	public Integer refundTodayCnt() {
		return template.getMapper(cls).refundTodayCnt();
	}
}
