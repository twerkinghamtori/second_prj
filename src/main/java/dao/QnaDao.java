package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.QnaMapper;
import dto.Qna;

@Repository
public class QnaDao {

	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private final Class<QnaMapper> cls = QnaMapper.class;
	
	public int getQnaCnt(String type) {
		return template.getMapper(cls).getQnaCnt(type);
	}

	public List<Qna> getQnaList(Integer pageNum, String type) {
		param.clear();
		param.put("qna_type", type);
		param.put("start", (pageNum -1) * 10);
		param.put("limit", 10);
		
		return template.getMapper(cls).getQnaList(param);
	}

	public Qna getQna(Integer qna_number) {
		return template.getMapper(cls).getQna(qna_number);
	}

	public void addQnaHits(Integer qna_number) {
		template.getMapper(cls).addQnaHits(qna_number);
	}
}
