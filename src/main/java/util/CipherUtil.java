package util;

import java.security.MessageDigest;

import javax.crypto.Cipher;

import org.springframework.stereotype.Component;

@Component
public class CipherUtil {
	static Cipher cipher; 
	static {
		try {
			cipher = Cipher.getInstance("AES/CBC/PKCS5Padding"); //CBC => 초기화벡터 필요
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	public String makehash(String plain, String algo) throws Exception {
		MessageDigest md = MessageDigest.getInstance(algo);
		byte[] plainByte = plain.getBytes();
		byte[] hashByte = md.digest(plainByte);
		return byteToHex(hashByte);
	}	
	private String byteToHex(byte[] hashByte) {
		if(hashByte==null) return null;
		String str = "";
		for(byte b : hashByte) {
			str += String.format("%02X", b); 
		}
		return str;
	}	
}
