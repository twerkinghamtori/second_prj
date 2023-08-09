package admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import admin.dao.mapper.AdminOrderItemMapper;
import dto.OrderView;

@Repository
public class AdminOrderItemDao {

	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private final Class<AdminOrderItemMapper> cls = AdminOrderItemMapper.class;
	
	public int optOrderCnt(Integer opt_number) {
		return template.getMapper(cls).optOrderCnt(opt_number);
	}
	public List<OrderView> getOptOrderList(Integer opt_number, Integer pageNum) {
		param.clear();
		param.put("opt_number", opt_number);
		param.put("start", (pageNum -1) * 10);
		param.put("limit", 10);
		
		return template.getMapper(cls).getOptOrderList(param);
	}
}
