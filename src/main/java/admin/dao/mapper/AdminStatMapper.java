package admin.dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import dto.StatSale;

public interface AdminStatMapper {

	@Select({"<script> ",
    " SELECT COUNT(date) FROM orderStatView ",
    " <if test='sd != null and sd != \"\"'>",
    "   WHERE date &gt;= #{sd} ",
    " </if>",
    " <if test='ed != null and ed != \"\"'> ",
    "   <if test='sd == null or sd == \"\"'>",
    "     WHERE ",
    "   </if>",
    "  and date &lt;= #{ed} ",
    " </if>",
		" </script>"})
	int statCnt(Map<String, Object> param);

	@Select({"<script> ",
    " SELECT * FROM orderStatView ",
    " <if test='sd != null and sd != \"\"'>",
    "   WHERE date &gt;= #{sd} ",
    " </if>",
    " <if test='ed != null and ed != \"\"'> ",
    "   <if test='sd == null or sd == \"\"'>",
    "     WHERE ",
    "   </if>",
    "  and date &lt;= #{ed} ",
    " </if>",
    " ORDER BY date DESC LIMIT #{start}, 10",
		" </script>"})
	List<StatSale> getStatSaleList(Map<String, Object> param);

}
