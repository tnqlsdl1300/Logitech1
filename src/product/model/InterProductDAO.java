package product.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;



public interface InterProductDAO {

	// 제품페이지에 보여지는 상품이미지 파일명을 모두 조회(select) 하는 메서드
	
	//DTO(data tranfer object) 데이터 전송객체 == VO(value object)
	//어떤 값을 담아서 보내야하는 공통점. 대부분 같다고 본다.
	
	public List<ProductVO> selectAll(String fk_category) throws SQLException;

	
	//고객이 선택한 상품에 대한 상세제품들을 조회하는 (select) 메서드
	public List<ProductVO> selectOne(String productid) throws SQLException;
		
		
	//색상 선택하고 보여주기
	public List<ProductVO> selectOneColor(Map<String, String> paraMap) throws SQLException;
	


	//////////////////////////////////////////////////////////////////////////박수빈:시작/////
	
	// 키워드로 물품을 검색해서 List에 받아오는 메서드(제품 검색)
	public List<ProductVO> searchProductKeyword(String keyword, String type) throws SQLException;

	// 검색한 키워드 DB에 cnt + 1 해주는 메서드(제품 검색)
	public int updateRankingKeyword(String keyword) throws SQLException;

	// 메인페이지의 들어갈 이벤트 정보를 받아오는 메서드 (이벤트 캐러셀)
	public List<EventVO> selectCarousel() throws SQLException;

	// 이벤트 번호를 통해 이벤트 정보를 받아오는 메서드 (이벤트 참여)
	public EventVO selectOneEvent(String seq_event) throws SQLException;

	// 판매순으로 정렬한 물품 데이터 DB에서 불러오기
	public List<ProductVO> selectBestCategoryOrder(String category) throws SQLException;

	// 사용자가 select를 선택했을 때 검색해주는 메서드 (제품 검색 - select)
	List<ProductVO> searchProductSelect(String keyword, String select, String type) throws SQLException;

	// 검색한 물품을 판매순으로 정렬해주는 메서드 (제품검색 - select) 
	public List<ProductVO> selectBestOrder(String keyword, String type) throws SQLException;

	// 검색한 물품을 인기순(찜)으로 정렬해주는 메서드 (제품검색 - select) 
	public List<ProductVO> selectFavOrder(String keyword, String type) throws SQLException;

	// 로컬스토리지에서 받은 페이지 방문 기록값으로 디비에서 해당 제품들을 받아오는 메서드(최근 본 제품)
	public List<ProductVO> selectHistoryItem(String history) throws SQLException;
	
	//////////////////////////////////////////////////////////////////////////박수빈:끝/////

	
}
