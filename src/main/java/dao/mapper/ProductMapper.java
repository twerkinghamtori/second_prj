package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import dto.Product;

public interface ProductMapper {

	@Select({"<script>",
		"select count(*) from product",
		"<if test='searchContent!=null'>",
		" where product_name like #{searchContent}",
		"</if>",
		"<if test='product_type!=null'>",
		" and product_type=#{product_type}",
		"</if>",		
		"</script>"		
	})
	int count(Map<String, Object> param);

	@Select({"<script>",
		"select * from product",
		"<if test='searchContent!=null'>",
		" where product_name like #{searchContent}",
		"</if>",
		"<if test='product_type!=null'>",
		" and product_type=#{product_type}",
		"</if>",
		"<if test='end!=null'>",
		" limit #{start}, #{end}",
		"</if>",
		"</script>"		
	})
	List<Product> productList(Map<String, Object> param);

	@Select("select * from product where product_number=#{product_number}")
	Product getProduct(Map<String, Object> param);

	@Select("select * from product")
	List<Product> productListAll();

}
