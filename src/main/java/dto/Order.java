package dto;

import java.util.Date;

import lombok.Data;

@Data
public class Order {
	private String order_id;
	private String order_receiver;
	private String mem_id;
	private String delivery_postcode;
	private String delivery_address;
	private String delivery_detailAddress;
	private String order_state;
	private int delivery_cost;
	private int order_point;
	private Date order_date;
	private String order_phoneno;
	private String order_msg;
	private int order_totalPay;
}
