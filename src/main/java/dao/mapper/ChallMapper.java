package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import dto.Chall;

public interface ChallMapper {

	@Insert("insert into chall (chall_number, chall_regdate, mem_id, mem_name, chall_pic, chall_state, chall_cnt) "
			+ " values(#{chall_number}, now(), #{mem_id}, #{mem_name}, #{chall_pic}, '지급대기', #{chall_cnt})")
	boolean regChall(Chall chall);

	@Select("select ifnull(max(chall_number),0) from chall")
	int maxNum();

	@Select("select count(*) from chall")
	int getChallCnt();

	@Select("select * from chall ORDER BY chall_number DESC LIMIT #{start}, 8")
	List<Chall> getChallList(Map<String, Object> param);

	@Select("select * from chall where mem_id=#{mem_id} and chall_regdate=#{chall_regdate}")
	Chall getChall(Map<String, Object> param);

	@Select("select ifnull(max(chall_cnt),0) from chall where mem_id=#{value}")
	int challCnt(String mem_id);

	@Select("select * from chall where mem_id=#{value} order by chall_cnt desc limit 1")
	Chall getMyChall(String mem_id);

	@Select("select * from chall where mem_id=#{mem_id} order by chall_regdate desc LIMIT #{start}, 10")
	List<Chall> getMyChallList(Map<String, Object> param);

	@Select("select * from chall where mem_id=#{mem_id} and chall_state=#{chall_state} order by chall_regdate desc LIMIT #{start}, 10")
	List<Chall> getMyChallListState(Map<String, Object> param);

	@Delete("delete from chall where chall_number=#{value}")
	boolean deleteChall(Integer chall_number);

	@Select({"<script>",
		"select count(*) from chall where mem_id=#{mem_id}",
		"<if test='chall_state!=null'>",
		" and chall_state like #{chall_state}",
		"</if>",	
		"</script>"		
	})
	int myChallCnt(Map<String, Object> param);
}
