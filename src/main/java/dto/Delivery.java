package dto;

import lombok.Data;

@Data
public class Delivery {
	private String mem_id;
	private int delivery_number;
	private String delivery_receiver;
	private String delivery_phoneNo;
	private String delivery_nickName;
	private String delivery_postcode;
	private String delivery_address;
	private String delivery_detailAddress;
}
