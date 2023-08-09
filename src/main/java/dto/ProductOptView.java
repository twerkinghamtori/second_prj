package dto;

public class ProductOptView extends Product{
	private int opt_number;
	private String opt_name;
	private int opt_quantity;
	
	public int getOpt_number() {
		return opt_number;
	}
	public void setOpt_number(int opt_number) {
		this.opt_number = opt_number;
	}
	public String getOpt_name() {
		return opt_name;
	}
	public void setOpt_name(String opt_name) {
		this.opt_name = opt_name;
	}
	public int getOpt_quantity() {
		return opt_quantity;
	}
	public void setOpt_quantity(int opt_quantity) {
		this.opt_quantity = opt_quantity;
	}
	
}
