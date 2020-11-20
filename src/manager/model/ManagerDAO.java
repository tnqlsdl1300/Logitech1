package manager.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
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
import myshop.model.CouponVO;
import myshop.model.EachCouponVO;
import myshop.model.EventVO;
import myshop.model.JoinEventVO;
import myshop.model.OneQueryVO;
import myshop.model.ProductOptionVO;
import myshop.model.ProductQAVO;
import myshop.model.ProductVO;
import myshop.model.PurchaseDetailVO;
import myshop.model.PurchaseVO;
import util.security.AES256;
import util.security.SecretMyKey;
import util.security.Sha256;

public class ManagerDAO implements InterManagerDAO {
	
	private DataSource ds;
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	public ManagerDAO() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semi_oracle");
		    
		    aes = new AES256(SecretMyKey.KEY);  // SecretMyKey.KEY 는 우리가 만든 비밀키이다.
		} catch(NamingException e) {
			e.printStackTrace();
		} catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}// end of public ManagerDAO(){}---------------------
	
	// 사용한 자원을 반납하는 close() 메소드 생성하기
	private void close() {
		try {
		       if(rs != null)    {rs.close(); rs=null;}
		       if(pstmt != null) {pstmt.close(); pstmt=null;}
		       if(conn != null)  {conn.close(); conn=null;}
		    } catch(SQLException e) {
		       e.printStackTrace();
		    }
	}// end of private void close(){}----------------------

	
	// 관리자 로그인 화면에서 입력받은 정보에 해당하는 한 명의 정보를 select 하여 반환하는 메소드(관리자 로그인 메소드)
	@Override
	public ManagerVO selectOneManager(Map<String, String> paraMap) throws SQLException {
		ManagerVO mvo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = "select managerid, managerpwd, managertype, manageremail, managermobile\n"+
						 "from manager\n"+
						 "where managerid = ? and managerpwd = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("managerId"));
			pstmt.setString(2, paraMap.get("managerPwd"));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				mvo = new ManagerVO();
				mvo.setManagerid(rs.getString(1));
				mvo.setManagerpwd(rs.getString(2));
				mvo.setManagertype(rs.getString(3));
				mvo.setManageremail(rs.getString(4));
				mvo.setManagermobile(rs.getString(5));
			}// end of if(rs.next()){}-----------------------
		} finally {
			close();
		}
		
		return mvo;
	}// end of public ManagerVO selectOneManager(Map<String, String> paraMap) throws SQLException{}

	
	// 페이징 처리를 하여 모든 회원 또는 검색한 회원 목록 보여주기 메소드
	@Override
	public List<MemberVO> selectPagingMember(Map<String, String> paraMap) throws SQLException {
		List<MemberVO> memberList = new ArrayList<MemberVO>();
		
		try {
			conn = ds.getConnection();
			/*
			String sql = "select memberno, userid, pwd, name, email, mobile, birthday, postcode, address, detailaddress, extraaddress, agreeemail, agreesms, agreethird, fk_membershipname, point, registerday, lastpwdchangeday, idle, status, dropday\n"+
					"from\n"+
					"    (\n"+
					"    select rownum AS rno, memberno, userid, pwd, name, email, mobile, birthday, postcode, address, detailaddress, extraaddress, agreeemail, agreesms, agreethird, fk_membershipname, point, registerday, lastpwdchangeday, idle, status, dropday\n"+
					"    from\n"+
					"        (\n"+
					"        select memberno, userid, pwd, name, email, mobile, birthday, postcode, address, detailaddress, extraaddress, agreeemail, agreesms, agreethird, fk_membershipname, point\n"+
					"             , to_char(registerday, 'yyyy-mm-dd') AS registerday\n"+
					"             , to_char(lastpwdchangeday, 'yyyy-mm-dd') AS lastpwdchangeday\n"+
					"             , idle, status, dropday\n"+
					"        from member\n";
			*/
			String sql = "select memberno, userid, birthday, agreeemail, agreesms, fk_membershipname, registerday, idle, status\n"+
					"from\n"+
					"    (\n"+
					"    select rownum AS rno, memberno, userid, birthday, agreeemail, agreesms, fk_membershipname, registerday, idle, status\n"+
					"    from\n"+
					"        (\n"+
					"        select memberno, userid, birthday, agreeemail, agreesms, fk_membershipname\n"+
					"             , to_char(registerday, 'yyyy-mm-dd') AS registerday\n"+
					"             , idle, status\n"+
					"        from member\n";
					
			String searchOption1 = paraMap.get("searchOption1");
			String searchKey1 = paraMap.get("searchKey1");
			String searchOption2 = paraMap.get("searchOption2");
			String searchKey2 = paraMap.get("searchKey2");
			
			if(searchKey1 != null && !searchKey1.trim().isEmpty() ) {
				sql += " where "+searchOption1+" like '%'||?||'%'\n";
				
				if(searchKey2 != null && !searchKey2.trim().isEmpty() ) {
					sql += " and "+searchOption2+" like '%'||?||'%'\n";
				}// end of if(searchKey2 != null && !searchKey2.trim().isEmpty() ){}---------------------
			}// end of if(searchKey1 != null && !searchKey1.trim().isEmpty() ){}---------------------
			/*
			String memberno = paraMap.get("memberno");
			String userid = paraMap.get("userid");
			String birthday = paraMap.get("birthday");
			String agreeemail = paraMap.get("agreeemail");
			String agreesms = paraMap.get("agreesms");
			String fk_membershipname = paraMap.get("fk_membershipname");
			String registerday = paraMap.get("registerday");
			String idle = paraMap.get("idle");
			String status = paraMap.get("status");
			*/
			String selectedHead = paraMap.get("selectedHead");
			String sortFlag = paraMap.get("sortFlag");
			
			if(selectedHead != null && !selectedHead.trim().isEmpty()) {
				sql += "        order by "+selectedHead+" "+sortFlag+"\n";
			} else {
				sql += "        order by memberno desc\n";
			/*
			} else if(userid != null && !userid.trim().isEmpty()) {
				sql += "        order by "+userid+" "+sortFlag+"\n";
			} else if(birthday != null && !birthday.trim().isEmpty()) {
				sql += "        order by "+birthday+" "+sortFlag+"\n";
			} else if(agreeemail != null && !agreeemail.trim().isEmpty()) {
				sql += "        order by "+agreeemail+" "+sortFlag+"\n";
			} else if(agreesms != null && !agreesms.trim().isEmpty()) {
				sql += "        order by "+agreesms+" "+sortFlag+"\n";
			} else if(fk_membershipname != null && !fk_membershipname.trim().isEmpty()) {
				sql += "        order by "+fk_membershipname+" "+sortFlag+"\n";
			} else if(registerday != null && !registerday.trim().isEmpty()) {
				sql += "        order by "+registerday+" "+sortFlag+"\n";
			} else if(idle != null && !idle.trim().isEmpty()) {
				sql += "        order by "+idle+" "+sortFlag+"\n";
			} else if(status != null && !status.trim().isEmpty()) {
				sql += "        order by "+userid+" "+sortFlag+"\n";
			*/
			}// end of if(selectedHead != null && !selectedHead.trim().isEmpty() ){}---------------------
			
			
			sql += "        ) V\n"+
				"    ) T\n"+
				"where T.rno between ? and ?";
			
			pstmt = conn.prepareStatement(sql);
			
			int currentPageNo = Integer.parseInt(paraMap.get("currentPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
			
			if(searchKey1 != null && !searchKey1.trim().isEmpty() ) {
				pstmt.setString(1, searchKey1);
				
				if(searchKey2 != null && !searchKey2.trim().isEmpty() ) {
					pstmt.setString(2, searchKey2);
					pstmt.setInt(3, (currentPageNo - 1 ) * sizePerPage + 1);
					pstmt.setInt(4, (currentPageNo * sizePerPage));
				} else {
					pstmt.setInt(2, (currentPageNo - 1 ) * sizePerPage + 1);
					pstmt.setInt(3, (currentPageNo * sizePerPage));
				}// end of if(searchKey2 != null && !searchKey2.trim().isEmpty() ){}---------------------
			} else {
				pstmt.setInt(1, (currentPageNo - 1 ) * sizePerPage + 1);
				pstmt.setInt(2, (currentPageNo * sizePerPage));
			}// end of if(searchKey1 != null && !searchKey1.trim().isEmpty() ){}---------------------
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemberVO mvo = new MemberVO();
				/*
				 * mvo.setMemberno(rs.getInt(1)); mvo.setUserid(rs.getString(2));
				 * mvo.setPwd(rs.getString(3)); mvo.setName(rs.getString(4));
				 * mvo.setEmail(rs.getString(5)); mvo.setMobile(rs.getString(6));
				 * mvo.setBirthday(rs.getString(7)); mvo.setPostcode(rs.getString(8));
				 * mvo.setAddress(rs.getString(9)); mvo.setDetailaddress(rs.getString(10));
				 * mvo.setExtraaddress(rs.getString(11)); mvo.setAgreeemail(rs.getString(12));
				 * mvo.setAgreesms(rs.getString(13)); mvo.setAgreethird(rs.getString(14));
				 * mvo.setFk_membershipname(rs.getString(15)); mvo.setPoint(rs.getInt(16));
				 * mvo.setRegisterday(rs.getString(17));
				 * mvo.setLastpwdchangeday(rs.getString(18)); mvo.setIdle(rs.getInt(19));
				 * mvo.setStatus(rs.getInt(20)); mvo.setDropday(rs.getString(21));
				 */
				mvo.setMemberno(rs.getInt(1));
				mvo.setUserid(rs.getString(2));
				mvo.setBirthday(rs.getString(3));
				mvo.setAgreeemail(rs.getString(4));
				mvo.setAgreesms(rs.getString(5));
				mvo.setFk_membershipname(rs.getString(6));
				mvo.setRegisterday(rs.getString(7));
				mvo.setIdle(rs.getInt(8));
				mvo.setStatus(rs.getInt(9));
				
				memberList.add(mvo);
			}// end of while(rs.next()){}-----------------------
		} finally {
			close();
		}
		
		return memberList;
	}

	
	// 페이징 처리를 위해 전체회원에 대한 총 페이지 수 알아오기(select) 메소드
	@Override
	public int getTotalPage(Map<String, String> paraMap) throws SQLException {
		int totalPage = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select ceil(count(*)/?)\n"+
						"from member\n";					
			
			String searchOption1 = paraMap.get("searchOption1");
			String searchKey1 = paraMap.get("searchKey1");
			String searchOption2 = paraMap.get("searchOption2");
			String searchKey2 = paraMap.get("searchKey2");
			
			if(searchKey1 != null && !searchKey1.trim().isEmpty() ) {
				sql += " where "+searchOption1+" like '%'||?||'%'\n";
				
				if(searchKey2 != null && !searchKey2.trim().isEmpty() ) {
					sql += " and "+searchOption2+" like '%'||?||'%'\n";
				}// end of if(searchKey2 != null && !searchKey2.trim().isEmpty() ){}---------------------
			}// end of if(searchKey1 != null && !searchKey1.trim().isEmpty() ){}---------------------
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("sizePerPage"));
			
			if(searchKey1 != null && !searchKey1.trim().isEmpty() ) {
				pstmt.setString(2, searchKey1);
				
				if(searchKey2 != null && !searchKey2.trim().isEmpty() ) {
					pstmt.setString(3, searchKey2);
				}// end of if(searchKey2 != null && !searchKey2.trim().isEmpty() ){}---------------------
			}// end of if(searchWord != null && !searchWord.trim().isEmpty()){}----------------------
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				totalPage = rs.getInt(1);
			}// end of if(rs.next()){}------------------------
		
		} finally {
			close();
		}// end of try~finally{}----------------------
		
		return totalPage;
	}// end of public int getTotalPage(Map<String, String> paraMap) throws SQLException{}-----------

	
	// 페이징 처리를 하여 모든 제품 또는 검색한 제품 목록 보여주기 메소드
	@Override
	public List<ProductOptionVO> selectPagingProductOption(Map<String, String> paraMap) throws SQLException {
		List<ProductOptionVO> poList = new ArrayList<ProductOptionVO>();
		
		try {
			conn = ds.getConnection();
			
			String sql = "select productserialid, fk_productid, color, stock, saleday, productname, fk_category, character, price\n"+
					"from\n"+
					"    (\n"+
					"    select rownum AS rno, productserialid, fk_productid, color, stock, saleday, productname, fk_category, character, price\n"+
					"    from\n"+
					"        (\n"+
					"        select productserialid, fk_productid, color, stock, saleday, productname, fk_category, character, price\n"+
					"        from product P join productoption O\n"+
					"        on P.productid = O.fk_productid\n";
			
			String searchOption1 = paraMap.get("searchOption1");
			String searchKey1 = paraMap.get("searchKey1");
			String searchOption2 = paraMap.get("searchOption2");
			String searchKey2 = paraMap.get("searchKey2");
			
			if(searchKey1 != null && !searchKey1.trim().isEmpty() ) {
				sql += " where "+searchOption1+" like '%'||?||'%'\n";
				
				if(searchKey2 != null && !searchKey2.trim().isEmpty() ) {
					sql += " and "+searchOption2+" like '%'||?||'%'\n";
				}// end of if(searchKey2 != null && !searchKey2.trim().isEmpty() ){}---------------------
			}// end of if(searchKey1 != null && !searchKey1.trim().isEmpty() ){}---------------------
			
			String selectedHead = paraMap.get("selectedHead");
			String sortFlag = paraMap.get("sortFlag");
			
			if(selectedHead != null && !selectedHead.trim().isEmpty()) {
				sql += "        order by "+selectedHead+" "+sortFlag+"\n";
			} else {
				sql += "        order by productserialid\n";
			}// end of if(selectedHead != null && !selectedHead.trim().isEmpty() ){}---------------------
			
			sql += "        ) V\n"+
				"    ) T\n"+
				"where T.rno between ? and ?";
			
			pstmt = conn.prepareStatement(sql);
			
			int currentPageNo = Integer.parseInt(paraMap.get("currentPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
			
			if(searchKey1 != null && !searchKey1.trim().isEmpty() ) {
				pstmt.setString(1, searchKey1);
				
				if(searchKey2 != null && !searchKey2.trim().isEmpty() ) {
					pstmt.setString(2, searchKey2);
					pstmt.setInt(3, (currentPageNo - 1 ) * sizePerPage + 1);
					pstmt.setInt(4, (currentPageNo * sizePerPage));
				} else {
					pstmt.setInt(2, (currentPageNo - 1 ) * sizePerPage + 1);
					pstmt.setInt(3, (currentPageNo * sizePerPage));
				}// end of if(searchKey2 != null && !searchKey2.trim().isEmpty() ){}---------------------
			} else {
				pstmt.setInt(1, (currentPageNo - 1 ) * sizePerPage + 1);
				pstmt.setInt(2, (currentPageNo * sizePerPage));
			}// end of if(searchKey1 != null && !searchKey1.trim().isEmpty() ){}---------------------
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductOptionVO povo = new ProductOptionVO();
				
				povo.setProductserialid(rs.getString(1));
				povo.setFk_productid(rs.getString(2));
				povo.setColor(rs.getString(3));
				povo.setStock(rs.getInt(4));
				povo.setSaleday(rs.getString(5));
				
				ProductVO pvo = new ProductVO();
				pvo.setProductname(rs.getString(6));
				pvo.setFk_category(rs.getString(7));
				pvo.setCharacter(rs.getString(8));
				pvo.setPrice(rs.getInt(9));
				povo.setPvo(pvo);
				
				poList.add(povo);
			}// end of while(rs.next()){}-----------------------
		} finally {
			close();
		}
		
		return poList;
	}// end of public List<ProductOptionVO> selectPagingProductOption(Map<String, String> paraMap) throws SQLException{}

	
	// 페이징 처리를 위해 전체판매제품에 대한 총 페이지 수 알아오기(select) 메소드
	@Override
	public int getPOTotalPage(Map<String, String> paraMap) throws SQLException {
		int pototalPage = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select ceil(count(*)/?)\n"+
						"from product P join productoption O\n"+
						"on P.productid = O.fk_productid";					
			
			String searchOption1 = paraMap.get("searchOption1");
			String searchKey1 = paraMap.get("searchKey1");
			String searchOption2 = paraMap.get("searchOption2");
			String searchKey2 = paraMap.get("searchKey2");
			
			if(searchKey1 != null && !searchKey1.trim().isEmpty() ) {
				sql += " where "+searchOption1+" like '%'||?||'%'\n";
				
				if(searchKey2 != null && !searchKey2.trim().isEmpty() ) {
					sql += " and "+searchOption2+" like '%'||?||'%'\n";
				}// end of if(searchKey2 != null && !searchKey2.trim().isEmpty() ){}---------------------
			}// end of if(searchKey1 != null && !searchKey1.trim().isEmpty() ){}---------------------
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("sizePerPage"));
			
			if(searchKey1 != null && !searchKey1.trim().isEmpty() ) {
				pstmt.setString(2, searchKey1);
				
				if(searchKey2 != null && !searchKey2.trim().isEmpty() ) {
					pstmt.setString(3, searchKey2);
				}// end of if(searchKey2 != null && !searchKey2.trim().isEmpty() ){}---------------------
			}// end of if(searchWord != null && !searchWord.trim().isEmpty()){}----------------------
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				pototalPage = rs.getInt(1);
			}// end of if(rs.next()){}------------------------
		
		} finally {
			close();
		}// end of try~finally{}----------------------
		
		return pototalPage;
	}// end of public int getPOTotalPage(Map<String, String> paraMap) throws SQLException{}---------

	
	// 재고량을 수정하는 메소드
	@Override
	public int stockUpdate(Map<String, String> paraMap) throws SQLException {
		int result = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "update productoption set stock = stock "+paraMap.get("mark")+" ?\n"+
						"where productserialid = ?";
			
			System.out.println(sql);
			
			pstmt = conn.prepareStatement(sql);
			System.out.println(paraMap.get("stockUpdate"));
			System.out.println(paraMap.get("productserialid"));
			pstmt.setInt(1, Integer.parseInt(paraMap.get("stockUpdate")));
			pstmt.setString(2, paraMap.get("productserialid"));
			
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		return result;
	}// end of public int stockUpdate(Map<String, String> paraMap) throws SQLException {}
	
	
	// memberno 값을 가져와 회원 1명에 대한 상세정보 알아오기(select) 메소드
	@Override
	public MemberVO memberOneDetail(String memberno) throws SQLException {
		MemberVO mvo = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select memberno, userid, name, email, mobile, birthday, postcode, address, detailaddress, extraaddress\n"+
						 "     , case when agreeemail = '1' then '수신' else '거절' end AS agreeemail\n"+
						 "     , case when agreesms = '1' then '수신' else '거절' end AS agreesms\n"+
						 "     , case when agreethird = '1' then '동의' else '거절' end AS agreethird\n"+
						 "     , fk_membershipname, point\n"+
						 "     , to_char(registerday, 'yyyy-mm-dd') AS registerday\n"+
						 "     , to_char(lastpwdchangeday, 'yyyy-mm-dd') AS lastpwdchangeday\n"+
						 "     , idle, status, dropday\n"+
						 "from member\n"+
						 "where memberno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberno);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				mvo = new MemberVO();
				mvo.setMemberno(rs.getInt(1));
				mvo.setUserid(rs.getString(2));
				mvo.setName(rs.getString(3));
				mvo.setEmail(aes.decrypt(rs.getString(4)));
				mvo.setMobile(aes.decrypt(rs.getString(5)));
				mvo.setBirthday(rs.getString(6));
				mvo.setPostcode(rs.getString(7));
				mvo.setAddress(rs.getString(8));
				mvo.setDetailaddress(rs.getString(9));
				mvo.setExtraaddress(rs.getString(10));
				mvo.setAgreeemail(rs.getString(11));
				mvo.setAgreesms(rs.getString(12));
				mvo.setAgreethird(rs.getString(13));
				mvo.setFk_membershipname(rs.getString(14));
				mvo.setPoint(rs.getInt(15));
				mvo.setRegisterday(rs.getString(16));
				mvo.setLastpwdchangeday(rs.getString(17));
				mvo.setIdle(rs.getInt(18));
				mvo.setStatus(rs.getInt(19));
				mvo.setDropday(rs.getString(20));
			}// end of if(rs.next()){}------------------------
		
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}// end of try~finally{}----------------------
		
		return mvo;
	}// end of public MemberVO memberOneDetail(String memberno) throws SQLException{}---------------

	
	// productserialid 값을 가져와 선택한 판매제품에 대한 상세정보 알아오기(select) 메소드
	@Override
	public ProductOptionVO prodOptionOneDetail(String productserialid) throws SQLException {
		ProductOptionVO povo = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select productid, productserialid, productname, color, character, price, stock, saleday\n"+
						"from product P join productoption O\n"+
						"on P.productid = O.fk_productid\n"+
						"where productserialid = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, productserialid);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				povo = new ProductOptionVO();
				
				ProductVO pvo = new ProductVO();
				pvo.setProductid(rs.getString(1));
				povo.setProductserialid(rs.getString(2));
				pvo.setProductname(rs.getString(3));
				povo.setColor(rs.getString(4));
				pvo.setCharacter(rs.getString(5));
				pvo.setPrice(rs.getInt(6));
				povo.setStock(rs.getInt(7));
				povo.setSaleday(rs.getString(8));
				povo.setPvo(pvo);
			}// end of if(rs.next()){}------------------------
		
		} finally {
			close();
		}// end of try~finally{}----------------------
		
		return povo;
	}// end of public ProductOptionVO prodOptionOneDetail(String productserialid) throws SQLException{}

	
	// 페이징 처리를 하여 모든 주문 또는 검색한 주문 목록 보여주기 메소드
	@Override
	public List<PurchaseDetailVO> selectPagingPurchaseList(Map<String, String> paraMap) throws SQLException {
		List<PurchaseDetailVO> pdList = new ArrayList<PurchaseDetailVO>();
		
		try {
			conn = ds.getConnection();
			
			String sql = "select fk_purchaseno, fk_memberno, payment, purchaseday, sumprice, totalprice, discount, totalstatus\n"+
					"from\n"+
					"(\n"+
					"select rownum AS rno, fk_purchaseno, fk_memberno, payment, purchaseday, sumprice, totalprice, sumprice - totalprice AS discount, totalstatus\n"+
					"from\n"+
					"(\n"+
					"select fk_purchaseno, fk_memberno, payment, purchaseday, sum(sumprice) AS sumprice, totalprice, totalstatus\n"+
					"from\n"+
					"(\n"+
					"select fk_purchaseno, fk_memberno, payment, purchaseday, price * volume AS sumprice, totalprice, totalstatus\n"+
					"from purchasedetail D\n"+
					"join purchase P\n"+
					"on D.fk_purchaseno = P.purchaseno\n"+
					"join product R\n"+
					"on D.fk_productid = R.productid\n";
			
					
			
			String searchOption1 = paraMap.get("searchOption1");
			String searchKey1 = paraMap.get("searchKey1");
			String searchOption2 = paraMap.get("searchOption2");
			String searchKey2 = paraMap.get("searchKey2");
			
			if(searchKey1 != null && !searchKey1.trim().isEmpty() ) {
				sql += " where "+searchOption1+" like '%'||?||'%'\n";
				
				if(searchKey2 != null && !searchKey2.trim().isEmpty() ) {
					sql += " and "+searchOption2+" like '%'||?||'%'\n";
				}// end of if(searchKey2 != null && !searchKey2.trim().isEmpty() ){}---------------------
			}// end of if(searchKey1 != null && !searchKey1.trim().isEmpty() ){}---------------------
			
			String selectedHead = paraMap.get("selectedHead");
			String sortFlag = paraMap.get("sortFlag");
			
			if(selectedHead != null && !selectedHead.trim().isEmpty()) {
				sql += "        order by "+selectedHead+" "+sortFlag+"\n";
			} else {
				sql += "        order by purchaseday desc\n";
			}// end of if(selectedHead != null && !selectedHead.trim().isEmpty() ){}---------------------
			/*
			sql += ") V\n"+
					"group by fk_purchaseno, fk_memberno, payment, purchaseday\n"+
					") W\n"+
					") X\n"+
					"where X.rno between ? and ?";
			*/
			sql += ") V\n"+
					"group by fk_purchaseno, fk_memberno, payment, purchaseday, totalprice, totalstatus\n"+
					") W\n"+
					") X\n"+
					"where X.rno between ? and ?";
			
			pstmt = conn.prepareStatement(sql);
			
			int currentPageNo = Integer.parseInt(paraMap.get("currentPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
			
			if(searchKey1 != null && !searchKey1.trim().isEmpty() ) {
				pstmt.setString(1, searchKey1);
				
				if(searchKey2 != null && !searchKey2.trim().isEmpty() ) {
					pstmt.setString(2, searchKey2);
					pstmt.setInt(3, (currentPageNo - 1 ) * sizePerPage + 1);
					pstmt.setInt(4, (currentPageNo * sizePerPage));
				} else {
					pstmt.setInt(2, (currentPageNo - 1 ) * sizePerPage + 1);
					pstmt.setInt(3, (currentPageNo * sizePerPage));
				}// end of if(searchKey2 != null && !searchKey2.trim().isEmpty() ){}---------------------
			} else {
				pstmt.setInt(1, (currentPageNo - 1 ) * sizePerPage + 1);
				pstmt.setInt(2, (currentPageNo * sizePerPage));
			}// end of if(searchKey1 != null && !searchKey1.trim().isEmpty() ){}---------------------
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				PurchaseDetailVO pdvo = new PurchaseDetailVO();
				
				pdvo.setFk_purchaseno(rs.getInt(1));
				
				PurchaseVO purcvo = new PurchaseVO();
				purcvo.setFk_memberno(rs.getInt(2));
				purcvo.setPayment(rs.getString(3));
				purcvo.setPurchaseday(rs.getString(4));
				
				pdvo.setDetailtotalpay(rs.getInt(5));
				
				purcvo.setTotalprice(rs.getInt(6));
				purcvo.setDiscount(rs.getInt(7));
				purcvo.setTotalstatus(rs.getString(8));
				
				pdvo.setPurcvo(purcvo);
				
				pdList.add(pdvo);
			}// end of while(rs.next()){}-----------------------
		} finally {
			close();
		}
		
		return pdList;
	}// end of public List<PurchaseDetailVO> selectPagingPurchaseList(Map<String, String> paraMap) throws SQLException{}
	
	
	// 페이징 처리를 위해 전체 주문에 대한 총 페이지 수 알아오기(select) 메소드
	@Override
	public int getPurcTotalPage(Map<String, String> paraMap) throws SQLException {
		int purctotalPage = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select ceil(count(*)/?)\n"+
						"  from purchasedetail D\n"+
						"  join purchase P\n"+
						"  on D.fk_purchaseno = P.purchaseno\n"+
						"  join product R\n"+
						"  on D.fk_productid = R.productid\n";
			
			String searchOption1 = paraMap.get("searchOption1");
			String searchKey1 = paraMap.get("searchKey1");
			String searchOption2 = paraMap.get("searchOption2");
			String searchKey2 = paraMap.get("searchKey2");
			
			if(searchKey1 != null && !searchKey1.trim().isEmpty() ) {
				sql += " where "+searchOption1+" like '%'||?||'%'\n";
				
				if(searchKey2 != null && !searchKey2.trim().isEmpty() ) {
					sql += " and "+searchOption2+" like '%'||?||'%'\n";
				}// end of if(searchKey2 != null && !searchKey2.trim().isEmpty() ){}---------------------
			}// end of if(searchKey1 != null && !searchKey1.trim().isEmpty() ){}---------------------
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("sizePerPage"));
			
			if(searchKey1 != null && !searchKey1.trim().isEmpty() ) {
				pstmt.setString(2, searchKey1);
				
				if(searchKey2 != null && !searchKey2.trim().isEmpty() ) {
					pstmt.setString(3, searchKey2);
				}// end of if(searchKey2 != null && !searchKey2.trim().isEmpty() ){}---------------------
			}// end of if(searchWord != null && !searchWord.trim().isEmpty()){}----------------------
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				purctotalPage = rs.getInt(1);
			}// end of if(rs.next()){}------------------------
		
		} finally {
			close();
		}// end of try~finally{}----------------------
		
		return purctotalPage;
	}// end of public int getPurcTotalPage(Map<String, String> paraMap) throws SQLException{}

	
	// purchasedetailid 값을 가져와 선택한 주문에 대한 상세정보 알아오기(select) 메소드
	@Override
	public List<PurchaseDetailVO> purchaseOneDetail(String fk_purchaseno) throws SQLException {
		List<PurchaseDetailVO> pdList = new ArrayList<PurchaseDetailVO>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select purchasedetailid, fk_productserialid, volume, price, deliverystatus, imgfilename\n"+
						"from purchasedetail D\n"+
						"join product R\n"+
						"on D.fk_productid = R.productid\n"+
						"where fk_purchaseno = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fk_purchaseno);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				PurchaseDetailVO pdvo = new PurchaseDetailVO();
				
				pdvo.setPurchasedetailid(rs.getInt(1));
				pdvo.setFk_productserialid(rs.getString(2));
				pdvo.setVolume(rs.getInt(3));
				
				ProductVO pvo = new ProductVO();
				pvo.setPrice(rs.getInt(4));
				
				pdvo.setDeliverystatus(rs.getString(5));
				
				pvo.setImgfilename(rs.getString(6));
				pdvo.setPvo(pvo);
				
				pdList.add(pdvo);
			}// end of if(rs.next()){}------------------------
		
		} finally {
			close();
		}// end of try~finally{}----------------------
		
		return pdList;
	}// end of public PurchaseDetailVO purchaseOneDetail(String purchasedetailid) throws SQLException
	
	
	// purchasedetailid 값을 가져와 주문자에 대한 상세정보 알아오기(select) 메소드
	@Override
	public PurchaseVO purchaseByMember(String fk_purchaseno) throws SQLException {
		PurchaseVO purcvo = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select purchaseno, name, receiver, P.postcode, P.address, P.detailaddress, P.extraaddress, payment, totalprice, purchaseday\n"+
						"from purchase P\n"+
						"join member M\n"+
						"on P.fk_memberno = M.memberno\n"+
						"where purchaseno = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fk_purchaseno);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				purcvo = new PurchaseVO();
				
				purcvo.setPurchaseno(rs.getInt(1));
				
				MemberVO mvo = new MemberVO();
				mvo.setName(rs.getString(2));
				
				purcvo.setReceiver(rs.getString(3));
				purcvo.setPostcode(rs.getString(4));
				purcvo.setAddress(rs.getString(5));
				purcvo.setDetailaddress(rs.getString(6));
				purcvo.setExtraaddress(rs.getString(7));
				purcvo.setPayment(rs.getString(8));
				purcvo.setTotalprice(rs.getInt(9));
				purcvo.setPurchaseday(rs.getString(10));
				purcvo.setMvo(mvo);
			}// end of if(rs.next()){}------------------------
		
		} finally {
			close();
		}// end of try~finally{}----------------------
		
		return purcvo;
	}// end of public PurchaseVO purchaseByMember(String fk_purchaseno) throws SQLException{}
	
	
	// 페이징 처리를 하여 모든 쿠폰 또는 검색한 쿠폰 목록 보여주기 메소드
	@Override
	public List<EachCouponVO> selectPagingCoupon(Map<String, String> paraMap) throws SQLException {
		List<EachCouponVO> ecList = new ArrayList<EachCouponVO>();
		
		try {
			conn = ds.getConnection();
			
			String sql = "select fk_couponcode, eachcouponcode, couponname, discount, minprice, fk_membershipname, fk_memberno, status, endday\n"+
					"from\n"+
					"(\n"+
					"select rownum AS rno, fk_couponcode, eachcouponcode, couponname, discount, minprice, fk_membershipname, fk_memberno, status, endday\n"+
					"from\n"+
					" (\n"+
					" select fk_couponcode, eachcouponcode, couponname, discount, minprice, fk_membershipname, fk_memberno, status, endday\n"+
					" from eachcoupon E right join coupon C\n"+
					" on E.fk_couponcode = C.couponcode\n";
			
			String searchOption1 = paraMap.get("searchOption1");
			String searchKey1 = paraMap.get("searchKey1");
			String searchOption2 = paraMap.get("searchOption2");
			String searchKey2 = paraMap.get("searchKey2");
			
			if(searchKey1 != null && !searchKey1.trim().isEmpty() ) {
				sql += " where "+searchOption1+" like '%'||?||'%'\n";
				
				if(searchKey2 != null && !searchKey2.trim().isEmpty() ) {
					sql += " and "+searchOption2+" like '%'||?||'%'\n";
				}// end of if(searchKey2 != null && !searchKey2.trim().isEmpty() ){}---------------------
			}// end of if(searchKey1 != null && !searchKey1.trim().isEmpty() ){}---------------------
			
			String selectedHead = paraMap.get("selectedHead");
			String sortFlag = paraMap.get("sortFlag");
			
			if(selectedHead != null && !selectedHead.trim().isEmpty()) {
				sql += "        order by "+selectedHead+" "+sortFlag+"\n";
			} else {
				sql += " order by endday desc\n";
			}// end of if(selectedHead != null && !selectedHead.trim().isEmpty() ){}---------------------
			
			sql += " ) V\n"+
				") T\n"+
				"where T.rno between ? and ?";
			
			pstmt = conn.prepareStatement(sql);
			
			int currentPageNo = Integer.parseInt(paraMap.get("currentPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
			
			if(searchKey1 != null && !searchKey1.trim().isEmpty() ) {
				pstmt.setString(1, searchKey1);
				
				if(searchKey2 != null && !searchKey2.trim().isEmpty() ) {
					pstmt.setString(2, searchKey2);
					pstmt.setInt(3, (currentPageNo - 1 ) * sizePerPage + 1);
					pstmt.setInt(4, (currentPageNo * sizePerPage));
				} else {
					pstmt.setInt(2, (currentPageNo - 1 ) * sizePerPage + 1);
					pstmt.setInt(3, (currentPageNo * sizePerPage));
				}// end of if(searchKey2 != null && !searchKey2.trim().isEmpty() ){}---------------------
			} else {
				pstmt.setInt(1, (currentPageNo - 1 ) * sizePerPage + 1);
				pstmt.setInt(2, (currentPageNo * sizePerPage));
			}// end of if(searchKey1 != null && !searchKey1.trim().isEmpty() ){}---------------------
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				EachCouponVO ecvo = new EachCouponVO();
				ecvo.setFk_couponcode(rs.getString(1));
				ecvo.setEachcouponcode(rs.getString(2));
				
				CouponVO coupvo = new CouponVO();
				coupvo.setCouponname(rs.getString(3));
				coupvo.setDiscount(rs.getInt(4));
				coupvo.setMinprice(rs.getInt(5));
				coupvo.setFk_membershipname(rs.getString(6));
				
				ecvo.setFk_memberno(rs.getInt(7));
				ecvo.setStatus(rs.getInt(8));
				ecvo.setEndday(rs.getString(9));
				
				ecvo.setCoupvo(coupvo);
				
				ecList.add(ecvo);
			}// end of while(rs.next()){}-----------------------
		} finally {
			close();
		}
		
		return ecList;
	}// end of public List<EachCouponVO> selectPagingCoupon(Map<String, String> paraMap) throws SQLException{}

	
	// 페이징 처리를 위해 전체 쿠폰에 대한 총 페이지 수 알아오기(select) 메소드
	@Override
	public int getCoupTotalPage(Map<String, String> paraMap) throws SQLException {
		int coupTotalPage = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select ceil(count(*)/?)\n"+
						" from eachcoupon E right join coupon C\n"+
						" on E.fk_couponcode = C.couponcode\n";
			
			String searchOption1 = paraMap.get("searchOption1");
			String searchKey1 = paraMap.get("searchKey1");
			String searchOption2 = paraMap.get("searchOption2");
			String searchKey2 = paraMap.get("searchKey2");
			
			if(searchKey1 != null && !searchKey1.trim().isEmpty() ) {
				sql += " where "+searchOption1+" like '%'||?||'%'\n";
				
				if(searchKey2 != null && !searchKey2.trim().isEmpty() ) {
					sql += " and "+searchOption2+" like '%'||?||'%'\n";
				}// end of if(searchKey2 != null && !searchKey2.trim().isEmpty() ){}---------------------
			}// end of if(searchKey1 != null && !searchKey1.trim().isEmpty() ){}---------------------
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("sizePerPage"));
			
			if(searchKey1 != null && !searchKey1.trim().isEmpty() ) {
				pstmt.setString(2, searchKey1);
				
				if(searchKey2 != null && !searchKey2.trim().isEmpty() ) {
					pstmt.setString(3, searchKey2);
				}// end of if(searchKey2 != null && !searchKey2.trim().isEmpty() ){}---------------------
			}// end of if(searchWord != null && !searchWord.trim().isEmpty()){}----------------------
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				coupTotalPage = rs.getInt(1);
			}// end of if(rs.next()){}------------------------
		
		} finally {
			close();
		}// end of try~finally{}----------------------
		
		return coupTotalPage;
	}// end of public int getCoupTotalPage(Map<String, String> paraMap) throws SQLException{}

	
	// eachcouponcode 값을 가져와 개별 쿠폰에 대한 상세정보 알아오기(select) 메소드
	@Override
	public EachCouponVO couponOneDetail(String eachcouponcode) throws SQLException {
		EachCouponVO ecvo = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select fk_couponcode, eachcouponcode, couponname, discount, minprice, fk_membershipname, fk_memberno, status, endday\n"+
						"from eachcoupon E\n"+
						"right join coupon C\n"+
						"on E.fk_couponcode = C.couponcode\n"+
						"where eachcouponcode = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, eachcouponcode);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				ecvo = new EachCouponVO();
				
				ecvo.setFk_couponcode(rs.getString(1));
				ecvo.setEachcouponcode(rs.getString(2));
				
				CouponVO coupvo = new CouponVO();
				coupvo.setCouponname(rs.getString(3));
				coupvo.setDiscount(rs.getInt(4));
				coupvo.setMinprice(rs.getInt(5));
				coupvo.setFk_membershipname(rs.getString(6));
				
				ecvo.setFk_memberno(rs.getInt(7));
				ecvo.setStatus(rs.getInt(8));
				ecvo.setEndday(rs.getString(9));
				ecvo.setCoupvo(coupvo);
			}// end of if(rs.next()){}------------------------
		
		} finally {
			close();
		}// end of try~finally{}----------------------
		
		return ecvo;
	}// end of public EachCouponVO couponOneDetail(String eachcouponcode) throws SQLException{}

	
	// 페이징 처리를 하여 모든 쿠폰 또는 검색한 쿠폰 목록 보여주기 메소드
	@Override
	public List<EventVO> selectPagingEvent(Map<String, String> paraMap) throws SQLException {
		List<EventVO> evoList = new ArrayList<EventVO>();
		
		try {
			conn = ds.getConnection();
			
			String sql = "select seq_event, eventname, fk_productid, startday, endday\n"+
					"from\n"+
					"(\n"+
					"select rownum AS rno, seq_event, eventname, fk_productid, startday, endday\n"+
					"from\n"+
					" (\n"+
					" select seq_event, eventname, fk_productid, startday, endday\n"+
					" from event\n";
			
			String searchOption1 = paraMap.get("searchOption1");
			String searchKey1 = paraMap.get("searchKey1");
			String searchOption2 = paraMap.get("searchOption2");
			String searchKey2 = paraMap.get("searchKey2");
			
			if(searchKey1 != null && !searchKey1.trim().isEmpty() ) {
				sql += " where "+searchOption1+" like '%'||?||'%'\n";
				
				if(searchKey2 != null && !searchKey2.trim().isEmpty() ) {
					sql += " and "+searchOption2+" like '%'||?||'%'\n";
				}// end of if(searchKey2 != null && !searchKey2.trim().isEmpty() ){}---------------------
			}// end of if(searchKey1 != null && !searchKey1.trim().isEmpty() ){}---------------------
			
			String selectedHead = paraMap.get("selectedHead");
			String sortFlag = paraMap.get("sortFlag");
			
			if(selectedHead != null && !selectedHead.trim().isEmpty()) {
				sql += "        order by "+selectedHead+" "+sortFlag+"\n";
			} else {
				sql += " order by seq_event desc\n";
			}// end of if(selectedHead != null && !selectedHead.trim().isEmpty() ){}---------------------
			
			sql += " ) V\n"+
				") T\n"+
				"where T.rno between ? and ?";
			
			pstmt = conn.prepareStatement(sql);
			
			int currentPageNo = Integer.parseInt(paraMap.get("currentPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
			
			if(searchKey1 != null && !searchKey1.trim().isEmpty() ) {
				pstmt.setString(1, searchKey1);
				
				if(searchKey2 != null && !searchKey2.trim().isEmpty() ) {
					pstmt.setString(2, searchKey2);
					pstmt.setInt(3, (currentPageNo - 1 ) * sizePerPage + 1);
					pstmt.setInt(4, (currentPageNo * sizePerPage));
				} else {
					pstmt.setInt(2, (currentPageNo - 1 ) * sizePerPage + 1);
					pstmt.setInt(3, (currentPageNo * sizePerPage));
				}// end of if(searchKey2 != null && !searchKey2.trim().isEmpty() ){}---------------------
			} else {
				pstmt.setInt(1, (currentPageNo - 1 ) * sizePerPage + 1);
				pstmt.setInt(2, (currentPageNo * sizePerPage));
			}// end of if(searchKey1 != null && !searchKey1.trim().isEmpty() ){}---------------------
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				EventVO evo = new EventVO();
				evo.setSeq_event(rs.getInt(1));
				evo.setEventname(rs.getString(2));
				evo.setFk_productid(rs.getString(3));
				evo.setStartday(rs.getNString(4));
				evo.setEndday(rs.getString(5));
				
				evoList.add(evo);
			}// end of while(rs.next()){}-----------------------
		} finally {
			close();
		}
		
		return evoList;
	}// end of public List<EventVO> selectPagingEvent(Map<String, String> paraMap) throws SQLException

	
	// 페이징 처리를 위해 전체 이벤트에 대한 총 페이지 수 알아오기(select) 메소드
	@Override
	public int getEventTotalPage(Map<String, String> paraMap) throws SQLException {
		int eventTotalPage = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select ceil(count(*)/?)\n"+
						" from event\n";
			
			String searchOption1 = paraMap.get("searchOption1");
			String searchKey1 = paraMap.get("searchKey1");
			String searchOption2 = paraMap.get("searchOption2");
			String searchKey2 = paraMap.get("searchKey2");
			
			if(searchKey1 != null && !searchKey1.trim().isEmpty() ) {
				sql += " where "+searchOption1+" like '%'||?||'%'\n";
				
				if(searchKey2 != null && !searchKey2.trim().isEmpty() ) {
					sql += " and "+searchOption2+" like '%'||?||'%'\n";
				}// end of if(searchKey2 != null && !searchKey2.trim().isEmpty() ){}---------------------
			}// end of if(searchKey1 != null && !searchKey1.trim().isEmpty() ){}---------------------
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("sizePerPage"));
			
			if(searchKey1 != null && !searchKey1.trim().isEmpty() ) {
				pstmt.setString(2, searchKey1);
				
				if(searchKey2 != null && !searchKey2.trim().isEmpty() ) {
					pstmt.setString(3, searchKey2);
				}// end of if(searchKey2 != null && !searchKey2.trim().isEmpty() ){}---------------------
			}// end of if(searchWord != null && !searchWord.trim().isEmpty()){}----------------------
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				eventTotalPage = rs.getInt(1);
			}// end of if(rs.next()){}------------------------
		
		} finally {
			close();
		}// end of try~finally{}----------------------
		
		return eventTotalPage;
	}// end of public int getEventTotalPage(Map<String, String> paraMap) throws SQLException{}

	
	// seq_event 값을 가져와 개별 이벤트에 대한 상세정보 알아오기(select) 메소드
	@Override
	public List<JoinEventVO> eventOneDetail(String seq_event) throws SQLException {
		List<JoinEventVO> jevoList = new ArrayList<JoinEventVO>();
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select seq_joinevent, userid\n"+
						"from joinevent J\n"+
						"right join member M\n"+
						"on J.fk_memberno = M.memberno\n"+
						"where fk_event = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, seq_event);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				JoinEventVO jevo = new JoinEventVO();
				
				jevo.setSeq_joinevent(rs.getInt(1));
				
				MemberVO mvo = new MemberVO();
				mvo.setUserid(rs.getString(2));
				jevo.setMvo(mvo);
				
				jevoList.add(jevo);
			}// end of if(rs.next()){}------------------------
		
		} finally {
			close();
		}// end of try~finally{}----------------------
		
		return jevoList;
	}// end of public JoinEventVO eventOneDetail(String seq_event) throws SQLException{}

	
	// Ajax(JSON) 를 사용하여 일대일 문의 목록을 "더 보기" 방식으로 페이징 처리하기 위해 전체 문의 수를 알아오는 메소드
	@Override
	public int totalOQCount(String today) throws SQLException {
		int totalOQCount = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = "select count(*)\n"+
						 "from onequery\n"+
						 "where to_char(writeday, 'yyyy-mm-dd') = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, today);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				totalOQCount = rs.getInt(1);
			}// end of if(rs.next()){}---------------------
		} finally {
			close();
		}
		
		return totalOQCount;
	}// end of public int totalOQCount(String seq_oq) throws SQLException{}

	
	// Ajax(JSON) 를 이용하여 "더 보기" 방식(페이징 처리)으로 일대일 문의를 5개씩 잘라서(start ~ end) 조회하는 메소드
	@Override
	public List<OneQueryVO> selectByWriteday(Map<String, String> paraMap) throws SQLException {
		List<OneQueryVO> oqvoList = new ArrayList<OneQueryVO>();
		
		try {
			conn = ds.getConnection();
			
			String sql = "select seq_oq, userid, category, title, answerstatus\n"+
					"from\n"+
					" (\n"+
					" select row_number() over(order by seq_oq asc) AS rno, seq_oq, userid, category, title, answerstatus\n"+
					" from onequery O\n"+
					" join member M\n"+
					" on O.fk_memberno = M.memberno\n"+
					" where to_char(writeday, 'yyyy-mm-dd') = ?\n"+
					" ) V\n"+
					"where rno between ? and ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("today"));
			pstmt.setString(2, paraMap.get("start"));
			pstmt.setString(3, paraMap.get("end"));
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				OneQueryVO oqvo = new OneQueryVO();
				
				oqvo.setSeq_oq(rs.getInt(1));
				
				MemberVO mvo = new MemberVO();
				mvo.setUserid(rs.getString(2));
				
				oqvo.setCategory(rs.getString(3));
				oqvo.setTitle(rs.getString(4));
				oqvo.setAnswerstatus(rs.getInt(5));
				oqvo.setMvo(mvo);
				
				oqvoList.add(oqvo);
			}// end of while(rs.next()){}---------------------
		} finally {
			close();
		}
		
		return oqvoList;
	}// end of public List<OneQueryVO> selectByWriteday(Map<String, String> paraMap) throws SQLException

	
	// 일대일 문의 처리를 위해 상세정보 알아오기(select) 메소드
	@Override
	public OneQueryVO oneQueryDetail(String seq_oq) throws SQLException {
		OneQueryVO oqvo = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select seq_oq, userid, category, title, content\n"+
					" from onequery O\n"+
					" join member M\n"+
					" on O.fk_memberno = M.memberno\n"+
					" where seq_oq = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, seq_oq);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				oqvo = new OneQueryVO();
				
				oqvo.setSeq_oq(rs.getInt(1));
				
				MemberVO mvo = new MemberVO();
				mvo.setUserid(rs.getString(2));
				
				oqvo.setCategory(rs.getString(3));
				oqvo.setTitle(rs.getString(4));
				oqvo.setContent(rs.getString(5));
				oqvo.setMvo(mvo);
			}// end of if(rs.next()){}------------------------
		
		} finally {
			close();
		}// end of try~finally{}----------------------
		
		return oqvo;
	}// end of public OneQueryVO oneQueryDetail(String seq_oq) throws SQLException{}

	
	// Ajax(JSON) 를 사용하여 일대일 문의 목록을 "더 보기" 방식으로 페이징 처리하기 위해 전체 문의 수를 알아오는 메소드
	@Override
	public int totalPQACount(String today) throws SQLException {
		int totalPQACount = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = "select count(*)\n"+
						 "from productqa\n"+
						 "where to_char(writeday, 'yyyy-mm-dd') = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, today);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				totalPQACount = rs.getInt(1);
			}// end of if(rs.next()){}---------------------
		} finally {
			close();
		}
		
		return totalPQACount;
	}// end of public int totalPQACount(String today) throws SQLException{}------------------------

	
	// Ajax(JSON) 를 이용하여 "더 보기" 방식(페이징 처리)으로 제품 문의를 5개씩 잘라서(start ~ end) 조회하는 메소드
	@Override
	public List<ProductQAVO> selectPQAByWriteday(Map<String, String> paraMap) throws SQLException {
		List<ProductQAVO> pqaList = new ArrayList<ProductQAVO>();
		
		try {
			conn = ds.getConnection();
			
			String sql = "select seq_qa, userid, fk_productid, content, V.status\n"+
					"from\n"+
					" (\n"+
					" select row_number() over(order by seq_qa asc) AS rno, seq_qa, userid, fk_productid, content, Q.status\n"+
					" from productqa Q\n"+
					" join member M\n"+
					" on Q.fk_memberno = M.memberno\n"+
					" where to_char(writeday, 'yyyy-mm-dd') = ?\n"+
					" ) V\n"+
					"where rno between ? and ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("today"));
			pstmt.setString(2, paraMap.get("start"));
			pstmt.setString(3, paraMap.get("end"));
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductQAVO pqavo = new ProductQAVO();
				
				pqavo.setSeq_qa(rs.getInt(1));
				
				MemberVO mvo = new MemberVO();
				mvo.setUserid(rs.getString(2));
				
				pqavo.setFk_productid(rs.getString(3));
				pqavo.setContent(rs.getString(4));
				pqavo.setStatus(rs.getInt(5));
				pqavo.setMvo(mvo);
				
				pqaList.add(pqavo);
			}// end of while(rs.next()){}---------------------
		} finally {
			close();
		}
		
		return pqaList;
	}// end of public List<ProductQAVO> selectPQAByWriteday(Map<String, String> paraMap) throws SQLException

	
	// 매니저 계정등록 메소드(manager 테이블에 insert)
	@Override
	public int registerManager(ManagerVO mgvo) throws SQLException {
		int result = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "insert into manager(managerno, managerid, managerpwd, managertype, manageremail, managermobile) "
					   + "values(manager_seq.nextval, ?, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mgvo.getManagerid());
			pstmt.setString(2, Sha256.encrypt(mgvo.getManagerpwd()));  // 암호를 SHA256 알고리즘으로 단방향 암호화 한다.
			pstmt.setString(3, mgvo.getManagertype());
			pstmt.setString(4, aes.encrypt(mgvo.getManageremail()));  // 이메일을 AES256 알고리즘으로 양방향 암호화 한다.
			pstmt.setString(5, aes.encrypt(mgvo.getManagermobile()));  // 전화번호를 AES256 알고리즘으로 양방향 암호화 한다.
			
			result = pstmt.executeUpdate();		
			
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}// end of try~finally{}-----------------------
		
		return result;
	}// end of public int registerManager(ManagerVO mgvo) throws SQLException {}-------------------

	// modal 창에서 userid 클릭 시 아이디, 이메일, 전화번호, 수신 정보를 select 하는 메소드
	@Override
	public MemberVO checkAgreeStatus(String userid) throws SQLException {
		MemberVO mvo = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select name, email, mobile\n"+
						 "     , case when agreeemail = '1' then '수신' else '거절' end AS agreeemail\n"+
						 "     , case when agreesms = '1' then '수신' else '거절' end AS agreesms\n"+
						 "from member\n"+
						 "where userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				mvo = new MemberVO();
				mvo.setName(rs.getString(1));
				mvo.setEmail(aes.decrypt(rs.getString(2)));
				mvo.setMobile(aes.decrypt(rs.getString(3)));
				mvo.setAgreeemail(rs.getString(4));
				mvo.setAgreesms(rs.getString(5));
			}// end of if(rs.next()){}------------------------
		
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}// end of try~finally{}----------------------
		
		return mvo;
	}// end of public MemberVO checkAgreeStatus(String userid) throws SQLException {}

	
	// 일대일 문의글에 대한 답변 insert 메소드
	@Override
	public int oneQueryAnswer(Map<String, String> paraMap) throws SQLException {
		int insertResult = 0;
		int updateResult = 0;
		int result = 2;
		
		try {
			
			conn = ds.getConnection();
			conn.setAutoCommit(false);
			
			String sql = "insert into oqanswer(seq_oq, oq_content) "
					   + "values(?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("seq_oq"));
			pstmt.setString(2, paraMap.get("oq_content"));
			
			insertResult = pstmt.executeUpdate();
			
			sql = "update onequery set answerstatus = 1 "
				+ "where seq_oq = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("seq_oq"));
			
			updateResult = pstmt.executeUpdate();
			
			if(insertResult == 1 && updateResult == 1) {
				conn.commit();
				result = 1;
			} else {
				conn.rollback();
			}// end of if(insertResult == 1 && updateResult == 1) {}-----------------------
		} catch(SQLException e) {
			conn.rollback();
		} finally {
			close();
		}// end of try~finally{}-----------------------
		
		return result;
	}// end of public int insertOneQueryAnswer(String seq_oq) throws SQLException {}---------------

	
	// 제품 문의 상세정보 select
	@Override
	public ProductQAVO productQADetail(String seq_qa) throws SQLException {
		ProductQAVO pqavo = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select seq_qa, userid, fk_productid, content\n"+
					" from productqa P\n"+
					" join member M\n"+
					" on P.fk_memberno = M.memberno\n"+
					" where seq_qa = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, seq_qa);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				pqavo = new ProductQAVO();
				
				pqavo.setSeq_qa(rs.getInt(1));
				
				MemberVO mvo = new MemberVO();
				mvo.setUserid(rs.getString(2));
				
				pqavo.setFk_productid(rs.getString(3));
				pqavo.setContent(rs.getString(4));
				pqavo.setMvo(mvo);
			}// end of if(rs.next()){}------------------------
		
		} finally {
			close();
		}// end of try~finally{}----------------------
		
		return pqavo;
	}// end of public ProductQAVO productQADetail(String seq_oq) throws SQLException {}

	
	// 제품 문의글에 대한 답변 insert 및 답변 상태 update 메소드
	@Override
	public int productQAAnswer(Map<String, String> paraMap) throws SQLException {
		int insertResult = 0;
		int updateResult = 0;
		int result = 2;
		
		try {
			
			conn = ds.getConnection();
			conn.setAutoCommit(false);
			
			String sql = "insert into qaanswer(fk_seq_qa, content) "
					   + "values(?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("seq_qa"));
			pstmt.setString(2, paraMap.get("oq_content"));
			
			insertResult = pstmt.executeUpdate();
			
			sql = "update productqa set status = 1 "
				+ "where seq_qa = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("seq_qa"));
			
			updateResult = pstmt.executeUpdate();
			
			if(insertResult == 1 && updateResult == 1) {
				conn.commit();
				result = 1;
			} else {
				conn.rollback();
			}// end of if(insertResult == 1 && updateResult == 1) {}-----------------------
		} catch(SQLException e) {
			conn.rollback();
		} finally {
			close();
		}// end of try~finally{}-----------------------
		
		return result;
	}

	// 전체 회원 대상 탈퇴 상태 업데이트 메소드
	@Override
	public int statusUpdate() throws SQLException {
		int result = 0;
		
		try {
			
			conn = ds.getConnection();
			
			asdasd
			
		} finally {
			close();
		}
		
		return result;
	}
	
	
	// 제품 가격 수정 메소드
	@Override
	public int priceUpdate(Map<String, String> paraMap) throws SQLException {
		int result = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "update product set price = ?\n"+
					 	"where productid = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("price"));
			pstmt.setString(2, paraMap.get("productid"));
			
			result = pstmt.executeUpdate();
		
		} finally {
			close();
		}
		
		return result;
	}// end of public int priceUpdate(Map<String, String> paraMap) throws SQLException {}-----------------

	
	// 제품 정보 수정 메소드
	@Override
	public int productOptionUpdate(ProductOptionVO povo) throws SQLException {
		int result = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "update productoption set productserialid = ?, color = ?, stock = ?\n"+
					 	"where productserialid = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, povo.getProductserialid());
			pstmt.setString(2, povo.getColor());
			pstmt.setInt(3, povo.getStock());
			pstmt.setString(4, povo.getProductserialid());
			
			result = pstmt.executeUpdate();
		
		} finally {
			close();
		}
		
		return result;
	}// end of public int statusUpdate() throws SQLException {}----------------------------

	
	// 주문 제품 배송하여 배송 상태와 배송 제품의 재고량을 수정하는 메소드
	@Override
	public int updateDelivery(Map<String, String> paraMap) throws SQLException {
		int result1 = 0;
		int result2 = 0;
		
		try {
			
			conn = ds.getConnection();
			conn.setAutoCommit(false);
			
			String sql = "update productoption set stock -= ?\n"+
					 	"where productserialid = ?";
			
			int stock = Integer.parseInt(paraMap.get("stock"));
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, stock);
			pstmt.setString(2, paraMap.get("productserialid"));
			
			result1 = pstmt.executeUpdate();
			
			sql = "update purchasedetail set deliverystatus = '배송완료'\n"+
				 "where purchasedetailid = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("purchasedetailid"));
			
			result2 = pstmt.executeUpdate();
			
			if(result1 == 1 && result2 == 1) {
				conn.commit();
			} else {
				conn.rollback();
			}
			
			
			
			
		} catch(SQLException e) {
			conn.rollback();
		} finally {
			close();
		}
		
		return result2;
	}// end of public int updateDelivery(Map<String, String> paraMap) throws SQLException {}
	
	
}