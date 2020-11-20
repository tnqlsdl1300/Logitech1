package cs.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import member.model.MemberVO;

public interface InterCutomCenterDAO {
	
	// cs 일대일 문의 메서드(일대일 문의 사항의 정보를 DB에 넣는다.)
	int submitoneQuery(OneQueryVO onequeryvo)  throws SQLException;
	
	// cs 로그인한 사용자의 일대일문의 내역 조회하는 메소드
	List<OneQueryVO> getmyoq(MemberVO mvo) throws SQLException;
	
	// cs 내가 문의한 글을 가져오는 메소드 
	OneQueryVO getoqvo(String seq_oq) throws SQLException;
	
	// cs oq 수정하기
	int modifyoq(Map<String, String> paraMap) throws SQLException;

	// oq 지우기
	int deloq(String seq_oq) throws SQLException;
	
	// pagefaq list 가져오기
	List<FaqVO> selectPagingFaq(Map<String, String> paraMap) throws SQLException;
	
	// 페이징처리를 위해서 FAQ에 대한 총페이지 개수 알아오기(select)
	int getTotalPage(Map<String, String> paraMap) throws SQLException;
	
	// 주 카테고리에서 서브 카테고리를 얻어오는 메소드
	List<Sub_categoryVO> getSub_Category(String category) throws SQLException;
	
	// ================== 검색건수 가져오기 ====================== //
	int getSearchResult(Map<String, String> paraMap) throws SQLException;
	
	// ================== 카테고리 가져오기 ====================== //
	List<CategoryVO> getCategory()throws SQLException;
	

	

	
	
}
