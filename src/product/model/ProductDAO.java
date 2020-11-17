package product.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.*;

import javafx.geometry.VPos;


public class ProductDAO implements InterProductDAO {

	
	private DataSource ds; 
	
	private Connection conn;
	
	private PreparedStatement pstmt;
	
	private ResultSet rs;
	
	
	
	public ProductDAO() {
		try {
			
			Context initContext = new InitialContext(); // import javax.naming 
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			
			ds = (DataSource)envContext.lookup("jdbc/semi_oracle"); 
			
			
			}catch(NamingException e) {
				e.printStackTrace();
				
			}
	}
	
	// 자원반납
	
	private void close() {
	      try {
	         if(rs != null)    {rs.close(); rs=null;}
	         if(pstmt != null) {pstmt.close(); pstmt=null;}
	         if(conn != null)  {conn.close(); conn=null;}
	      } catch(SQLException e) {
	         e.printStackTrace();
	      }
	}

	
	
	// 제품 페이지에 보여지는 상품이미지 파일명을 모두 조회(select) 하는 메서드
	
	@Override
	public List<ProductVO> selectAll(String fk_category) throws SQLException {
		
		List<ProductVO> productList = new ArrayList<>();
			
		try {
		
		conn = ds.getConnection();
		
		String sql = "select productid, productname, fk_category, character, price, imgfilename \n"+
				"from product A\n"+
				"JOIN productoption B\n"+
				"on A.productid = B.fk_productid\n"+
				"where fk_category = ?";
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, fk_category);
		
		rs = pstmt.executeQuery();
		
		while(rs.next()){
			
			ProductVO pvo = new ProductVO();
			
			pvo.setProductid(rs.getString(1));
			pvo.setProductname(rs.getString(2));
			pvo.setFk_category(rs.getString(3));
			pvo.setCharacter(rs.getString(4));
			pvo.setPrice(rs.getInt(5));		
			pvo.setImgfilename(rs.getString(6));
			
			
						
			productList.add(pvo);
			
		}// end of while -----------------------------
		
		}finally {
			close();
		}
		
		return productList; 
	}

	
	
	
	
	
	///////////////////////////////////////////////////////////////////////
	
	//고객이 선택한 상품을 조회하는 (select) 메서드
	@Override
	public List<ProductVO> selectOne(String productid) throws SQLException {
		
		List<ProductVO> productList = new ArrayList<>();
		
		try {
		
		conn = ds.getConnection();
		
		String sql = "select productid, productname, fk_category, character, price, imgfilename, carouselimg, detailimg, color, productserialid\n"+
				"from product A\n"+
				"JOIN productoption B\n"+
				"on A.productid = B.fk_productid\n"+
				"where productid = ? ";
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, productid);
		
		rs = pstmt.executeQuery();
		
		while(rs.next()){
			
			ProductVO pvo = new ProductVO();
			
			pvo.setProductid(rs.getString(1));
			pvo.setProductname(rs.getString(2));
			pvo.setFk_category(rs.getString(3));
			pvo.setCharacter(rs.getString(4));
			pvo.setPrice(rs.getInt(5));		
			pvo.setImgfilename(rs.getString(6));
			pvo.setCarouselimg(rs.getString(7));
			pvo.setDetailimg(rs.getString(8));
			pvo.getPovo().setColor(rs.getString(9));
			pvo.getPovo().setProductserialid(rs.getString(10));
			
			
			productList.add(pvo);
			
		}// end of while -----------------------------
		
		}finally {
			close();
		}
		
		return productList; 
	}

	
	//////////////////////////////////////////////////////////////////////////박수빈:시작/////
	
	// 키워드로 물품을 검색해서 List에 받아오는 메서드(제품 검색)
	@Override
	public List<ProductVO> searchProductKeyword(String keyword, String type) throws SQLException {
		
		List<ProductVO> pList = new ArrayList<ProductVO>();
		ProductVO pvo = null;

		try {
			
			conn = ds.getConnection();
			
			String sql = "select productid, productname, fk_category, character, price, imgfilename \n"+
					"from product\n";

			if ("rank".equals(type)) {
				sql += "where lower(character) like '%' || lower(?) || '%' ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, keyword);
				
			}else if ("search".equals(type)) {
				sql += "where lower(productid) like '%' || lower(?) || '%' or lower(productname) like '%' || lower(?) || '%' ";

				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setString(2, keyword);
			}
			
			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
				pvo = new ProductVO();
				
				pvo.setProductid(rs.getString(1));
				pvo.setProductname(rs.getString(2));
				pvo.setFk_category(rs.getString(3));
				pvo.setCharacter(rs.getString(4));
				pvo.setPrice(rs.getInt(5));
				pvo.setImgfilename(rs.getString(6));
				
				pList.add(pvo);
			}
			
		} finally {
			close();
		}
		
		return pList;
	}
	
	// 사용자가 select를 선택했을 때 검색해주는 메서드 (제품 검색)
	@Override
	public List<ProductVO> searchProductSelect(String keyword, String select, String type) throws SQLException {
		
		List<ProductVO> pList = new ArrayList<ProductVO>();
		ProductVO pvo = null;
		
		switch (select) {
			case "highPrice":
				select = " order by price desc ";
				break;
				
			case "lowPrice":
				select = " order by price ";
				break;
				
			case "favorite":
				select = "";
				break;
				
			case "sale":
				select = "";
				break;
		}

		try {
			
			conn = ds.getConnection();
			
			String sql = "select productid, productname, fk_category, character, price, imgfilename \n"+
					"from product\n";

			if ("rank".equals(type)) {
				sql += "where lower(character) like '%' || lower(?) || '%' ";
				sql += select;
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, keyword);
				
			}else if ("search".equals(type)) {
				sql += "where lower(productid) like '%' || lower(?) || '%' or lower(productname) like '%' || lower(?) || '%' ";
				sql += select;

				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setString(2, keyword);
			}

			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
				pvo = new ProductVO();
				
				pvo.setProductid(rs.getString(1));
				pvo.setProductname(rs.getString(2));
				pvo.setFk_category(rs.getString(3));
				pvo.setCharacter(rs.getString(4));
				pvo.setPrice(rs.getInt(5));
				pvo.setImgfilename(rs.getString(6));
				
				pList.add(pvo);
			}
			
		} finally {
			close();
		}
		
		return pList;
	}

	// 검색한 키워드 DB에 cnt + 1 해주는 메서드(제품 검색)
	@Override
	public int updateRankingKeyword(String keyword) throws SQLException {
		
		int result = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "update keywordsearch set searchcnt= searchcnt + 1\n"+
					"where keyword= ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, keyword);
			
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return result;
	}

	// 메인페이지의 들어갈 이벤트 정보를 받아오는 메서드 (이벤트 캐러셀)
	@Override
	public List<EventVO> selectCarousel() throws SQLException {
		
		List<EventVO> eventList = new ArrayList<EventVO>();
		
		
		try {
			
			conn = ds.getConnection();
			
			// 이벤트기간이 지나지 않은 진행중인 이벤트만 받아오는 sql문
			String sql = "select seq_event, eventname, fk_productid, startday, endday, carouselimg\n"+
					"from event \n"+
					"WHERE trunc(sysdate) BETWEEN TO_DATE(STARTDAY, 'YY/MM/DD') AND\n"+
					"                                TO_DATE(ENDDAY, 'YY/MM/DD')";
			
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				EventVO evo = new EventVO();
				
				evo.setSeq_event(rs.getInt(1));
				evo.setEventname(rs.getString(2));
				evo.setFk_productid(rs.getString(3));
				evo.setStartday(rs.getString(4));
				evo.setEndday(rs.getString(5));
				evo.setCarouselimg(rs.getString(6));

				eventList.add(evo);
				
			}// end of while -----------------------------
			
			}finally {
				close();
			}
		
		return eventList;
	}

	// 이벤트 번호를 통해 이벤트 정보를 받아오는 메서드 (이벤트 참여)
	@Override
	public EventVO selectOneEvent(String seq_event) throws SQLException {

		EventVO evo = null;
		
		try {
			
			conn = ds.getConnection();
			
			// 이벤트기간이 지나지 않은 진행중인 이벤트만 받아오는 sql문
			String sql = "select seq_event, eventname, fk_productid, startday, endday, carouselimg \n"+
					"from event\n"+
					"where SEQ_EVENT = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, seq_event);

			rs = pstmt.executeQuery();
			
			if(rs.next()){
				
				evo = new EventVO();
				
				evo.setSeq_event(rs.getInt(1));
				evo.setEventname(rs.getString(2));
				evo.setFk_productid(rs.getString(3));
				evo.setStartday(rs.getString(4));
				evo.setEndday(rs.getString(5));
				evo.setCarouselimg(rs.getString(6));

			}// end of while -----------------------------
			
			}finally {
				close();
			}
		
		return evo;
	}

	// 판매순으로 정렬한 물품 데이터 DB에서 불러오기
	@Override
	public List<ProductVO> selectBestCategoryOrder(String category) throws SQLException {
		
		List<ProductVO> pvoList = new ArrayList<>();

		try {
			
			conn = ds.getConnection();
			
			String sql = "select productid, productname, fk_category, character, price, imgfilename, volume\n"+
					"from\n"+
					"(\n"+
					"    select fk_productid,  sum(volume) as volume\n"+
					"    from PURCHASEdetail\n"+
					"    group by fk_productid\n"+
					") C\n"+
					"inner join product P\n"+
					"on C.fk_productid = P.productid\n"+
					" where fk_category = ? "+
					"order by volume desc";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, category);
			
			rs = pstmt.executeQuery();

			int cnt = 0;
			while(rs.next()){
				
				// 인기순 최대 3위까지 받아야 하기때문에 3개만 list에 넣어줌 
				if (cnt == 3) {
					break;
				}
				
				ProductVO pvo = new ProductVO();
				
				pvo.setProductid(rs.getString(1));
				pvo.setProductname(rs.getString(2));
				pvo.setFk_category(rs.getString(3));
				pvo.setCharacter(rs.getString(4));
				pvo.setPrice(rs.getInt(5));		
				pvo.setImgfilename(rs.getString(6));
				pvo.setSale(rs.getInt(7));
				
				pvoList.add(pvo);
				
				cnt++;
			}// end of while -----------------------------

		}finally {
			close();
		}
		
		return pvoList;
	}

	// 검색한 물품을 판매순으로 정렬해주는 메서드 (제품검색 - select) 
	@Override
	public List<ProductVO> selectBestOrder(String keyword, String type) throws SQLException {
		
		List<ProductVO> pList = new ArrayList<ProductVO>();
		ProductVO pvo = null;

		try {
			
			conn = ds.getConnection();
			
			String sql = "select productid, productname, fk_category, character, price, imgfilename, volume\n"+
					"from\n"+
					"(\n"+
					"    select fk_productid,  sum(volume) as volume\n"+
					"    from PURCHASEdetail\n"+
					"    group by fk_productid\n"+
					") C\n"+
					"inner join product P\n"+
					"on C.fk_productid = P.productid\n";

			if ("rank".equals(type)) {
				sql += "where lower(character) like '%' || lower(?) || '%' ";
				sql += "order by volume desc";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, keyword);

			}else if ("search".equals(type)) {
				sql += "where lower(productid) like '%' || lower(?) || '%' or lower(productname) like '%' || lower(?) || '%' ";
				sql += "order by volume desc";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setString(2, keyword);

			}
			
			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
				pvo = new ProductVO();
				
				pvo.setProductid(rs.getString(1));
				pvo.setProductname(rs.getString(2));
				pvo.setFk_category(rs.getString(3));
				pvo.setCharacter(rs.getString(4));
				pvo.setPrice(rs.getInt(5));
				pvo.setImgfilename(rs.getString(6));
				
				pList.add(pvo);
			}
			
		} finally {
			close();
		}
		
		return pList;
	}

	// 검색한 물품을 인기순(찜)으로 정렬해주는 메서드 (제품검색 - select) 
	@Override
	public List<ProductVO> selectFavOrder(String keyword, String type) throws SQLException {

		List<ProductVO> pList = new ArrayList<ProductVO>();
		ProductVO pvo = null;

		try {
			
			conn = ds.getConnection();
			
			String sql = "select productid, productname, fk_category, character, price, imgfilename, status\n"+
					"from\n"+
					"(\n"+
					"    select fk_productid, sum(status) as status\n"+
					"from likeproduct\n"+
					"group by fk_productid\n"+
					") C\n"+
					"inner join product P\n"+
					"on C.fk_productid = P.productid\n";
			
			if ("rank".equals(type)) {
				sql += "where lower(character) like '%' || lower(?) || '%' ";
				sql += "order by status desc";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, keyword);

			}else if ("search".equals(type)) {
				sql += "where lower(productid) like '%' || lower(?) || '%' or lower(productname) like '%' || lower(?) || '%' ";
				sql += "order by status desc";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setString(2, keyword);

			}
			
			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
				pvo = new ProductVO();
				
				pvo.setProductid(rs.getString(1));
				pvo.setProductname(rs.getString(2));
				pvo.setFk_category(rs.getString(3));
				pvo.setCharacter(rs.getString(4));
				pvo.setPrice(rs.getInt(5));
				pvo.setImgfilename(rs.getString(6));
				
				pList.add(pvo);
			}
			
		} finally {
			close();
		}
		
		return pList;
		
	}
	
	
	//////////////////////////////////////////////////////////////////////////박수빈:끝/////
	
	
	
	
	
	
	
	
	
	

}