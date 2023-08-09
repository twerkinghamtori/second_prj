package admin.dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.Delivery;
import dto.Mem;
import dto.Point;

public interface AdminMemMapper {

	@Select("select count(*) from mem where ${f} like '%${query}%'")
	int memCnt(Map<String, Object> param);

	@Select("select * from mem where ${f} like '%${query}%' ORDER BY mem_number DESC LIMIT #{start}, 10 ")
	List<Mem> getMemList(Map<String, Object> param);

	@Select("select * from mem where mem_number=#{value}")
	Mem getMem(Integer mem_number);

	@Select("select * from mem where mem_id=#{value}")
	Mem getMemId(String mem_id);
	
	@Select("select * from delivery where mem_id=#{value}")
	List<Delivery> getDelList(String mem_id);

	@Delete("delete from mem where mem_number=#{value}")
	boolean memDel(Integer mem_number);

	@Update("update mem set mem_point = mem_point+#{point_value} where mem_id=#{mem_id}")
	boolean pointChg(Point point);

	@Update("update mem set mem_point = #{point} where mem_id=#{mem_id}")
	boolean setPointZero(Map<String, Object> param);

	@Update("update mem set mem_point = mem_point + #{refundPoint} where mem_id=#{refund_memId}")
	void pointBack(Map<String, Object> param);

	@Update("update mem set mem_name=#{mem_name}, mem_phoneno=#{mem_phoneno} where mem_number=#{mem_number}")
	boolean memChg(Mem mem);

	
}
