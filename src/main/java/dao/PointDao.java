package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.PointMapper;
import dto.Point;

@Repository
public class PointDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private final Class<PointMapper> cls = PointMapper.class;
	
	public void pointInsert(String mem_id) {
		template.getMapper(cls).pointInsert(mem_id);
	}

	public void pointUsedStore(Integer order_point, String mem_id) {
		param.clear();
		param.put("order_point", order_point);
		param.put("mem_id", mem_id);
		template.getMapper(cls).pointUsedStore(param);
	}

	public void pointBack(String mem_id, int order_point) {
		param.clear();
		param.put("mem_id", mem_id);
		param.put("order_point", order_point);
		template.getMapper(cls).pointBack(param);
	}

	public int pointCnt(String point_type, String mem_id) {
		param.clear();
		param.put("mem_id", mem_id);
		if(point_type.equals("포인트 지급")) {
			return template.getMapper(cls).pointCnt2(param);
		}
		param.put("point_type", point_type);
		return template.getMapper(cls).pointCnt1(param);
	}

	public List<Point> getPointList(Integer pageNum, String mem_id, String point_type) {
		param.clear();
		param.put("mem_id", mem_id);
		param.put("start", (pageNum -1) * 10);
		param.put("limit", 10);
		if(point_type.equals("포인트 지급")) {
			return template.getMapper(cls).getPointList2(param);
		}
		param.put("point_type", point_type);
		return template.getMapper(cls).getPointList1(param);
	}	

}
