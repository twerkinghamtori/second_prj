package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.OptMapper;
import dto.Opt;
import dto.ProductOptView;

@Repository
public class OptDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private final Class<OptMapper> cls = OptMapper.class;

	public List<Opt> getOption(int product_number) {
		return template.getMapper(cls).getOption(product_number);
	}

	public Opt getOptionByNum(Integer opt_number) {
		return template.getMapper(cls).getOptionByNum(opt_number);
	}

	public ProductOptView getProductOptView(int opt_number) {
		return template.getMapper(cls).getProductOptView(opt_number);
	}

	public boolean updateQ(int refund_optId, int refund_optCount) {
		param.clear();
		param.put("opt_number", refund_optId);
		param.put("opt_count", refund_optCount);
		return template.getMapper(cls).updateQ(param);
	}
}
