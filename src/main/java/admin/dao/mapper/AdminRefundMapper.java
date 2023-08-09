package admin.dao.mapper;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.RefundView;

public interface AdminRefundMapper {

	@Select({"<script> ",
		" select count(*) from refundView where ${f} like '%${query}%' ",
		" <if test='sd != null and sd != \"\"'>",
		"  AND refund_date &gt;= #{sd} ",
		" </if>",
		" <if test='ed != null and ed != \"\"'> ",
		"  AND refund_date &lt;= #{ed} ",
		" </if>",
		" <if test='refund_type != null and refund_type != \"\"'> ",
		"  AND refund_type = #{refund_type} ",
		" </if>",
	" </script>"})
	int refundCnt(Map<String, Object> param);
	
	@Select({"<script> ",
		"SELECT * FROM refundView where ${f} like '%${query}%' ",
		" <if test='sd != null and sd != \"\"'>",
		"  AND refund_date &gt;= #{sd} ",
		" </if>",
		" <if test='ed != null and ed != \"\"'> ",
		"  AND refund_date &lt;= #{ed} ",
		" </if>",
		" <if test='refund_type != null and refund_type != \"\"'> ",
		"  AND refund_type = #{refund_type} ",
		" </if>",
		" ORDER BY refund_number DESC LIMIT #{start}, 10",
		"</script>"
	})	
	List<RefundView> getRefundList(Map<String, Object> param);

	@Update("update refund set refund_type=#{type}, refund_compdate=now() where refund_number=#{refund_number}")
	boolean refundBack(Map<String, Object> param);

	@Select("select * from refundView where refund_number=#{value}")
	RefundView getRefund(String refund_number);

	@Select("SELECT COUNT(*) AS '환불 건 수', SUM(refund_price) AS '환불 금액' "
			+ " FROM refund "
			+ " WHERE refund_type = '환불완료' and refund_compdate = #{date}")
	Map<String, Object> refundPay(LocalDate date);

	@Select("select count(*) from refund WHERE date(refund_date) = CURDATE()")
	Integer refundTodayCnt();

}
