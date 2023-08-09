package admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import admin.dao.mapper.AdminProductMapper;
import dto.Product;

@Repository
public class AdminProductDao {
	
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private final Class<AdminProductMapper> cls = AdminProductMapper.class;
	
	public boolean regProduct(Product product) {
		return template.getMapper(cls).regProduct(product);
	}

	public List<Product> getProdList(Integer pageNum, String query) {
		param.clear();
		param.put("query", query);
		param.put("start", (pageNum -1) * 10);
		param.put("limit", 10);
		
		return template.getMapper(cls).getProdList(param);
	}

	public int getProdCnt(String query) {
		return template.getMapper(cls).getProdCnt(query);
	}

	public Product getProd(Integer product_number) {
		return template.getMapper(cls).getProd(product_number);
	}

	public boolean deleteProduct(Integer product_number) {
		return template.getMapper(cls).deleteProduct(product_number);
	}

	public boolean updateProduct(Product product) {
		return template.getMapper(cls).updateProduct(product);
	}
}
