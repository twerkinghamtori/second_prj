package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.DeliveryMapper;
import dto.Delivery;

@Repository
public class DeliveryDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private final Class<DeliveryMapper> cls = DeliveryMapper.class;
	
	public boolean addDelivery(Delivery delivery, String mem_id) {
		param.clear();
		param.put("delivery_receiver", delivery.getDelivery_receiver());
	    param.put("delivery_phoneNo", delivery.getDelivery_phoneNo());
	    param.put("delivery_nickName", delivery.getDelivery_nickName());
	    param.put("delivery_postcode", delivery.getDelivery_postcode());
	    param.put("delivery_address", delivery.getDelivery_address());
	    param.put("delivery_detailAddress", delivery.getDelivery_detailAddress());
		param.put("mem_id", mem_id);
		return template.getMapper(cls).addDelivery(param);
	}

	public List<Delivery> getDeliveryList(String mem_id) {
		return template.getMapper(cls).getDeliveryList(mem_id);
	}

	public Delivery getDelivery(Integer selectedOption) {
		return template.getMapper(cls).getDelivery(selectedOption);
	}

	public boolean deleteD(Integer delivery_number) {
		return template.getMapper(cls).deleteD(delivery_number);
	}

	public boolean newD(Delivery delivery, String mem_id) {
		param.clear();
		param.put("delivery", delivery);
		param.put("mem_id", mem_id);
		return template.getMapper(cls).newD(param);
	}
}
