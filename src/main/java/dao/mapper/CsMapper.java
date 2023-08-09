package dao.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import dto.Cs;

public interface CsMapper {

	@Insert("insert into cs (mem_id, cs_qContent, cs_state, cs_qdate) values (#{mem_id}, #{cs_qContent}, '답변대기', now())")
	boolean csReg(Cs cs);

	@Select("select * from cs where mem_id = #{value}")
	List<Cs> getCs(String mem_id);

	@Select("select * from cs where cs_number=#{value}")
	Cs getCsDetail(Integer cs_number);

}
