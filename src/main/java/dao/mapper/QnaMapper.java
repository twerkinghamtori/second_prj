package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.Qna;

public interface QnaMapper {

	@Select("select count(*) from qna where qna_type like '%${value}%' ")
	int getQnaCnt(String type);

	@Select("select * from qna where qna_type like '%${qna_type}%' ORDER BY qna_number DESC LIMIT #{start}, 10")
	List<Qna> getQnaList(Map<String, Object> param);

	@Select("select * from qna where qna_number=#{qna_number}")
	Qna getQna(Integer qna_number);

	@Update("update qna set qna_hits = qna_hits + 1 where qna_number=#{qna_number}")
	void addQnaHits(Integer qna_number);
}
