package dto;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Product {
	private int product_number;
	private String product_name;
	private String product_type;
	private int product_price;
	private String product_desc;
	private String product_isDiscount;
	private int product_discountRate;
	private Date product_regdate;
	private String product_thumb;
	private String product_pictures;
	private int opt_quantity;
	private MultipartFile thumbFile;
	private List<MultipartFile> picFiles;

	public void setThumbFile(MultipartFile thumbFile) {
		if(thumbFile != null & !thumbFile.isEmpty()) {
			this.product_thumb = thumbFile.getOriginalFilename();
			this.thumbFile = thumbFile;
		}
	}

	public void setPicFiles(List<MultipartFile> picFiles) {
		// 파일 이름들을 콤마로 구분하여 product_picture에 설정
		System.out.println(picFiles);
		if (picFiles != null && !picFiles.isEmpty()) {
			this.picFiles = picFiles;
			StringBuilder sb = new StringBuilder();
			for (MultipartFile picFile : picFiles) {
				if (isImageFile(picFile)) { 
					if (sb.length() > 0) {
						sb.append(",");
					}
					sb.append(picFile.getOriginalFilename());
				}
			}
			this.product_pictures = sb.toString();
		}
	}

	private boolean isImageFile(MultipartFile file) {
		String fileName = file.getOriginalFilename();
		String fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
		return fileExtension.equals("jpg") || fileExtension.equals("png") || fileExtension.equals("gif");
	}
}
