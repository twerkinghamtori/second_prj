package service;

import org.json.simple.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import dto.BuyerInfo;
import dto.CancelBuy;
import dto.IamPortDto;

@Service
public class IamPortService {
    
    private final String imp_key="2525013140373035";
    private final String imp_secret="2iIwEiOGxOcJziGXqFawD4fnRBbkoYGropaMwsueDfCVod4Hmw5lvtRCFslTm69CwxKMlhgHYjD4S2e2";
    private RestTemplate restTemplate=new RestTemplate();
    private HttpHeaders headers=new HttpHeaders();
    private JSONObject body=new JSONObject();

    @SuppressWarnings("unchecked")
		private IamPortDto getToken() {
        headers.setContentType(MediaType.APPLICATION_JSON);
        body.put("imp_key", imp_key);
        body.put("imp_secret", imp_secret);
        try {  
            HttpEntity<JSONObject>entity=new HttpEntity<>(body,headers);
            
            IamPortDto token=restTemplate.postForObject("https://api.iamport.kr/users/getToken",entity,IamPortDto.class);
            System.out.println(token);    
            return token;
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("gettoken에서 오류가 발생");
        }finally{
            headerAndBodyClear();
        }
        return null;
    }
    public boolean confrimBuyerInfo(String imp_uid,int price,String email) {
    	IamPortDto iamPortDto=getToken();
        try {
            if(iamPortDto==null){
                throw new Exception();
            }
            headers.add("Authorization",(String) iamPortDto.getResponse().get("access_token"));
            HttpEntity<JSONObject>entity=new HttpEntity<JSONObject>(headers);

            BuyerInfo buyerInfor =restTemplate.postForObject("https://api.iamport.kr/payments/"+imp_uid+"",entity,BuyerInfo.class);
            System.out.println(buyerInfor+" fullinfor");

            if(price==(int)buyerInfor.getResponse().get("amount")&&email.equals(buyerInfor.getResponse().get("buyer_email"))){
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("getBuyerInfor 검증 실패"); 
        }finally{
            headerAndBodyClear();
        }
        return false;
    }
    @SuppressWarnings("unchecked")
		public CancelBuy cancelBuy(String merchant_uid,int returnPrice) {
    	if(returnPrice != 0) {
    		 try {
    	        	IamPortDto iamPortDto=getToken();
    	            if(iamPortDto==null){
    	                throw new Exception();
    	            }

    	            headers.add("Authorization",(String) iamPortDto.getResponse().get("access_token"));
    	            body.put("merchant_uid", merchant_uid);
    	            body.put("amount", returnPrice);

    	            HttpEntity<JSONObject>entity=new HttpEntity<JSONObject>(body, headers);
    	            CancelBuy cancel =restTemplate.postForObject("https://api.iamport.kr/payments/cancel",entity,CancelBuy.class);
    	            
    	            System.out.println(cancel);
    	            return cancel;
    	        } catch (Exception e) {
    	            e.printStackTrace();
    	            System.out.println("cancleBuy가 실패 했습니다 직접 환불 바랍니다");
    	            throw new RuntimeException("환불에 실패 했습니다 다시시도 바랍니다");
    	        }finally{
    	            headerAndBodyClear();
    	        }
    	}
    	return null;
    }
    private void headerAndBodyClear(){
        headers.clear();
        body.clear();
    }
}