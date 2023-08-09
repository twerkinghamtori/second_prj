package admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import admin.dao.mapper.AdminReviewMapper;
import dto.ReviewView;

@Repository
public class AdminReviewDao {

	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private final Class<AdminReviewMapper> cls = AdminReviewMapper.class;
	
	public int reviewCnt(String f, String query, String sd, String ed, String review_state) {
		param.clear();
		param.put("f", f);
		param.put("query", query);
		param.put("sd", sd);
		param.put("ed", ed);
		param.put("review_state", review_state);
		
		return template.getMapper(cls).reviewCnt(param);
	}
	public List<ReviewView> getReviewList(Integer pageNum, String f, String query, String sd, String ed,
			String review_state) {
		param.clear();
		param.put("f", f);
		param.put("query", query);
		param.put("sd", sd);
		param.put("ed", ed);
		param.put("review_state", review_state);
		param.put("start", (pageNum -1) * 10);
		param.put("limit", 10);
		
		return template.getMapper(cls).getReviewList(param);
	}
	public ReviewView getReview(Integer review_number) {
		return template.getMapper(cls).getReview(review_number);
	}
	public boolean reviewStateChg(Integer review_number) {
		return template.getMapper(cls).reviewStateChg(review_number);
	}
	public boolean reviewDel(Integer review_number) {
		return template.getMapper(cls).reviewDel(review_number);
	}
}
