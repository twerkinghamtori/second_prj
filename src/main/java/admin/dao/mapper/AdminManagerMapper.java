package admin.dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.Manager;

public interface AdminManagerMapper {

	@Insert("insert into manager (manager_id, manager_pass, manager_name, manager_birth, manager_grant) "
			+ " values (#{manager_id}, #{manager_pass}, #{manager_name}, #{manager_birth}, #{manager_grant})")
	boolean managerReg(Manager manager);

	@Select("select count(*) from manager where ${f} like '%${query}%'")
	int managerCnt(Map<String, Object> param);

	@Select({"<script>"
		," select * from manager where "
		," <choose>"
		,"   <when test='f == \"manager_name\"'> ${f} like '%${query}%' </when>"
		,"   <when test='f == \"manager_birth\"'> ${f} = #{query} </when>"
		," </choose>"
		," ORDER BY manager_number DESC LIMIT #{start}, 10 "
		," </script>"})
	List<Manager> getManagerList(Map<String, Object> param);

	@Select({"<script>",
		" select * from manager where manager_id = #{manager_id} ",
		" <if test='manager_pass != null'> and manager_pass = #{manager_pass} </if> ",
		" </script>"})
	Manager getManager(Map<String, Object> param);
	
	@Select("select * from manager where manager_name=#{manager_name}")
	Manager getManager2(Map<String, Object> param);

	@Update("update manager set manager_pass=#{manager_pass}, manager_name=#{manager_name}, manager_birth=#{manager_birth}, manager_grant=#{manager_grant} "
			+ " where manager_number=#{manager_number}")
	boolean managerChg(Manager manager);

	@Delete("delete from manager where manager_number=#{value}")
	boolean managerDel(Integer manager_number);

}
