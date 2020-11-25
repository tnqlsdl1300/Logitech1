package product.model;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import myshop.model.EachCouponVO;
import myshop.model.PurchaseVO;



public interface InterProductDAO {
	
	//////////////////////////////////////////////////////////////////////////임정섭:시작/////

	//DTO(data tranfer object) 데이터 전송객체 == VO(value object)
	//어떤 값을 담아서 보내야하는 공통점. 대부분 같다고 본다.
	public List<ProductVO> selectAll(String fk_category) throws SQLException;

	
	//고객이 선택한 상품에 대한 상세제품들을 조회하는 (select) 메서드
	public List<ProductVO> selectOne(String productid) throws SQLException;


	//고객이 선택한 상품을 구매 페이지에서 보여주기
	public List<ProductVO> productPurchase(Map<String, String> paraMap) throws SQLException;

	//색상 선택하고 보여주기
	public List<ProductVO> selectOneColor(Map<String, String> paraMap) throws SQLException;
	
	//구매페이지에서 쿠폰 선택하기
	public List<EachCouponVO> selectCoupon(Map<String, String> paraMap) throws SQLException;

	//장바구니로 보내기
	public int intoCart(PurchaseProductVO ppvo) throws SQLException;
	
	//////////////////////////////////////////////////////////////////////////임정섭:끝/////



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
	
	// 사용자로부터 받은 키워드로 DB의 제품-특성에서 검색해주는 메서드
	public String selectLikeItem(Map<String, String> paraMap) throws SQLException;
	
	// productid를 통해 DB에서 물품을 검색해주는 메서드
	public ProductVO selectLikeItemOne(String productid) throws SQLException;
	
	// 판매순으로 정렬한 각 3개씩의 물품 데이터 DB에서 불러오는 메서드
	public List<ProductVO> selectBest3Items() throws SQLException;
	
	//////////////////////////////////////////////////////////////////////////박수빈:끝/////

	
	//////////////////////////////////////////////////////////////////////////최은지:시작/////
	 // 찜하기 페이지에서 상품 목록을 select 해오는 함수
	   ArrayList<ProductVO> selectProduct(String userid) throws SQLException;

	   // 찜하기 페이지에서 판매 상품 목록을 select 해주는 함수 
	   ArrayList<LikeProductVO> selectOptionProduct(String userid) throws SQLException;

	   // 찜목록에서 해당 제품에 해당하는 옵션(색상)들을 select 해주는 메소드
	   ArrayList<String> selectColorProduct(String fk_productid) throws SQLException;

	   // 찜목록에서 장바구니로 데이터를 insert 해주는 메소드
	   int insertCart(PurchaseProductVO purchaseProductVO) throws SQLException;

	   // 찜목록에서 이미 장바구니에 들어간 상품들의 이미지를 보여주기 위해 조인해서 select 해주는 메소드
	   String selectImgFile(String fk_productid) throws SQLException;

	   // 장바구니 페이지에 들어갔을때 장바구니 테이블에서 데이터를 가져와 insert 해주는 메소드
	   ArrayList<ProductVO> selectCartProduct() throws SQLException;

	   // 찜 목록에서 상품의 옵션을 select 해주는 함수
	   ArrayList<String> selectcolor(String productid) throws SQLException;

	   // 장바구니에서 옵션 색깔을 바꿨을때 업데이트 해주는 함수
	   void updateOption(String hiddencolor, String hiddennum) throws SQLException;

	   // 장바구니에서 옵션 색깔을 변경해주는 함수
	   String selectChangeColor(String hiddenseq) throws SQLException;

	   // 장바구니에서 상품을 삭제하는 함수
	   void deleteCart(String productid) throws SQLException;

	   // 찜 목록 카트에서 찜 목록 삭제 함수
	   void deleteLikeCart(String string) throws SQLException;

	   // 포인트 가져오기 처리
	   ArrayList<PurchaseVO> selectPoint(int usernum) throws SQLException;
	   
	   // 사용된 포인트 처리
	   String selectUsedPoint(int usernum) throws SQLException;
	   
	   // 전체 페이지 수 처리
	   int getTotalPage(int usernum) throws SQLException;

	   // 포인트 출력 페이징 처리
	   ArrayList<PurchaseVO> selectPointList(Map<String, String> paraMap) throws SQLException;

	   // 해당 유저의 전체 포인트 가져오기
	   String selectSumPoint(int usernum) throws SQLException;

	//////////////////////////////////////////////////////////////////////////최은지:끝/////

}
