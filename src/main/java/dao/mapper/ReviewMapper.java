package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.Review;
import dto.ReviewView;

public interface ReviewMapper {

	@Insert("insert into review (order_itemId, mem_id, review_value, review_content, review_date, review_state) "
			+ " values (#{order_itemId}, #{mem_id}, #{review_value}, #{review_content}, now(), '지급대기')")
	boolean addReview(Map<String, Object> param);

	@Select("select * from review where mem_id=#{value} order by review_date desc")
	List<Review> getMyReview(String mem_id);

	@Select("select * from review where review_number=#{value}")
	Review getReviewNum(Integer review_number);

	@Update("update review set review_value=#{review_value}, review_content=#{review_content} where review_number=#{review_number}")
	boolean updateReview(Map<String, Object> param);

	@Select("select * from review where order_itemId=#{order_itemId} and mem_id=#{mem_id}")
	Review getReviewIsWritten(Map<String, Object> param);

	@Select("select * from review where order_itemId=#{value}")
	Review getReviewOrderId(int order_itemId);

	@Select("select * from review where order_itemId=#{value} ORDER BY review_date DESC LIMIT ${i}, #{j};")
	Review getReviewOrderIdPaging(Map<String, Object> param);

	@Select("select * from reviewView where product_number=#{value} ORDER BY review_date desc")
	List<ReviewView> getReviewProNum(Integer product_number);

	@Delete("delete from review where review_number=#{value}")
	boolean deleteReview(Integer review_number);

	@Select("select * from reviewView where product_number=#{product_number} ORDER BY review_date DESC LIMIT ${startIndex}, #{pageSize};")
	List<ReviewView> getReviewList(Map<String, Object> param);

}
