package dto;

import java.util.Date;

import lombok.Data;

@Data
public class Qna {
	private int qna_number;
	private String qna_title;
	private String qna_type;
	private String qna_content;
	private Date qna_regdate;
	private int qna_hits;
}
