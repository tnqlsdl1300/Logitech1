package product.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;



public interface InterProductDAO {

	// 제품페이지에 보여지는 상품이미지 파일명을 모두 조회(select) 하는 메서드
	
	//DTO(data tranfer object) 데이터 전송객체 == VO(value object)
	//어떤 값을 담아서 보내야하는 공통점. 대부분 같다고 본다.
	
	public List<ProductVO> selectAll(String fk_category) throws SQLException;

	
	//고객이 선택한 상품을 조회하는 (select) 메서드
	
	public List<ProductVO> selectOne(String string) throws SQLException;


	//////////////////////////////////////////////////////////////////////////박수빈:시작/////
	
	// 키워드로 물품을 검색해서 List에 받아오는 메서드(제품 검색)
	public List<ProductVO> searchProductKeyword(String keyword, String type) throws SQLException;

	// 검색한 키워드 DB에 cnt + 1 해주는 메서드(제품 검색)
	public int updateRankingKeyword(String keyword) throws SQLException;

	// 메인페이지의 들어갈 이벤트 정보를 받아오는 메서드 (이벤트 캐러셀)
	public List<EventVO> selectCarousel() throws SQLException;
	
	//////////////////////////////////////////////////////////////////////////박수빈:끝/////

	
}
