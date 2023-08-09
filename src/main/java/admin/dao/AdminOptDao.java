package admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import admin.dao.mapper.AdminOptMapper;
import dto.Opt;
import dto.ProductOptView;

@Repository
public class AdminOptDao {

	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private final Class<AdminOptMapper> cls = AdminOptMapper.class;
	
	public boolean regProductOpt(Opt opt) {
		return template.getMapper(cls).regProductOpt(opt);
	}

	public int getOptCnt(String query) {
		return template.getMapper(cls).getOptCnt(query);
	}

	public List<ProductOptView> getOptList(Integer pageNum, String query) {
		param.clear();
		param.put("query", query);
		param.put("start", (pageNum -1) * 10);
		param.put("limit", 10);
		return template.getMapper(cls).getOptList(param);
	}

	public ProductOptView getProdOpt(Integer opt_number) {
		return template.getMapper(cls).getProdOpt(opt_number);
	}

	public boolean updateQuantity(Integer opt_number, Integer stock_quantity) {
		param.clear();
		param.put("opt_number", opt_number);
		param.put("stock_quantity", stock_quantity);
		return template.getMapper(cls).updateQuantity(param);
	}

	public boolean updateOpt(Opt opt) {
		return template.getMapper(cls).updateOpt(opt);
	}

	public boolean deleteOpt(Integer opt_number) {
		return template.getMapper(cls).deleteOpt(opt_number);
	}

	public boolean diffQuantity(int opt_number, int diffQuantity) {
		param.clear();
		param.put("opt_number", opt_number);
		param.put("diffQuantity", diffQuantity);
		
		return template.getMapper(cls).diffQuantity(param);
	}

	public boolean addQuantity(int opt_number, int addQuantity) {
		param.clear();
		param.put("opt_number", opt_number);
		param.put("addQuantity", addQuantity);
		
		return template.getMapper(cls).addQuantity(param);
	}
}
