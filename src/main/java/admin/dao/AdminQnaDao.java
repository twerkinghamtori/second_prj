package admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import admin.dao.mapper.AdminQnaMapper;
import dto.Qna;

@Repository
public class AdminQnaDao {
	
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private final Class<AdminQnaMapper> cls = AdminQnaMapper.class;

	public boolean regQna(Qna qna) {
		return template.getMapper(cls).regQna(qna);
	}

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

	public void qnaChg(Qna qna) {
		template.getMapper(cls).qnaChg(qna);
	}

	public void qnaDel(Integer qna_number) {
		template.getMapper(cls).qnaDel(qna_number);
	}

}
