package dto;

import lombok.Data;

@Data
public class OrderItem {
	private int order_itemId;
	private String order_id;
	private int product_number;
	private int opt_number;
	private String opt_count;
}
