package exception;

public class OpenerException extends RuntimeException{	
	private String url;
	
	public OpenerException(String msg, String url) {
		super(msg);
		this.url=url;
	}
	
	public String getUrl() {
		return url;
	}
}
