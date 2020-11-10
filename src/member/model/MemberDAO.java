package member.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import util.security.AES256;
import util.security.SecretMyKey;
import util.security.Sha256;

public class MemberDAO implements InterMemberDAO {
	
	private DataSource ds;
	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	// 기본생성자
	public MemberDAO() {
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

	// 이메일 중복검사 메서드 (tbl_member 테이블에서 userid가 존재하면 true, 존재하지 않으면 false 리턴)
	@Override
	public boolean useridDuplicateCheck(String userid) throws SQLException {
		
		boolean isExist = false;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select userid\n"+
					"from member\n"+
					"where userid = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			// 행이 있으면(중복) true, 없으면(중복x) false 반환
			isExist = rs.next();
			
		} finally {
			close();
		}
		
		return isExist;
	}
	
	// 이메일 중복체크 메서드 (tbl_member 테이블에서 email가 존재하면 true, 존재하지 않으면 false 리턴)
	@Override
	public boolean emailDuplicateCheck(String email) throws SQLException {
		
		boolean isExist = false;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select email\n"+
					"from member\n"+
					"where email = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, aes.encrypt(email));
			
			rs = pstmt.executeQuery();
			
			// 행이 있으면(중복) true, 없으면(중복x) false 반환
			isExist = rs.next();
			
		} catch (UnsupportedEncodingException | GeneralSecurityException  e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return isExist;
	}

	// 회원가입 메서드 (가입한 회원의 정보를 DB에 넣는다)
	@Override
	public int registerMember(MemberVO member) throws SQLException {
	
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " insert into member(memberno, userid, pwd, name, email, mobile, birthday, agreethird, agreesms, agreeemail)\n" + 
					" values(member_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			
			/* 회원가입 동의 유무 받아오기
			 * 받아와서 멤버레지스터액션에서 MemberVO에 넣어주기
			 * 그럼 여기선 agree 항목들도 넣어줘야 함 */
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getUserid());
			pstmt.setString(2, Sha256.encrypt(member.getPwd()));	// 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다.
			pstmt.setString(3, member.getName());
			pstmt.setString(4, aes.encrypt(member.getEmail()));		// 이메일을 AES256 알고리즘으로 양방향 암호화 시킨다
			pstmt.setString(5, aes.encrypt(member.getMobile()));	// 전화번호을 AES256 알고리즘으로 양방향 암호화 시킨다
			pstmt.setString(6, member.getBirthday());
			pstmt.setString(7, member.getAgreethird());
			pstmt.setString(8, member.getAgreesms());
			pstmt.setString(9, member.getAgreeemail());
			
			result = pstmt.executeUpdate();
			
			
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return result;
	}

	// 아이디 찾기 메서드
	@Override
	public String findUserid(Map<String, String> paraMap) throws SQLException {
		
		String result = "";

		try {
			
			conn = ds.getConnection();
			
			String sql = "select userid\n"+
					"from member\n"+
					"where status = 0 and name = ? and email = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("name"));
			pstmt.setString(2, aes.encrypt(paraMap.get("email")));
			
			rs = pstmt.executeQuery();
			
			// 행이 있으면(중복) true, 없으면(중복x) false 반환
			if (rs.next()) {
				result = rs.getString(1);
			};
			
		} catch (UnsupportedEncodingException | GeneralSecurityException  e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		
		
		return result;
	}

	

}
