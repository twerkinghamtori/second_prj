package admin.dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.Qna;

public interface AdminQnaMapper {

	@Insert("insert into qna (qna_title, qna_type, qna_content, qna_regdate, qna_hits) "
			+ " values (#{qna_title}, #{qna_type}, #{qna_content}, now(), #{qna_hits})")
	boolean regQna(Qna qna);

	@Select("select count(*) from qna where qna_type like '%${value}%' ")
	int getQnaCnt(String type);

	@Select("select * from qna where qna_type like '%${qna_type}%' ORDER BY qna_number DESC LIMIT #{start}, 10")
	List<Qna> getQnaList(Map<String, Object> param);

	@Select("select * from qna where qna_number=#{qna_number}")
	Qna getQna(Integer qna_number);

	@Update("update qna set qna_hits = qna_hits + 1 where qna_number=#{qna_number}")
	void addQnaHits(Integer qna_number);

	@Update("update qna set qna_title = #{qna_title}, qna_type = #{qna_type}, qna_content = #{qna_content} where qna_number = #{qna_number}")
	void qnaChg(Qna qna);

	@Delete("delete from qna where qna_number = #{qna_number}")
	void qnaDel(Integer qna_number);
}
