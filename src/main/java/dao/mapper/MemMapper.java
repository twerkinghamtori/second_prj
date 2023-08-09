package dao.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.Mem;

public interface MemMapper {
	@Insert("insert into mem (mem_number, mem_id, mem_pw, mem_channel, mem_name, mem_phoneno, mem_point) values (#{mem_number}, #{mem_id}, #{mem_pw}, #{mem_channel}, #{mem_name}, #{mem_phoneno}, 2000)")
	boolean userInsert(Mem mem);

	@Select("select * from mem where mem_id=#{value}")
	Mem getMemEmail(String email);
	
	@Select("select ifnull(max(mem_number), 0) from mem")
	int maxMemNum();

	@Update("update mem set mem_point = mem_point - #{order_point} where mem_id=#{mem_id}")
	void usePoint(Map<String, Object> param);

	@Update("update mem set mem_name=#{mem_name}, mem_phoneno=#{mem_phoneno} where mem_id=#{mem_id}")
	boolean updateMem(Mem mem);

	@Delete("delete from mem where mem_id=#{value}")
	boolean deleteMem(String mem_id);

	@Update("update mem set mem_pw=#{mem_pw} where mem_id=#{email}")
	boolean updatePw(Map<String, Object> param);
	
	@Update("update mem set mem_point = mem_point + #{order_point} where mem_id=#{mem_id}")
	void pointBack(Map<String, Object> param);

}
