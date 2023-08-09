package admin.dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.Product;

public interface AdminProductMapper {
	
	@Insert("insert into product "
			+ " (product_name, product_type, product_price, product_desc, product_isDiscount, product_discountRate, product_regdate, product_thumb, product_pictures)"
			+ " values (#{product_name}, #{product_type}, #{product_price}, #{product_desc}, #{product_isDiscount}, #{product_discountRate}, now(), #{product_thumb}, #{product_pictures})")
	boolean regProduct(Product product);

	@Select("select * from product where product_name like '%${query}%' ORDER BY product_number DESC LIMIT #{start}, 10")
	List<Product> getProdList(Map<String, Object> param);

	@Select("select count(*) from product  where product_name like '%${query}%'")
	int getProdCnt(String query);

	@Select("select * from product where product_number=#{product_number}")
	Product getProd(Integer product_number);

	@Delete("delete from product where product_number=#{product_number}")
	boolean deleteProduct(Integer product_number);

	@Update("update product set"
			+ " product_name=#{product_name}, product_type=#{product_type}, product_price=#{product_price}, product_desc=#{product_desc}, "
			+ " product_isDiscount=#{product_isDiscount}, product_discountRate=#{product_discountRate}, product_thumb=#{product_thumb}, product_pictures=#{product_pictures}"
			+ " where product_number=#{product_number}")
	boolean updateProduct(Product product);
	
}
