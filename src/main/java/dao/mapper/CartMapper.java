package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.Cart;

public interface CartMapper {
	@Insert("insert into cart (mem_id, opt_number, opt_count, cart_regdate) values (#{mem_id}, #{opt_number}, #{opt_count}, now())")
	boolean addCart(Map<String, Object> param);

	@Select("select * from cart where mem_id=#{mem_id} and opt_number = #{opt_number}")
	Cart getCart(Map<String, Object> param);

	@Update("update cart set opt_count=#{opt_count} where mem_id=#{mem_id} and opt_number = #{opt_number}")
	void updateCount(Map<String, Object> param);

	@Select("select * from cart where mem_id=#{value} order by cart_regdate")
	List<Cart> getCartListId(String mem_id);

	@Delete("delete from cart where mem_id=#{mem_id} and opt_number=#{opt_number}")
	boolean cartDelete(Map<String, Object> param);

	@Update("update cart set opt_count=opt_count-1 where mem_id=#{mem_id} and opt_number=#{opt_number}")
	boolean cartMinus(Map<String, Object> param);
	
	@Update("update cart set opt_count=opt_count+1 where mem_id=#{mem_id} and opt_number=#{opt_number}")
	boolean cartPlus(Map<String, Object> param);
}
