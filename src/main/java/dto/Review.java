package dto;

import java.util.Date;

import lombok.Data;

@Data
public class Review {
	private int review_number;
	private int order_itemId;
	private String mem_id;
	private int review_value;
	private String review_content;
	private Date review_date;
	private String review_state;
}
