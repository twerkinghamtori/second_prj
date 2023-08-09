package admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import admin.dao.mapper.AdminManagerMapper;
import dto.Manager;

@Repository
public class AdminManagerDao {
	
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private final Class<AdminManagerMapper> cls = AdminManagerMapper.class;

	public boolean managerReg(Manager manager) {
		return template.getMapper(cls).managerReg(manager);
	}

	public int managerCnt(String f, String query) {
		param.clear();
		param.put("f", f);
		param.put("query", query);
		return template.getMapper(cls).managerCnt(param);
	}

	public List<Manager> getManagerList(Integer pageNum, String f, String query) {
		param.clear();
		param.put("f", f);
		param.put("query", query);
		param.put("start", (pageNum -1) * 10);
		param.put("limit", 10);
		return template.getMapper(cls).getManagerList(param);
	}

	public Manager getManager(String manager_id) {
		param.clear();
		param.put("manager_id", manager_id);
		return template.getMapper(cls).getManager(param);
	}
	
	public Manager getManager2(String manager_name) {
		param.clear();
		param.put("manager_name", manager_name);
		return template.getMapper(cls).getManager2(param);
	}

	public Manager managerLogin(String manager_id, String manager_pass) {
		param.clear();
		param.put("manager_id", manager_id);
		param.put("manager_pass", manager_pass);
		return template.getMapper(cls).getManager(param);
	}

	public boolean managerChg(Manager manager) {
		return template.getMapper(cls).managerChg(manager);
	}

	public boolean managerDel(Integer manager_number) {
		return template.getMapper(cls).managerDel(manager_number);
	}

}
