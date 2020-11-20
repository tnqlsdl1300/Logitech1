package cs.model;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import member.model.MemberVO;
import util.security.AES256;
import util.security.SecretMyKey;

public class CustomCenterDAO implements InterCutomCenterDAO {
	
	private DataSource ds;
	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	// 기본생성자
	public CustomCenterDAO() {
		Context initContext;
		try {
			initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/semi_oracle");

			// SecretMyKey.KEY 은 내가 만든 비밀키 이다.
			aes = new AES256(SecretMyKey.KEY);

		} catch (NamingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
	
	
	// 사용한 자원을 반납하는 close() 메서드 생성하기
	private void close() {
	      try {
	         if(rs != null)    {rs.close(); rs=null;}
	         if(pstmt != null) {pstmt.close(); pstmt=null;}
	         if(conn != null)  {conn.close(); conn=null;}
	      } catch(SQLException e) {
	         e.printStackTrace();
	      }
	}

	// 일대일 문의 메서드(일대일 문의 사항의 정보를 DB에 넣는다.)
	@Override
	public int submitoneQuery(OneQueryVO onequeryvo) throws SQLException {
		int result=0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " insert into onequery (SEQ_OQ, FK_MEMBERNO,  category, TITLE, CONTENT, answerform, WRITEDAY, ANSWERSTATUS) "+
					" values (ONEQUERY_SEQ.nextval, ?, ?, ?, ?, ?,default,default)" ;
						
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, onequeryvo.getFk_memberno());
			pstmt.setString(2, onequeryvo.getCategory());	
			pstmt.setString(3, onequeryvo.getTitle());
			pstmt.setString(4, onequeryvo.getContent());		
			pstmt.setString(5, onequeryvo.getAnswerform());
			
			result = pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		
		return result;
	}

	
	@Override
	public List<OneQueryVO> getmyoq(MemberVO mvo) throws SQLException {
		
		List<OneQueryVO> oqlist = new ArrayList<OneQueryVO>();
		
		try {
			conn = ds.getConnection();
			
			// 6개월 이내에 문의한 내용만 보여주도록 select
			String sql = " select category, title, content, answerform, to_char(writeday, 'yyyy-mm-dd') as writeday, answerstatus, seq_oq, months_between(sysdate, writeday) from onequery "+
					" where FK_MEMBERNO= ? and months_between(sysdate, writeday) < '6'";
						
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mvo.getMemberno());
			 
	//		System.out.println("memberDAO 클래스 344 line 회원번호 값"+mvo.getMemberno());
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				OneQueryVO oqvo = new OneQueryVO();
				oqvo.setCategory(rs.getString(1));
				oqvo.setTitle(rs.getString(2));
				oqvo.setContent(rs.getString(3));
				oqvo.setAnswerform(rs.getString(4));
				oqvo.setWriteday(rs.getString(5));
				oqvo.setAnswerstatus(rs.getString(6));
				oqvo.setSeq_eq(rs.getString(7));
				
				
		//		System.out.println("memberDAO 클래스 360 line writeday값"+writeday);
				// 왜 2번만 나오지?? 행이 3개라서 3개가 보여져야함.
				oqlist.add(oqvo);
			} // end of while-------------------------------------
			
			
		} finally {
			close();
		}
		
		return oqlist;
	}

	@Override
	public OneQueryVO getoqvo(String seq_oq) throws SQLException {
		
		OneQueryVO oqvo =null;
		
		try {
			conn = ds.getConnection();
			
			
			// seq_oq로 select
			String sql = " select  fk_memberno, category, title, content, answerform, to_char(writeday, 'yyyy-mm-dd') as writeday, answerstatus "+
					" from onequery "+
					" where seq_oq= ? ";
						
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, seq_oq);
			 

			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				oqvo = new OneQueryVO();
				oqvo.setSeq_eq(rs.getString(1));
				oqvo.setCategory(rs.getString(2));
				oqvo.setTitle(rs.getString(3));
				oqvo.setContent(rs.getString(4));
				oqvo.setAnswerform(rs.getString(5));
				oqvo.setWriteday(rs.getString(6));
				oqvo.setAnswerstatus(rs.getString(7));
				
			} // end of if
			
		} finally {
			close();
		}
		
		
		return oqvo;
	}

	@Override
	public int modifyoq(Map<String, String> paraMap) throws SQLException {
		
		int n =0;
		String category=paraMap.get("category");
		String title=paraMap.get("title");
		String content=paraMap.get("content");
		String anform=paraMap.get("anform");
		String seq_oq=paraMap.get("seq_oq");
		
		
	
		try {
			conn = ds.getConnection();
			
			
			// 
			String sql = " update onequery "+
					" set category= ? , "+
					" title = ? , "+
					" content = ? , "+
					" answerform = ? , "+
					" writeday = default "+
					" where seq_oq = ? ";
						
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, category);
			pstmt.setString(2, title);
			pstmt.setString(3, content);
			pstmt.setString(4, anform);
			pstmt.setString(5, seq_oq);
			 			
			n=pstmt.executeUpdate();
			
			if(n == 1) {
				conn.setAutoCommit(true);
			}
			

			
		} finally {
			close();
		}
		
		
		return n;
	}

	@Override
	public int deloq(String seq_oq) throws SQLException {
	
		int n=0;

		try {
			conn = ds.getConnection();
			
			
			// 
			String sql = " delete from onequery "+
					" where seq_oq = ? ";
						
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, seq_oq);
			 			
			n=pstmt.executeUpdate();
			
			if(n == 1) {
				conn.setAutoCommit(true);
			}
	
			
		} finally {
			close();
		}
		
		
		return n;
	}
	
	
	// pagefaq list 가져오기
	@Override
	public List<FaqVO> selectPagingFaq(Map<String, String> paraMap) throws SQLException{
		
		List<FaqVO> faqList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			
			String sql = "select seq_faq, category, sub_category, title, content "+
					"from "+
					"( \n"+
					"    select rownum AS rno, seq_faq, category, sub_category, title, content "+
					"    from \n"+
					"    ( \n"+
					"        select seq_faq, category, sub_category, title, content "+
					"        from faq ";
			
			
			String searchWord = paraMap.get("searchWord");
			String searchSub = paraMap.get("searchSub");
			String searchSubcate = paraMap.get("searchSubcate");
			
			
			
			// 검색바에서만 검색했을때
			if( (searchWord != null && !searchWord.trim().isEmpty() ) && !(searchSub != null && !searchSub.trim().isEmpty() ) && !(searchSubcate != null && !searchSubcate.trim().isEmpty()) ) {
				
				sql += " where title like '%' || ? || '%' or sub_category like '%' || ? || '%' or category like '%' || ? || '%' ";
			} 
			
			
			// 사이브 바의 a태그를 클릭했을때
			else if( !(searchWord != null && !searchWord.trim().isEmpty() ) && (searchSub != null && !searchSub.trim().isEmpty() ) && !(searchSubcate != null && !searchSubcate.trim().isEmpty())) {
				
				sql += " where category like '%' || ? || '%' ";
				
				System.out.println("사이드바로 검색했을 경우 ");
				
			}
			
			// 하위 카테고리 버튼을 눌렀을때
			else if (!(searchWord != null && !searchWord.trim().isEmpty() ) && !(searchSub != null && !searchSub.trim().isEmpty() ) && (searchSubcate != null && !searchSubcate.trim().isEmpty()))  {
				sql += " where sub_category like '%' || ? || '%' ";
				
				System.out.println("하위버튼을 클릭했을때");
			}
			
			// 메인카테고리에서 하위 카테고리를 클릭했을때
			else if ( (searchSub != null && !searchSub.trim().isEmpty()) && (searchSubcate != null && !searchSubcate.trim().isEmpty())) {
				sql += " where category like '%' || ? || '%' and sub_category like '%' || ? || '%' ";
			}
			
			
			// 검색어가 없을때
			else {
				System.out.println("검색어가 없는 경우");
			}
			
			
			
			sql +=" ) V \n"+
					") T\n"+
					" where rno between ? and ? ";
			
			
			pstmt = conn.prepareStatement(sql);

			int currentShowPageNo = Integer.parseInt( paraMap.get("currentShowPageNo") );
			int sizePerPage = Integer.parseInt( paraMap.get("sizePerPage") );
			

			// 검색바에서 검색했을때
			if( (searchWord != null && !searchWord.trim().isEmpty() ) && !(searchSub != null && !searchSub.trim().isEmpty() ) && !(searchSubcate != null && !searchSubcate.trim().isEmpty()) ) {
				pstmt.setString(1, searchWord);
				pstmt.setString(2, searchWord);
				pstmt.setString(3, searchWord);
				
				pstmt.setInt(4, (currentShowPageNo * sizePerPage) - (sizePerPage - 1)); // 공식
				pstmt.setInt(5, (currentShowPageNo * sizePerPage)); // 공식 
			}
			
			// 사이바 태그에서 검색했을때
			else if (!(searchWord != null && !searchWord.trim().isEmpty() ) && (searchSub != null && !searchSub.trim().isEmpty() ) && !(searchSubcate != null && !searchSubcate.trim().isEmpty())) {
				pstmt.setString(1, searchSub);
				pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1)); // 공식
				pstmt.setInt(3, (currentShowPageNo * sizePerPage)); // 공식 
			}
			
			// 하위 카테고리를 눌렀을때
			else if (!(searchWord != null && !searchWord.trim().isEmpty() ) && !(searchSub != null && !searchSub.trim().isEmpty() ) && (searchSubcate != null && !searchSubcate.trim().isEmpty())) {
				pstmt.setString(1, searchSubcate);
				pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1)); // 공식
				pstmt.setInt(3, (currentShowPageNo * sizePerPage)); // 공식 
			}
			
			// 메인카테고리에서 하위 카테고리를 클릭했을때
			else if ( (searchSub != null && !searchSub.trim().isEmpty()) && (searchSubcate != null && !searchSubcate.trim().isEmpty())) {
				sql += " where category like '%' || ? || '%' and sub_category like '%' || ? || '%' ";
				pstmt.setString(1, searchSub);
				pstmt.setString(2, searchSubcate);
				pstmt.setInt(3, (currentShowPageNo * sizePerPage) - (sizePerPage - 1)); // 공식
				pstmt.setInt(4, (currentShowPageNo * sizePerPage)); // 공식 
			}
			
			// 검색어가 없을때
			else  {
				pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1)); // 공식
				pstmt.setInt(2, (currentShowPageNo * sizePerPage)); // 공식 
			}
			
			
			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {  
			   	
				FaqVO faqvo = new FaqVO();
				
				faqvo.setSeq_faq(rs.getString(1));
				faqvo.setCategory(rs.getString(2));
				faqvo.setSuq_category(rs.getString(3));
				faqvo.setTitle(rs.getString(4));
				faqvo.setContent(rs.getNString(5));
		
				faqList.add(faqvo);
			}
			
		}
		 finally {
			close();
		}		
		
		return faqList;	
		
	
	}
	// 페이징처리를 위해서 전체 faq에 대한 총페이지 개수 알아오기(select) 
		@Override
		public int getTotalPage(Map<String, String> paraMap) throws SQLException {

			int totalPage = 0;
			
			try {
				conn = ds.getConnection();
				
				String sql = " select ceil( count(*)/ 5 ) "
						   + " from faq ";
						    
				
				String searchWord = paraMap.get("searchWord");
				String searchSub = paraMap.get("searchSub");
				String searchSubcate = paraMap.get("searchSubcate");
				
				// 검색바에서만 검색했을때
				if( (searchWord != null && !searchWord.trim().isEmpty() ) && !(searchSub != null && !searchSub.trim().isEmpty() ) && !(searchSubcate != null && !searchSubcate.trim().isEmpty()) ) {
					
					sql += " where title like '%' || ? || '%' or sub_category like '%' || ? || '%' or category like '%' || ? || '%' ";
					
				} 
				
				// 사이브 바의 a태그를 클릭했을때
				else if( !(searchWord != null && !searchWord.trim().isEmpty() ) && (searchSub != null && !searchSub.trim().isEmpty() ) && !(searchSubcate != null && !searchSubcate.trim().isEmpty())) {
					
					sql += " where category like '%' || ? || '%' ";
					System.out.println("side bar로 검색하셨습니다.");
					
				}
				// 하위 카테고리 버튼을 눌렀을때
				else if (!(searchWord != null && !searchWord.trim().isEmpty() ) && !(searchSub != null && !searchSub.trim().isEmpty() ) && (searchSubcate != null && !searchSubcate.trim().isEmpty()))  {
					sql += " where sub_category like '%' || ? || '%' ";
				}
				
				// 메인카테고리에서 하위 카테고리를 클릭했을때
				else if ( (searchSub != null && !searchSub.trim().isEmpty()) && (searchSubcate != null && !searchSubcate.trim().isEmpty())) {
					
					sql += " where category like '%' || ? || '%' and sub_category like '%' || ? || '%' ";
					
				}
				
				// 검색어가 없을때
				else {
					
				}
			
				
				pstmt = conn.prepareStatement(sql);
				
				
				// 검색바에서 검색했을때
				if( (searchWord != null && !searchWord.trim().isEmpty() ) && !(searchSub != null && !searchSub.trim().isEmpty() ) && !(searchSubcate != null && !searchSubcate.trim().isEmpty()) ) {
					pstmt.setString(1, searchWord);
					pstmt.setString(2, searchWord);
					pstmt.setString(3, searchWord);
					
				}
				
				
				// 사이바 태그에서 검색했을때
				else if ( !(searchWord != null && !searchWord.trim().isEmpty()) && (searchSub != null && !searchSub.trim().isEmpty()) && !(searchSubcate != null && !searchSubcate.trim().isEmpty())) {
					pstmt.setString(1, searchSub);
			
				}
				
				
				// 하위 카테고리를 눌렀을때
				else if (!(searchWord != null && !searchWord.trim().isEmpty() ) && !(searchSub != null && !searchSub.trim().isEmpty() ) && (searchSubcate != null && !searchSubcate.trim().isEmpty())) {
					pstmt.setString(1, searchSubcate);
					
				}
				
				// 메인카테고리에서 하위 카테고리를 클릭했을때
				else if ( (searchSub != null && !searchSub.trim().isEmpty()) && (searchSubcate != null && !searchSubcate.trim().isEmpty())) {
					
					pstmt.setString(1, searchSub);
					pstmt.setString(2, searchSubcate);
					
				}
				
				// 검색어가 없을때
				else  {
					
				}
					
				rs = pstmt.executeQuery();
				
				rs.next();
				
				totalPage = rs.getInt(1);
				
			} finally {
				close();
			}		
			
			return totalPage;				
			
		}
		
		
		// cs 세부 카테고리 목록을 가져오는 메소드 
		@Override
		public List<Sub_categoryVO> getSub_Category(String category) throws SQLException{
			
			Sub_categoryVO subcategory = null;
			
			
			
			List<Sub_categoryVO> scatelist = new ArrayList<>();
			
			
			
			
			System.out.println("getSub_Category메소드가 실행되었습니다. " );
			
			try {
				conn = ds.getConnection();
				
				String sql= " select sub_category " + 
			                " from faq where category = ? " +
						    " order by 1 desc ";
						    
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, category);
					
				rs = pstmt.executeQuery();
				
			    // commit 안하면 false.
				
				while (rs.next() ) {
					subcategory = new Sub_categoryVO();
					
					subcategory.setSubCategory(rs.getString(1));
					
					scatelist.add(subcategory);
					
				}
				
				
				
			
				
			} finally {
				
				close();
				
			}		
			
			
			
			
			return scatelist;
			
		}

		@Override
		public int getSearchResult(Map<String, String> paraMap) throws SQLException {
			 
			int searchResult =0;
			
			try {
				conn = ds.getConnection();
				
				String sql = " select count(*) "
						   + " from faq ";
						    
				
				String searchWord = paraMap.get("searchWord");
				String searchSub = paraMap.get("searchSub");
				String searchSubcate = paraMap.get("searchSubcate");
				
				// 검색바에서만 검색했을때
				if( (searchWord != null && !searchWord.trim().isEmpty() ) && !(searchSub != null && !searchSub.trim().isEmpty() ) && !(searchSubcate != null && !searchSubcate.trim().isEmpty()) ) {
					
					sql += " where title like '%' || ? || '%' or sub_category like '%' || ? || '%' or category like '%' || ? || '%' ";
				} 
				
				// 사이브 바의 a태그를 클릭했을때
				else if( !(searchWord != null && !searchWord.trim().isEmpty() ) && (searchSub != null && !searchSub.trim().isEmpty() ) && !(searchSubcate != null && !searchSubcate.trim().isEmpty())) {
					
					sql += " where category like '%' || ? || '%' ";
					
				}
				// 하위 카테고리 버튼을 눌렀을때
				else if (!(searchWord != null && !searchWord.trim().isEmpty() ) && !(searchSub != null && !searchSub.trim().isEmpty() ) && (searchSubcate != null && !searchSubcate.trim().isEmpty()))  {
					sql += " where sub_category like '%' || ? || '%' ";
				}
				
				// 메인카테고리에서 하위 카테고리를 클릭했을때
				else if ( (searchSub != null && !searchSub.trim().isEmpty()) && (searchSubcate != null && !searchSubcate.trim().isEmpty())) {
					
					sql += " where category like '%' || ? || '%' and sub_category like '%' || ? || '%' ";
					
				}
					
				// 아무것도 검색하지 않았을때	
				else {
					
				}
			
				
				pstmt = conn.prepareStatement(sql);
				
				
				// 검색바에서 검색했을때
				if( (searchWord != null && !searchWord.trim().isEmpty() ) && !(searchSub != null && !searchSub.trim().isEmpty() ) && !(searchSubcate != null && !searchSubcate.trim().isEmpty()) ) {
					pstmt.setString(1, searchWord);
					pstmt.setString(2, searchWord);
					pstmt.setString(3, searchWord);
					
				}
				
				// 사이바 태그에서 검색했을때
				else if (!(searchWord != null && !searchWord.trim().isEmpty() ) && (searchSub != null && !searchSub.trim().isEmpty() ) && !(searchSubcate != null && !searchSubcate.trim().isEmpty())) {
					pstmt.setString(1, searchSub);
			
				}
				
				// 하위 카테고리를 눌렀을때
				else if (!(searchWord != null && !searchWord.trim().isEmpty() ) && !(searchSub != null && !searchSub.trim().isEmpty() ) && (searchSubcate != null && !searchSubcate.trim().isEmpty())) {
					pstmt.setString(1, searchSubcate);
					
				}
				
				else if ( (searchSub != null && !searchSub.trim().isEmpty()) && (searchSubcate != null && !searchSubcate.trim().isEmpty())) {
					
					pstmt.setString(1, searchSub);
					pstmt.setString(2, searchSubcate);
					
				}
				
				
				// 검색어가 없을때
				else  {
					
				}
					
				rs = pstmt.executeQuery();
				
				rs.next();
				
				searchResult = rs.getInt(1);
				
			} finally {
				close();
			}		
			
			return searchResult;
		}

		@Override
		public List<CategoryVO> getCategory() throws SQLException {
			
			List<CategoryVO> categorylist = new ArrayList<>();
			
			
			
			try {
				conn = ds.getConnection();
				
				String sql = "select * from faq_category";
						    
				pstmt = conn.prepareStatement(sql);
			
				rs = pstmt.executeQuery();
				
				
				while (rs.next()) {
					
					CategoryVO cetevo = new CategoryVO();
					// System.out.println(rs.getString(1));
					cetevo.setCategory(rs.getString(1));
					categorylist.add(cetevo);
				}
				
				
			} finally {
				close();
			}		
			
			return categorylist;
			
			
		}
}
