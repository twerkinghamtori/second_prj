package dto;

import org.json.simple.JSONObject;

import lombok.Data;
@Data
public class BuyerInfo {
	private String code;
	private String message;
	private JSONObject response = new JSONObject();
}
