package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.ReviewMapper;
import dto.Review;
import dto.ReviewView;

@Repository
public class ReviewDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private final Class<ReviewMapper> cls = ReviewMapper.class;
	
	public boolean addReview(Integer order_itemId, int review_value, String review_content, String mem_id) {
		param.clear();
		param.put("order_itemId", order_itemId);
		param.put("review_value", review_value);
		param.put("review_content", review_content);
		param.put("mem_id", mem_id);
		return template.getMapper(cls).addReview(param);
	}

	public List<Review> getMyReview(String mem_id) {
		return template.getMapper(cls).getMyReview(mem_id);
	}

	public Review getReivewNum(Integer review_number) {
		return template.getMapper(cls).getReviewNum(review_number);
	}

	public boolean updateReview(Integer review_number, int review_value, String review_content) {
		param.clear();
		param.put("review_number", review_number);
		param.put("review_value", review_value);
		param.put("review_content", review_content);
		return template.getMapper(cls).updateReview(param);
	}

	public Review getReviewIsWritten(Integer order_itemId, String mem_id) {
		param.clear();
		param.put("order_itemId", order_itemId);
		param.put("mem_id", mem_id);
		return template.getMapper(cls).getReviewIsWritten(param);
	}

	public Review getReviewOrderId(int order_itemId) {
		return template.getMapper(cls).getReviewOrderId(order_itemId);
	}

	public Review getReviewOrderIdPaging(int order_itemId, int i, int j) {
		param.clear();
		param.put("order_itemId", order_itemId);
		param.put("i", i);
		param.put("j",j);
		return template.getMapper(cls).getReviewOrderIdPaging(param);
	}

	public List<ReviewView> getReviewProNum(Integer product_number) {
		return template.getMapper(cls).getReviewProNum(product_number);
	}

	public boolean deleteReview(Integer review_number) {
		return template.getMapper(cls).deleteReview(review_number);
	}

	public List<ReviewView> getReviewList(int product_number, int startIndex, int pageSize) {
		param.clear();
		param.put("product_number", product_number);
		param.put("startIndex", startIndex);
		param.put("pageSize", pageSize);
		return template.getMapper(cls).getReviewList(param);
	}
}
