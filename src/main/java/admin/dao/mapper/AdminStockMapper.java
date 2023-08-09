package admin.dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.Stock;

public interface AdminStockMapper {

	@Insert("insert into stock (opt_number, stock_regdate, stock_quantity, stock_prodName, stock_prodThumb) values (#{opt_number}, now(), #{stock_quantity}, #{stock_prodName}, #{stock_prodThumb})")
	boolean regProdStock(Stock stock);

	@Select({"<script> ",
		" select count(*) from stock  where stock_prodName like '%${query}%'",
		" <if test='sd != null and sd != \"\"'>",
		"  AND stock_regdate &gt;= #{sd} ",
		" </if>",
		" <if test='ed != null and ed != \"\"'> ",
		"  AND stock_regdate &lt;= #{ed} ",
		" </if>",
	" </script>"})
	int getStockCnt(Map<String, Object> param);

	@Select({"<script> ",
		"SELECT * FROM stock WHERE stock_prodName LIKE '%${query}%' ",
		" <if test='sd != null and sd != \"\"'>",
		"  AND stock_regdate &gt;= #{sd} ",
		" </if>",
		" <if test='ed != null and ed != \"\"'> ",
		"  AND stock_regdate &lt;= #{ed} ",
		" </if>",
		" ORDER BY stock_number DESC LIMIT #{start}, 10",
		"</script>"
	})	
	List<Stock> getStockList(Map<String, Object> param);

	@Select("select * from stock where stock_number = #{value}")
	Stock getStock(Integer stock_number);

	@Update("update stock set stock_quantity = #{stock_quantity} where stock_number = #{stock_number}")
	boolean updateStock(Stock stock);

	@Select("select count(*) from stock where opt_number=#{value}")
	int optStockCnt(Integer opt_number);

	@Select("select * from stock where opt_number=#{opt_number} ORDER BY stock_number DESC LIMIT #{start}, 10")
	List<Stock> getOptStockList(Map<String, Object> param);

}
