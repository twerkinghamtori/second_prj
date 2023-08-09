package dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.MemMapper;
import dto.Mem;

@Repository
public class MemDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private final Class<MemMapper> cls = MemMapper.class;
	
	public boolean userInsert(Mem mem) {
		return template.getMapper(cls).userInsert(mem);
	}

	public Mem getMemEmail(String email) {
		return template.getMapper(cls).getMemEmail(email);
	}

	public int maxMemNum() {
		return template.getMapper(cls).maxMemNum();
	}

	public void usePoint(int order_point, String mem_id) {
		param.clear();
		param.put("order_point", order_point);
		param.put("mem_id", mem_id);
		template.getMapper(cls).usePoint(param);
	}

	public boolean updateMem(Mem mem) {
		return template.getMapper(cls).updateMem(mem);
	}

	public boolean deleteMem(String mem_id) {
		return template.getMapper(cls).deleteMem(mem_id);
	}

	public boolean updatePw(String email, String mem_pw) {
		param.clear();
		param.put("email", email);
		param.put("mem_pw",mem_pw);
		return template.getMapper(cls).updatePw(param);
	}

	public void pointBack(String mem_id, int order_point) {
		param.clear();
		param.put("mem_id", mem_id);
		param.put("order_point", order_point);
		template.getMapper(cls).pointBack(param);
	}
}
