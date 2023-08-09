package admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import admin.dao.mapper.AdminStatMapper;
import dto.StatSale;

@Repository
public class AdminStatDao {

	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private final Class<AdminStatMapper> cls = AdminStatMapper.class;
	
	public int statCnt(String sd, String ed) {
		param.clear();
		param.put("sd", sd);
		param.put("ed", ed);
		
		return template.getMapper(cls).statCnt(param);
	}
	public List<StatSale> getStatSaleList(Integer pageNum, String sd, String ed) {
		param.clear();
		param.put("sd", sd);
		param.put("ed", ed);
		param.put("start", (pageNum -1) * 10);
		
		return template.getMapper(cls).getStatSaleList(param);
	}
}
