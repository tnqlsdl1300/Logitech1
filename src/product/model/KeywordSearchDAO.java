package product.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class KeywordSearchDAO implements InterKeywordSearch {

	private DataSource ds;
	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	// 기본생성자
	public KeywordSearchDAO() {
		Context initContext;
		try {
			initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/semi_oracle");
			
		} catch (NamingException e) {
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

	// 인기순위를 받아오는 메서드
	@Override
	public List<KeywordSearchVO> selectRanking() throws SQLException {
		
		List<KeywordSearchVO> rankingList = new ArrayList<KeywordSearchVO>();
		KeywordSearchVO keyword = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select keyword, searchcnt\n"+
					"from keywordsearch\n"+
					"order by searchcnt desc";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			// 행이 있으면(중복) true, 없으면(중복x) false 반환
			int cnt = 0;
			while(rs.next()) {
				
				if (cnt == 10) {
					break;
				}
				
				keyword = new KeywordSearchVO();
				keyword.setKeyword(rs.getString(1));
				keyword.setSearchcnt(rs.getInt(2));
				
				rankingList.add(keyword);
				cnt++;
			}
			
		} finally {
			close();
		}
		
		return rankingList;
	}
	
	
	
	
	
	
	
}
