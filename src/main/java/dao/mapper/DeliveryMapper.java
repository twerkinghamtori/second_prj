package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import dto.Delivery;

public interface DeliveryMapper {

	@Insert("insert into delivery (mem_id, delivery_receiver, delivery_phoneNo, delivery_nickName, delivery_postcode, delivery_address, delivery_detailAddress)"
			+ " values (#{mem_id}, #{delivery_receiver}, #{delivery_phoneNo}, #{delivery_nickName}, #{delivery_postcode}, #{delivery_address}, #{delivery_detailAddress})")
	boolean addDelivery(Map<String, Object> param);

	@Select("select * from delivery where mem_id=#{mem_id}")
	List<Delivery> getDeliveryList(String mem_id);

	@Select("select * from delivery where delivery_number=#{value}")
	Delivery getDelivery(Integer selectedOption);

	@Delete("delete from delivery where delivery_number=#{value}")
	boolean deleteD(Integer delivery_number);

	@Insert("insert into delivery (mem_id, delivery_receiver, delivery_phoneNo, delivery_nickName, delivery_postcode, delivery_address, delivery_detailAddress)"
			+ " values (#{mem_id}, #{delivery.delivery_receiver}, #{delivery.delivery_phoneNo}, #{delivery.delivery_nickName}, #{delivery.delivery_postcode}, #{delivery.delivery_address}, #{delivery.delivery_detailAddress})")
	boolean newD(Map<String, Object> param);

}
