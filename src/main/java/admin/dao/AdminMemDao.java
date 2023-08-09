package admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import admin.dao.mapper.AdminMemMapper;
import dto.Delivery;
import dto.Mem;
import dto.Point;

@Repository
public class AdminMemDao {

	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private final Class<AdminMemMapper> cls = AdminMemMapper.class;
	
	public int memCnt(String f, String query) {
		param.clear();
		param.put("f", f);
		param.put("query", query);
		return template.getMapper(cls).memCnt(param);
	}
	public List<Mem> getMemList(Integer pageNum, String f, String query) {
		param.clear();
		param.put("f", f);
		param.put("query", query);
		param.put("start", (pageNum -1) * 10);
		param.put("limit", 10);
		return template.getMapper(cls).getMemList(param);
	}
	public Mem getMem(Integer mem_number) {
		return template.getMapper(cls).getMem(mem_number);
	}
	public Mem getMemId(String mem_id) {
		return template.getMapper(cls).getMemId(mem_id);
	}
	public List<Delivery> getDelList(String mem_id) {
		return template.getMapper(cls).getDelList(mem_id);
	}
	public boolean memDel(Integer mem_number) {
		return template.getMapper(cls).memDel(mem_number);
	}
	public boolean pointChg(Point point) {
		return template.getMapper(cls).pointChg(point);
	}
	public boolean setPointZero(int point, String mem_id) {
		param.clear();
		param.put("point", point);
		param.put("mem_id", mem_id);
		
		return template.getMapper(cls).setPointZero(param);
	}
	public void pointBack(String refund_memId, int refundPoint) {
		param.clear();
		param.put("refund_memId", refund_memId);
		param.put("refundPoint", refundPoint);
		template.getMapper(cls).pointBack(param);
		
	}
	public boolean memChg(Mem mem) {
		return template.getMapper(cls).memChg(mem);
	}
}
