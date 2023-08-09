package dto;

import java.util.Date;

import lombok.Data;

@Data
public class Point {
	private int point_number;
	private String mem_id;
	private String point_type;
	private int point_value;
	private Date point_regdate;
}
