package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.ProductMapper;
import dto.Product;

@Repository
public class ProductDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private final Class<ProductMapper> cls = ProductMapper.class;
	
	public List<Product> list(Integer pageNum, int limit, String product_type, String searchContent) {
		param.clear();
		param.put("start", (pageNum-1)*limit);
		param.put("end", limit);
		if(product_type != null) param.put("product_type", product_type);
		param.put("searchContent", "%" + searchContent + "%");
		return template.getMapper(cls).productList(param);
	}

	public int count(String product_type, String searchContent) {
		param.clear();
		if(product_type != null) param.put("product_type", product_type);
		param.put("searchContent", "%" + searchContent + "%");
		return template.getMapper(cls).count(param);
	}

	public Product getProduct(Integer product_number) {
		param.clear();
		param.put("product_number", product_number);
		return template.getMapper(cls).getProduct(param);
	}

	public List<Product> productListAll() {
		return template.getMapper(cls).productListAll();
	}
}
