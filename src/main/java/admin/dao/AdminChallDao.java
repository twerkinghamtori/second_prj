package admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import admin.dao.mapper.AdminChallMapper;
import dto.Chall;

@Repository
public class AdminChallDao {

	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private final Class<AdminChallMapper> cls = AdminChallMapper.class;
	
	public int challCnt(String query, String sd, String ed, String chall_state) {
		param.clear();
		param.put("query", query);
		param.put("sd", sd);
		param.put("ed", ed);
		param.put("chall_state", chall_state);
		
		return template.getMapper(cls).challCnt(param);
	}
	public List<Chall> getChallList(Integer pageNum, String query, String sd, String ed, String chall_state) {
		param.clear();
		param.put("query", query);
		param.put("sd", sd);
		param.put("ed", ed);
		param.put("chall_state", chall_state);
		param.put("start", (pageNum -1) * 10);
		param.put("limit", 10);
		
		return template.getMapper(cls).getChallList(param);
	}
	public boolean stateChg(Integer chall_number) {
		return template.getMapper(cls).stateChg(chall_number);
	}
	public boolean challDel(Integer chall_number) {
		return template.getMapper(cls).challDel(chall_number);
	}
}
