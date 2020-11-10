package member.model;

import java.sql.SQLException;

public interface InterMemberDAO {

	// 아이디 중복체크 메서드 (tbl_member 테이블에서 userid가 존재하면 true, 존재하지 않으면 false 리턴)
	boolean useridDuplicateCheck(String userid) throws SQLException;
	
	// 이메일 중복체크 메서드 (tbl_member 테이블에서 email가 존재하면 true, 존재하지 않으면 false 리턴)
	boolean emailDuplicateCheck(String email) throws SQLException;

	// 회원가입 메서드 (가입한 회원의 정보를 DB에 넣는다)
	int registerMember(MemberVO member) throws SQLException;

	
	
}
