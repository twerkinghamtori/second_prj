package exception;

public class CloseException extends RuntimeException{	
	private boolean isOpener;
	
	public CloseException(String msg) {
		super(msg);
	}
	
	public CloseException(String msg, boolean isOpener) {
		super(msg);
		this.isOpener=isOpener;
	}

	public boolean isOpener() {
		return isOpener;
	}	
	
}
