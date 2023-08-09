package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.CsMapper;
import dto.Cs;

@Repository
public class CsDao {

	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private final Class<CsMapper> cls = CsMapper.class;
	
	public boolean csReg(Cs cs) {
		return template.getMapper(cls).csReg(cs);
	}

	public List<Cs> getCs(String mem_id) {
		return template.getMapper(cls).getCs(mem_id);
	}

	public Cs getCsDetail(Integer cs_number) {
		return template.getMapper(cls).getCsDetail(cs_number);
	}
}
