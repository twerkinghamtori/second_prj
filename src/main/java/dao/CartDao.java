package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.CartMapper;
import dto.Cart;

@Repository
public class CartDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private final Class<CartMapper> cls = CartMapper.class;
	
	public boolean addCart(String mem_id, String optionNumber, String optionCount) {
		param.clear();
		param.put("opt_number", optionNumber);
		param.put("opt_count", optionCount);
		param.put("mem_id", mem_id);
		return template.getMapper(cls).addCart(param);
	}

	public Cart getCart(String mem_id, String optionNumber) {
		param.clear();
		param.put("opt_number", optionNumber);
		param.put("mem_id", mem_id);
		return template.getMapper(cls).getCart(param);
	}

	public void updateCount(String mem_id, String optionNumber, String optionCount, String ogCount) {
		param.clear();
		param.put("opt_number", optionNumber);
		param.put("opt_count", Integer.parseInt(optionCount)+Integer.parseInt(ogCount));
		param.put("mem_id", mem_id);
		template.getMapper(cls).updateCount(param);
	}

	public List<Cart> getCartList(String mem_id) {
		return template.getMapper(cls).getCartListId(mem_id);
	}

	public boolean cartDelete(Integer opt_number, String mem_id) {
		param.clear();
		param.put("opt_number", opt_number);
		param.put("mem_id", mem_id);
		return template.getMapper(cls).cartDelete(param);
	}

	public boolean cartMinus(Integer opt_number, String mem_id) {
		param.clear();
		param.put("opt_number", opt_number);
		param.put("mem_id", mem_id);
		return template.getMapper(cls).cartMinus(param);
	}

	public boolean cartPlus(Integer opt_number, String mem_id) {
		param.clear();
		param.put("opt_number", opt_number);
		param.put("mem_id", mem_id);
		return template.getMapper(cls).cartPlus(param);
	}

	public Cart getCart(String mem_id, Integer opt_number) {
		param.clear();
		param.put("opt_number", opt_number);
		param.put("mem_id", mem_id);
		return template.getMapper(cls).getCart(param);
	}
}
