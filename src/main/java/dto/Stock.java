package dto;

import java.util.Date;

import lombok.Data;

@Data
public class Stock {
	private int stock_number;
	private int opt_number;
	private String stock_prodName;
	private String stock_prodThumb;
	private int stock_quantity;
	private Date stock_regdate;
}
