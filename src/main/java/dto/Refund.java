package dto;

import java.util.Date;

import lombok.Data;

@Data
public class Refund {
	private int refund_number;
	private String refund_orderId;
	private int refund_optId;
	private int refund_optCount;
	private String refund_memId;
	private String refund_reason;
	private int refund_price;
	private String refund_type;
	private Date refund_date;
	private Date refund_compdate;
}
