package dto;

import java.util.Date;

import lombok.Data;

@Data
public class Cs {
	private int cs_number;
	private String mem_id;
	private String cs_qContent;
	private String manager_name;
	private String cs_aContent;
	private Date cs_qdate;
	private Date cs_adate;
	private String cs_state;
}
