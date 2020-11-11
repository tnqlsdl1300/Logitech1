package product.model;

import java.sql.SQLException;
import java.util.List;

public interface InterKeywordSearch {

	// 인기검색어 순위를 받아오는 메서드
	List<KeywordSearchVO> selectRanking() throws SQLException;

}
