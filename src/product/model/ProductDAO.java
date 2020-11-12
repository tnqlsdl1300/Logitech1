package product.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.*;


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
				System.out.println("search sql문 들어옴");
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
	
	
	//////////////////////////////////////////////////////////////////////////박수빈:끝/////
	
	
	
	
	
	
	
	
	
	

}