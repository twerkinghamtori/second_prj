package admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import admin.dao.mapper.AdminStockMapper;
import dto.Stock;

@Repository
public class AdminStockDao {

	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private final Class<AdminStockMapper> cls = AdminStockMapper.class;
	
	public boolean regProdStock(Stock stock) {
		return template.getMapper(cls).regProdStock(stock);
	}

	public int getStockCnt(String query, String sd, String ed) {
		param.clear();
		param.put("sd", sd);
		param.put("ed", ed);
		param.put("query", query);
		
		return template.getMapper(cls).getStockCnt(param);
	}

	public List<Stock> getStockList(Integer pageNum, String query, String sd, String ed) {
		param.clear();
		param.put("sd", sd);
		param.put("ed", ed);
		param.put("query", query);
		param.put("start", (pageNum -1) * 10);
		param.put("limit", 10);
		
		return template.getMapper(cls).getStockList(param);
	}

	public Stock getStock(Integer stock_number) {
		return template.getMapper(cls).getStock(stock_number);
	}

	public boolean updateStock(Stock stock) {
		return template.getMapper(cls).updateStock(stock);
	}

	public int optStockCnt(Integer opt_number) {
		return template.getMapper(cls).optStockCnt(opt_number);
	}

	public List<Stock> getOptStockList(Integer opt_number, Integer pageNum) {
		param.clear();
		param.put("opt_number", opt_number);
		param.put("start", (pageNum -1) * 10);
		param.put("limit", 10);
		
		return template.getMapper(cls).getOptStockList(param);
	}
}
