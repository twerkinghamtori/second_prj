package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.Opt;
import dto.ProductOptView;

public interface OptMapper {
	@Select("select * from opt where product_number=#{value}")
	List<Opt> getOption(int product_number);

	@Select("select * from opt where opt_number=#{value}")
	Opt getOptionByNum(Integer opt_number);

	@Select("select * from productOptView where opt_number=#{value}")
	ProductOptView getProductOptView(int opt_number);

	@Update("update opt set opt_quantity = opt_quantity - #{opt_count} where opt_number=#{opt_number}")
	boolean updateQ(Map<String, Object> param);

}
