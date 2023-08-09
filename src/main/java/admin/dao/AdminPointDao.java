package admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import admin.dao.mapper.AdminPointMapper;
import dto.Point;

@Repository
public class AdminPointDao {

	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private final Class<AdminPointMapper> cls = AdminPointMapper.class;
	
	public boolean regPoint(Point point) {
		return template.getMapper(cls).regPoint(point);
	}

	public int getPointCnt(String query) {
		return template.getMapper(cls).getPointCnt(query);
	}

	public List<Point> getPointList(Integer pageNum, String query) {
		param.clear();
		param.put("query", query);
		param.put("start", (pageNum -1) * 10);
		param.put("limit", 10);
		
		return template.getMapper(cls).getPointList(param);
	}

	public Point getPoint(Integer point_number) {
		return template.getMapper(cls).getPoint(point_number);
	}

	public boolean pointDel(Integer point_number) {
		return template.getMapper(cls).pointDel(point_number);
	}

	public void pointBack(String refund_memId, int refundPoint) {
		param.clear();
		param.put("refund_memId", refund_memId);
		param.put("refundPoint", refundPoint);
		template.getMapper(cls).pointBack(param);
	}

}
