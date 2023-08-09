package dto;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Chall {
	private int chall_number;
	private String mem_id;
	private String mem_name;
	private Date chall_regdate;
	private String chall_pic;
	private String chall_state;
	private MultipartFile thumbFile;
	private int chall_cnt;
	
	public void setThumbFile(MultipartFile thumbFile) {
		if(thumbFile != null & !thumbFile.isEmpty()) {
			this.chall_pic = thumbFile.getOriginalFilename();
			this.thumbFile = thumbFile;
		}
	}
}
