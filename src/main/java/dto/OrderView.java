package dto;

import java.util.Date;

import lombok.Data;

@Data
public class OrderView {
	private String order_id;
	private int order_itemId;
	private String mem_id;
	private int order_point;
	private String order_state;
	private int delivery_cost;
	private int product_number;
	private int opt_number;
	private String opt_count;
	private String product_name;
	private String opt_name;
	private int product_price;
	private int product_discountRate;
	private Date order_date;
	private int order_totalPay;
}
