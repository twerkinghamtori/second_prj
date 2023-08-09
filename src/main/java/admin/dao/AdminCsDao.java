package admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import admin.dao.mapper.AdminCsMapper;
import dto.Cs;

@Repository
public class AdminCsDao {

	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private final Class<AdminCsMapper> cls = AdminCsMapper.class;
	
	public int csCnt(String sd, String ed, String query, String cs_state) {
		param.clear();
		param.put("sd", sd);
		param.put("ed", ed);
		param.put("query", query);
		param.put("cs_state", cs_state);
		
		return template.getMapper(cls).csCnt(param);
	}

	public List<Cs> getCsList(Integer pageNum, String sd, String ed, String query, String cs_state) {
		param.clear();
		param.put("sd", sd);
		param.put("ed", ed);
		param.put("query", query);
		param.put("cs_state", cs_state);
		param.put("start", (pageNum -1) * 10);
		param.put("limit", 10);
		
		return template.getMapper(cls).getCsList(param);
	}

	public Cs getCs(Integer cs_number) {
		return template.getMapper(cls).getCs(cs_number);
	}

	public boolean csReply(Cs cs) {
		return template.getMapper(cls).csReply(cs);
	}

	public boolean csDel(Integer cs_number) {
		return template.getMapper(cls).csDel(cs_number);
	}

	public Integer csTodayCnt() {
		return template.getMapper(cls).csTodayCnt();
	}
}
