package admin.dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.Opt;
import dto.ProductOptView;

public interface AdminOptMapper {

	@Insert("insert into opt (opt_name, opt_quantity, product_number) values (#{opt_name}, #{opt_quantity}, #{product_number})")
	boolean regProductOpt(Opt opt);

	@Select("select count(*) from productOptView  where product_name like '%${query}%'")
	int getOptCnt(String query);

	@Select("select * from productOptView where product_name like '%${query}%' ORDER BY opt_number DESC LIMIT #{start}, 10")
	List<ProductOptView> getOptList(Map<String, Object> param);

	@Select("select * from productOptView where opt_number=#{opt_number}")
	ProductOptView getProdOpt(Integer opt_number);

	@Update("update opt set opt_quantity = opt_quantity + #{stock_quantity} where opt_number=#{opt_number}")
	boolean updateQuantity(Map<String, Object> param);

	@Update("update opt set opt_name = #{opt_name}, opt_quantity=#{opt_quantity} where opt_number = #{opt_number}")
	boolean updateOpt(Opt opt);

	@Delete("delete from opt where opt_number=#{value}")
	boolean deleteOpt(Integer opt_number);

	@Update("update opt set opt_quantity = opt_quantity - #{diffQuantity} where opt_number = #{opt_number}")
	boolean diffQuantity(Map<String, Object> param);

	@Update("update opt set opt_quantity = opt_quantity + #{addQuantity} where opt_number = #{opt_number}")
	boolean addQuantity(Map<String, Object> param);


}
