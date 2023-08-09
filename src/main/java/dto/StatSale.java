package dto;

import java.util.Date;

import lombok.Data;

@Data
public class StatSale {
	private Date date;
	private int order_cnt;
	private int order_pay;
	private int orderCancel_cnt;
	private int orderCancel_pay;
	private int refund_cnt;
	private int refund_pay;
}
