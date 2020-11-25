package product.model;

import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.*;

import member.model.PointVO;
import myshop.model.*;



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

	
	
	//////////////////////////////////////////////////////////////////////////임정섭:시작/////
	
	// 제품 페이지에 보여지는 상품이미지 파일명을 모두 조회(select) 하는 메서드
	
	@Override
	public List<ProductVO> selectAll(String fk_category) throws SQLException {
		
		List<ProductVO> productList = new ArrayList<>();
			
		try {
		
		conn = ds.getConnection();
		
		String sql = "select productid, productname, fk_category, character, price, imgfilename \n"+
				"from product \n"+
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
		}catch (SQLException e) {
		}finally {
			close();
		}
		
		return productList; 
	}

	
	
	
	
	
	///////////////////////////////////////////////////////////////////////
	
	//고객이 선택한 상품 1개를 조회하는 (select) 메서드
	@Override
	public List<ProductVO> selectOne(String productid) throws SQLException {
		
		List<ProductVO> productList = new ArrayList<>();
		
		try {
		
		conn = ds.getConnection();
		
		String sql = "select productid, productname, fk_category, character, price, imgfilename, carouselimg, detailimg, color, productserialid\n"+
				"from product A\n"+
				"JOIN productoption B\n"+
				"on A.productid = B.fk_productid\n"+
				"where A.productid = ? "; 
		
		
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, productid);
		//pstmt.setString(2, color);
		
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
			
			
			ProductOptionVO povo = new ProductOptionVO();
			povo.setColor(rs.getString(9));
			
			povo.setProductserialid(rs.getString(10));
			
			pvo.setPovo(povo);
			
			productList.add(pvo);
			
		}// end of while -----------------------------
		
		}catch (SQLException e) {
		    
		
		
		}finally {
			close();
		}
		
		return productList; 
		
	}
	
	
	//고객이 선택한 상품 주문페이지로 이동
	
	@Override
	public List<ProductVO> productPurchase(Map<String, String> paraMap) throws SQLException {
		
		List<ProductVO> purchaseList = new ArrayList<>();
		
		try {
		
		conn = ds.getConnection();
		
		String sql = "select A.productid, A.productname, A.price, A.imgfilename, B.color, B.productserialid\n"+
				"				from product A\n"+
				"				JOIN productoption B\n"+
				"				on A.productid = B.fk_productid\n"+
				"				where A.productid = ? and B.color = ? " ;
		
		/*
		 SELECT a.empno
    , a.ename
    , a.deptno
    , b.dname
    , b.locno
    , c.lname
 FROM emp a
INNER JOIN dept b
   ON a.deptno = b.deptno
INNER JOIN loc c
   ON b.locno = c.locno
WHERE a.sal >= 2000 
		  */
		
		
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, paraMap.get("productid"));
		pstmt.setString(2, paraMap.get("color"));
		
		//pstmt.setString(3, paraMap.get("color"));
		//pstmt.setString(4, paraMap.get("productserialid"));
		
		
		rs = pstmt.executeQuery();
		
		if(rs.next()){
		
		
			
			ProductVO pvo = new ProductVO();
			
			pvo.setProductid(rs.getString(1));
			pvo.setProductname(rs.getString(2));
			pvo.setPrice(rs.getInt(3));
			pvo.setImgfilename(rs.getString(4));
			//pvo.getPovo().setColor(rs.getString(5));
			
			ProductOptionVO povo = new ProductOptionVO();
			
			povo.setColor(rs.getString(5));
			povo.setProductserialid(rs.getString(6));
			
			pvo.setPovo(povo);
			
			purchaseList.add(pvo);
			
			
		}// end of if -----------------------------
		
		}catch (SQLException e) {
	    
		}finally {
			close();
		}
		
		return purchaseList; 
		
	}


	
	
	
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	// 구매창에서 쿠폰을 보여주고 선택한다.
	@Override
	public List<EachCouponVO> selectCoupon(Map<String, String> paraMap) throws SQLException {
		
		
		List<EachCouponVO> couponList = new ArrayList<>();
		
		try {
		
		conn = ds.getConnection();
		
		String sql = "select couponname, discount, minprice, eachcouponcode, fk_memberno\n"+
				"from coupon C\n"+
				"join eachcoupon E\n"+
				"on C.couponcode = E.fk_couponcode\n"+
				"where status = 0 and to_char(endday, 'yyyy-mm-dd') >= to_char(sysdate, 'yyyy-mm-dd')\n"+
				"and fk_memberno = ?";
		
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, paraMap.get("memberno"));
		
		rs = pstmt.executeQuery();
		
		while(rs.next()){
		
			EachCouponVO ecvo = new EachCouponVO();
			
			CouponVO cvo = new CouponVO();
			cvo.setCouponname(rs.getString(1));
			cvo.setDiscount(rs.getInt(2));
			cvo.setMinprice(rs.getInt(3));
			
			ecvo.setEachcouponcode(rs.getString(4));
			ecvo.setFk_memberno(rs.getInt(5));
			ecvo.setCoupvo(cvo);
			
			couponList.add(ecvo);
			
		}// end of if -----------------------------
		
		}catch (SQLException e) {
			
		}finally {
			close();
		}
		
		return couponList;
	}

	
	
	
	
	
	
	
	
	
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////
	//컬러선택
	
	@Override
	public List<ProductVO> selectOneColor(Map<String, String> paraMap) throws SQLException {
		
		List<ProductVO> colorList = new ArrayList<>();
		
		try {
		
		conn = ds.getConnection();
		
		String sql = "select productid, productname, fk_category, character, price, imgfilename, color, productserialid\n"+
				"from product A\n"+
				"JOIN productoption B\n"+
				"on A.productid = B.fk_productid\n"+
				"where A.productid = ? and B.color = ? "; 
		
		
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, paraMap.get("productid"));
		pstmt.setString(2, paraMap.get("color"));
		//pstmt.setString(2, color);
		
		rs = pstmt.executeQuery();
		
		while(rs.next()){
			
			ProductVO pvo = new ProductVO();
			
			pvo.setProductid(rs.getString(1));
			pvo.setProductname(rs.getString(2));
			pvo.setFk_category(rs.getString(3));
			pvo.setCharacter(rs.getString(4));
			pvo.setPrice(rs.getInt(5));		
			pvo.setImgfilename(rs.getString(6));
			
			ProductOptionVO povo = new ProductOptionVO();
			
			povo.setColor(rs.getString(7));
			povo.setProductserialid(rs.getString(8));
			
			pvo.setPovo(povo);
			colorList.add(pvo);
			
		}// end of while -----------------------------
		
		}catch (SQLException e) {
		
		}finally {
			close();
		}
		
		return colorList;
	}


	
	
	
	
	
	
	
	
	
	
////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//장바구니로 보내기
	@Override
	public int intoCart(PurchaseProductVO ppvo) throws SQLException {
	
		int n = 0;
		
		try {
		
		conn = ds.getConnection();
		
		String sql = "insert into cart(seq_cart, fk_productid, price, selectcolor, fk_memberno, cartpronum) "
			     	+ " values(cart_seq.nextval, ?, ?, ?, ?, ?) "; 
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, ppvo.getFk_productid());
		pstmt.setInt(2, ppvo.getPrice());
		pstmt.setString(3, ppvo.getSelectcolor());
		pstmt.setInt(4, 9);
		pstmt.setString(5, ppvo.getCartpronum());
		
		n = pstmt.executeUpdate();
		
		}catch (SQLException e) {
			e.printStackTrace();
			
		}finally {
			close();
		}
		
		return n;
		
	}	
	
	
	
	
	
	
	//////////////////////////////////////////////////////////////////////////임정섭:끝/////
	

	
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
			String sql = "select seq_event, eventname, fk_productid, to_char(stARTDAY, 'YYYY.MM.DD') as startday, to_char(ENDDAY, 'YYYY.MM.DD') as endday, carouselimg\n"+
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
			
			String sql = "select productid, productname, fk_category, character, price, imgfilename, nvl(volume, 0) as volume\n"+
					"from\n"+
					"(\n"+
					"    select fk_productid,  sum(volume) as volume\n"+
					"    from PURCHASEdetail\n"+
					"    group by fk_productid\n"+
					") C\n"+
					"right join product P\n"+
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
			
			String sql = "select productid, productname, fk_category, character, price, imgfilename, nvl(status, 0) as status\n"+
					"from\n"+
					"(\n"+
					"    select fk_productid, sum(status) as status\n"+
					"from likeproduct\n"+
					"group by fk_productid\n"+
					") C\n"+
					"right join product P\n"+
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
	
	// 로컬스토리지에서 받은 페이지 방문 기록값으로 디비에서 해당 제품들을 받아오는 메서드(최근 본 제품)
	@Override
	public List<ProductVO> selectHistoryItem(String history) throws SQLException {
		
		List<ProductVO> pvoList = new ArrayList<ProductVO>();
		
		// 받은 문자값은 맨 앞에 ,가 붙어있으므로 삭제
		String[] historyArr = history.split(",");
		
		try {
			
			conn = ds.getConnection();
			
			////////////////////////////////////////////////////////////
			String sql = "";
			
			for(int i=0; i<historyArr.length; i++) {
				sql += " select productid, productname, fk_category, character, price, imgfilename from product where productid = '"+historyArr[i]+"' ";       
				
				if( i < historyArr.length-1 ) {
					sql += " UNION ALL ";
				}
			}
			/////////////////////////////////////////////////////////////
			
		/*	
			///////////////////////////////////////////////////////////////////////////////////
			String sql = "select productid, productname, fk_category, character, price, imgfilename \n"+
					"from product\n"+
					"where productid in(";
			
					// sql문 내의 in(?) 의 ? 갯수를 정해주는 for문
					for (int i = 0; i < historyArr.length; i++) {
						if (i == historyArr.length-1) {
							// 문자열의 끝일때 ,를 빼고 넣어준다
							sql += "?";
						}else {
							sql += "?, ";
						}

					}
					
			
			sql += ")\n"+
					"ORDER BY decode(productid, ";
			
			// sql문 내의 order by decode(productid, ?, ? ...) 의 ? 갯수를 정해주는 for문
			for (int i = 1; i <= historyArr.length; i++) {
				if (i == historyArr.length) {
					// 문자열의 끝일때 ,를 빼고 넣어준다
					sql += "?, " + i;
				}else {
					sql += "?, " + i + ", ";	
				}
				
			}
			sql += ")";

			pstmt = conn.prepareStatement(sql);
			
			// sql문 내의 in(?) 의 ? 에 데이터를 매칭해주는 for문
			for (int i = 1; i <= historyArr.length; i++) {
				pstmt.setString(i, historyArr[i-1]);
			}
			
			// sql문 내의 order by decode(productid, ?, ? ...) 의 ? 에 데이터를 매칭해주는 for문
			int limit = historyArr.length+1;
			for (int i = historyArr.length+1; i <= limit + historyArr.length-1; i++) {
				pstmt.setString(i, historyArr[i-limit]);
				
			}
            ////////////////////////////////////////////////////////////////////////////////
		*/	

			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			while(rs.next()) {
				
				if (cnt == 20) {
					break;
				}
				
				ProductVO pvo = new ProductVO();
				
				pvo.setProductid(rs.getString(1));
				pvo.setProductname(rs.getString(2));
				pvo.setFk_category(rs.getString(3));
				pvo.setCharacter(rs.getString(4));
				pvo.setPrice(rs.getInt(5));
				pvo.setImgfilename(rs.getString(6));
				
				pvoList.add(pvo);
				
				cnt++;
			}
			
		} finally {
			close();
		}
		
		return pvoList;
	}
	
	// 사용자로부터 받은 키워드로 DB의 제품-특성에서 검색
	@Override
	public String selectLikeItem(Map<String, String> paraMap) throws SQLException {
		
		String productid = null;
		
		try {
			
			conn = ds.getConnection();
			
			// 이벤트기간이 지나지 않은 진행중인 이벤트만 받아오는 sql문
			String sql = "select productid\n"+
					"from product\n"+
					"where fk_category = ? and character like '%' || ? || '%' and character like '%' || ? || '%'";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("ans1"));
			pstmt.setString(2, paraMap.get("ans2"));
			pstmt.setString(3, paraMap.get("ans3"));

			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				// 검색한 결과가 있을 시
				productid = rs.getString(1);
			}
			// 검색한 결과가 없을 시 productid는 초기값인 null을 반환
			
			
			
			}finally {
				close();
			}
		
		return productid;
		
	}
	
	// productid를 통해 DB에서 물품을 검색해주는 메서드
	@Override
	public ProductVO selectLikeItemOne(String productid) throws SQLException {


		ProductVO pvo = new ProductVO();
		
		try {
			
			conn = ds.getConnection();
			
			// 이벤트기간이 지나지 않은 진행중인 이벤트만 받아오는 sql문
			String sql = "select productid, productname, fk_category, character, price, imgfilename\n"+
					"from product\n"+
					"where productid = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, productid);

			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				// 검색한 결과가 있을 시
				pvo.setProductid(rs.getString(1));
				pvo.setProductname(rs.getString(2));
				pvo.setFk_category(rs.getString(3));
				pvo.setCharacter(rs.getString(4));
				pvo.setPrice(rs.getInt(5));
				pvo.setImgfilename(rs.getString(6));
			}
			
			}finally {
				close();
			}
		
		return pvo;
		
	}

	
	//////////////////////////////////////////////////////////////////////////박수빈:끝/////
	
	
	//////////////////////////////////////////////////////////////////////////최은지:시작/////

	   @Override
	   public ArrayList<ProductVO> selectProduct(String userid) throws SQLException {
	      ProductVO product = null;
	      ProductOptionVO productoption = null;
	      
	      ArrayList<ProductVO> likelist = new ArrayList<>();
	      try{
	         
	         conn = ds.getConnection();
	         String sql = "select productid, productname, price, imgfilename, seq_like\n"+
	               "from PRODUCT P\n"+
	               "inner join LIKEPRODUCT L\n"+
	               "on P.productid = L.fk_productid\n"+
	               "where fk_memberno=?\n"+
	               " order by addtime desc ";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, userid);
	         
	         rs = pstmt.executeQuery();
	         
	         while(rs.next()){
	            product = new ProductVO();
	            
	            product.setProductid(rs.getString(1));
	            product.setProductname(rs.getString(2));
	            product.setPrice(rs.getInt(3));
	            product.setImgfilename(rs.getString(4));
	            LikeProductVO lpvo = new LikeProductVO();
	            lpvo.setSeq_like(rs.getInt(5));
	            product.setLpvo(lpvo);
	            likelist.add(product);
	         }
	      }finally {
	         close();
	      }
	      
	      return likelist;
	   }


	   @Override
	   public ArrayList<LikeProductVO> selectOptionProduct(String userid) throws SQLException {
	      
	      ArrayList<LikeProductVO> likeonelist = new ArrayList<>(); 
	      LikeProductVO lpvo = null;
	      
	      try{
	         conn = ds.getConnection();
	         
	         String sql = "select fk_memberno, fk_productid, status\n"+
	               "from likeproduct\n"+
	               "where fk_memberno = ?";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, userid);      
	         
	         rs = pstmt.executeQuery();
	         
	         while(rs.next()){
	            lpvo = new LikeProductVO();
	            lpvo.setFk_memberno(rs.getInt(1));
	            lpvo.setFk_productid(rs.getString(2));
	            lpvo.setStatus(rs.getInt(3));
	            
	            likeonelist.add(lpvo);
	         }
	      }finally {
	         close();
	      }
	      
	      
	      return likeonelist;
	   }

	   @Override
	   public ArrayList<String> selectColorProduct(String fk_productid) throws SQLException {

	      ArrayList<String> templist = new ArrayList<>();
	      String str ="";
	      try{
	         conn = ds.getConnection();
	         
	         String sql = "select color\n"+
	               "from PRODUCT p\n"+
	               "inner join PRODUCTOPTION O \n"+
	               "on p.productid = O.fk_productid\n"+
	               "where productid= ? ";
	               //"inner join LIKEPRODUCT L\n"+
	               //"on P.productid = L.fk_productid\n"+
	               
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, fk_productid);      
	         
	         rs = pstmt.executeQuery();
	         
	         while(rs.next()){
	            templist.add(rs.getString(1));
	         }
	      }finally {
	         close();
	      }
	      return templist;
	   }

	   // 찜목록에 있는 상품 장바구니에 넣어주는 메소드
	   @Override
	   public int insertCart(PurchaseProductVO purchaseProductVO) {
	      int result = 0;
	      try{

	         conn = ds.getConnection();
	         String sql = "insert into CART(SEQ_CART, PRICE, SELECTCOLOR, FK_MEMBERNO, FK_PRODUCTID) values(CART_SEQ.nextval, ?, ?, ?, ?)";
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setInt(1, purchaseProductVO.getPrice());
	         pstmt.setString(2, purchaseProductVO.getSelectcolor());
	         pstmt.setString(3, "9");
	         pstmt.setString(4, purchaseProductVO.getFk_productid());
	         
	         result = pstmt.executeUpdate();
	      }catch(SQLException e){
	                  
	      }finally {
	         close();
	      }
	      return result;
	   }

	   @Override
	   public String selectImgFile(String fk_productid) throws SQLException {
	      String img ="";
	      try{
	         conn = ds.getConnection();
	         
	         String sql = "select distinct imgfilename\n"+
	               "from productoption O\n"+
	               "inner join product P\n"+
	               "on P.productid = O.fk_productid\n"+
	               "where P.productid = ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, fk_productid);      
	         
	         rs = pstmt.executeQuery();
	         
	         if(rs.next()){
	            img = rs.getString(1);
	         }
	         
	      }finally {
	         close();
	      }
	      return img;
	   }

	   @Override
	   public ArrayList<ProductVO> selectCartProduct() throws SQLException {
	      ArrayList<ProductVO> cartprolist = new ArrayList<>();
	      ProductVO pvo = null;
	      
	      try{
	         conn = ds.getConnection();
	         String sql = "select imgfilename, C.fk_productid, productname, selectcolor, C.price, seq_cart  \n"+
	               "from cart C\n"+
	               "inner join product P\n"+
	               "on c.fk_productid = P.productid\n"+
	               "order by C.fk_productid";
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         rs = pstmt.executeQuery();
	         
	         while(rs.next()){
	            pvo = new ProductVO();
	            pvo.setImgfilename(rs.getString(1));
	            //pvo.setProductid(rs.getString(2));
	            PurchaseProductVO pcvo = new PurchaseProductVO();
	            pcvo.setFk_productid(rs.getString(2));
	            
	            pvo.setProductname(rs.getString(3));
	            
	            
	            pcvo.setSelectcolor(rs.getString(4));
	            pcvo.setPrice(rs.getInt(5));
	            pcvo.setSq_cart(rs.getInt(6));
	            pvo.setPcvo(pcvo);
	            
	            cartprolist.add(pvo);
	         }
	         
	      }catch(SQLException e){
	                  
	      }finally {
	         close();
	      }
	      
	      return cartprolist;
	   }

	   @Override
	   public ArrayList<String> selectcolor(String productid) throws SQLException {
	      
	      ArrayList<String> templist = new ArrayList<>();
	      String str ="";
	      try{
	         conn = ds.getConnection();
	         
	         String sql = "select distinct color\n"+
	               "from productoption P\n"+
	               "inner join cart C\n"+
	               "on p.fk_productid = C.fk_productid \n"+
	               "where C.fk_productid = ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, productid);      
	         
	         rs = pstmt.executeQuery();
	         
	         while(rs.next()){
	            templist.add(rs.getString(1));
	         }
	      }finally {
	         close();
	      }
	      return templist;
	   }

	   @Override
	   public void updateOption(String hiddencolor, String hiddennum) throws SQLException {
	      
	      try{

	         conn = ds.getConnection();
	         String sql = "update cart set selectcolor = ? where seq_cart = ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, hiddencolor);
	         pstmt.setString(2, hiddennum);
	         
	         pstmt.executeUpdate();
	      }finally {
	         close();
	      }
	   }

	   @Override
	   public String selectChangeColor(String hiddenseq) throws SQLException {
	      
	      String str ="";
	      try{
	         conn = ds.getConnection();
	         
	         String sql = "select selectcolor\n"+
	               "from cart\n"+
	               "where seq_cart = ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, hiddenseq);      
	         
	         rs = pstmt.executeQuery();
	         
	         if(rs.next()){
	            str = rs.getString(1);
	         }
	      }finally {
	         close();
	      }
	      return str;
	   }

	   @Override
	   public void deleteCart(String seqcart) throws SQLException {

	      try{
	         conn = ds.getConnection();
	         String sql = "delete from cart where seq_cart= ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, seqcart);
	         
	         pstmt.executeUpdate();
	      }catch(SQLException e){
	                  
	      }finally {
	         close();
	      }
	   }

	   @Override
	   public void deleteLikeCart(String string) throws SQLException {
	      
	      try{
	         conn = ds.getConnection();
	         String sql = "delete from likeproduct where seq_like= ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, string);
	         
	         pstmt.executeUpdate();
	      }catch(SQLException e){
	                  
	      }finally {
	         close();
	      }
	      
	   }

	   @Override
	   public ArrayList<PurchaseVO> selectPoint(int usernum) throws SQLException {
	      ArrayList<PurchaseVO> templist = new ArrayList<>();
	      try{
	         conn = ds.getConnection();
	         
	         String sql = "select pointnum, reason, usedpointnum, ordernum, fk_purchaseno, purchaseday\n"+
	               "FROM PURCHASE P\n"+
	               "INNER JOIN TBL_POINT T\n"+
	               "ON P.purchaseno = T.fk_purchaseno\n"+
	               "where fk_memberno = ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setInt(1, usernum);      
	         
	         rs = pstmt.executeQuery();
	         
	         while(rs.next()){
	            PointVO pointvo = new PointVO();
	            pointvo.setPointnum(rs.getInt(1));
	            pointvo.setReason(rs.getString(2));
	            pointvo.setUsedpointnum(rs.getInt(3));
	            PurchaseVO pcvo = new PurchaseVO();
	            pcvo.setOrdernum(rs.getString(4));
	            pointvo.setFk_purchaseno(rs.getInt(5));
	            pcvo.setPurchaseday(rs.getString(6));
	            
	            pcvo.setPointvo(pointvo);
	            templist.add(pcvo);
	         }
	      }finally {
	         close();
	      }
	      return templist;
	   }

	   @Override
	   public String selectUsedPoint(int usernum) throws SQLException {
	      String str ="";
	      try{
	         conn = ds.getConnection();
	         
	         String sql = "select point\n"+
	               "from member\n"+
	               "where memberno= ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setInt(1, usernum);      
	         
	         rs = pstmt.executeQuery();
	         
	         if(rs.next()){
	            str = rs.getString(1);
	         }
	      }finally {
	         close();
	      }
	      return str;
	   }

	   @Override
	   public int getTotalPage(int usernum) throws SQLException {
	      
	      int totalPage = 0;
	      try{
	         conn = ds.getConnection();
	         
	         String sql = "select ceil(count(*)/ 10)\n"+
	               "FROM PURCHASE P\n"+
	               "INNER JOIN TBL_POINT T\n"+
	               "ON P.purchaseno = T.fk_purchaseno\n"+
	               "where fk_memberno = ? ";
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setInt(1, usernum);
	         
	         rs = pstmt.executeQuery();
	         rs.next();
	         
	         totalPage = rs.getInt(1);
	         
	      }finally {
	         close();
	      }
	      
	      return totalPage;
	   }

	   @Override
	   public ArrayList<PurchaseVO> selectPointList(Map<String, String> paraMap) throws SQLException {

	      ArrayList<PurchaseVO> ptlist = new ArrayList<>();
	      
	      try{
	         
	         conn = ds.getConnection();
	         
	         String sql = "select pointnum, reason, usedpointnum, ordernum, purchaseday\n"+
	               "FROM \n"+
	               "(\n"+
	               "    select rownum as RNO, pointnum, reason, usedpointnum, ordernum, purchaseday\n"+
	               "    from PURCHASE P\n"+
	               "    INNER JOIN TBL_POINT T\n"+
	               "    ON P.purchaseno = T.fk_purchaseno\n"+
	               "    where fk_memberno = ? \n"+
	               ") V\n"+
	               "where RNO between ? and ?";
	         pstmt = conn.prepareStatement(sql);
	         
	         int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo")); 
	         int sizePerPage = 10;
	         
	         pstmt.setString(1, paraMap.get("usernum"));
	         pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage -1));
	         pstmt.setInt(3, (currentShowPageNo * sizePerPage));
	         
	         rs = pstmt.executeQuery();
	         
	         while(rs.next()){
	            PointVO pointvo = new PointVO();
	            pointvo.setPointnum(rs.getInt(1));
	            pointvo.setReason(rs.getString(2));
	            pointvo.setUsedpointnum(rs.getInt(3));
	            PurchaseVO pcvo = new PurchaseVO();
	            pcvo.setOrdernum(rs.getString(4));
	            pcvo.setPurchaseday(rs.getString(5));
	            
	            pcvo.setPointvo(pointvo);
	            ptlist.add(pcvo);
	         }
	         
	      }finally {
	         close();
	      }
	      return ptlist;
	   }

	   @Override
	   public String selectSumPoint(int usernum) throws SQLException {

	      String totalpt = "";
	      try{
	         conn = ds.getConnection();
	         
	         String sql = "select sum(pointnum)\n"+
	               "from PURCHASE P\n"+
	               "INNER JOIN TBL_POINT T\n"+
	               "ON P.purchaseno = T.fk_purchaseno\n"+
	               "where fk_memberno = ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setInt(1, usernum);
	         
	         rs = pstmt.executeQuery();
	         rs.next();
	         
	         totalpt = rs.getString(1);
	         
	      }finally {
	         close();
	      }
	      
	      return totalpt;
	   }
	
	//////////////////////////////////////////////////////////////////////////최은지:끝/////

	
	
	
	
	
	

}