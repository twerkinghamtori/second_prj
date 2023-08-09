package admin.dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.Chall;

public interface AdminChallMapper {

	@Select({"<script> ",
		" select count(*) from chall where mem_id like '%${query}%' ",
		" <if test='sd != null and sd != \"\"'>",
		"  AND chall_regdate &gt;= #{sd} ",
		" </if>",
		" <if test='ed != null and ed != \"\"'> ",
		"  AND chall_regdate &lt;= #{ed} ",
		" </if>",
		" <if test='chall_state != null and chall_state != \"\"'> ",
		"  AND chall_state = #{chall_state} ",
		" </if>",
	" </script>"})
	int challCnt(Map<String, Object> param);

	@Select({"<script> ",
		"SELECT * FROM chall where  mem_id like '%${query}%' ",
		" <if test='sd != null and sd != \"\"'>",
		"  AND chall_regdate &gt;= #{sd} ",
		" </if>",
		" <if test='ed != null and ed != \"\"'> ",
		"  AND chall_regdate &lt;= #{ed} ",
		" </if>",
		" <if test='chall_state != null and chall_state != \"\"'> ",
		"  AND chall_state = #{chall_state} ",
		" </if>",
		" ORDER BY chall_number DESC LIMIT #{start}, 10",
		"</script>"
	})	
	List<Chall> getChallList(Map<String, Object> param);

	@Update("update chall set chall_state = '지급완료' where chall_number=#{value}")
	boolean stateChg(Integer chall_number);

	@Delete("delete from chall where chall_number=#{value}")
	boolean challDel(Integer chall_number);

}
