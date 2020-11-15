package member.model;

import java.sql.SQLException;
import java.util.Map;

public interface InterMemberDAO {

	// 아이디 중복체크 메서드 (tbl_member 테이블에서 userid가 존재하면 true, 존재하지 않으면 false 리턴)
	boolean useridDuplicateCheck(String userid) throws SQLException;
	
	// 이메일 중복체크 메서드 (tbl_member 테이블에서 email가 존재하면 true, 존재하지 않으면 false 리턴)
	boolean emailDuplicateCheck(String email) throws SQLException;

	// 회원가입 메서드 (가입한 회원의 정보를 DB에 넣는다)
	int registerMember(MemberVO member) throws SQLException;

	// 아이디 찾기 메서드
	String findUserid(Map<String, String> paraMap) throws SQLException;

	// 아이디, 비밀번호로 회원 하나 검색하는 메서드 (로그인에서 사용)
	MemberVO selectOneMember(Map<String, String> paraMap) throws SQLException;

	// 입력받은 정보[아이디, 전화번호]가 DB에 저장되어 있는지 아닌지 찾는 메서드 (비밀번호 찾기)
	boolean pwdFindOneMember(Map<String, String> paraMap) throws SQLException;

	// 새로운 비밀번호를 지정해주는 메서드 (비밀번호 찾기)
	int updatePwd(String userid, String newPwd) throws SQLException;

	// joinevent 테이블에서 이미 이벤트에 참여한 회원인지 검사하는 메서드(이벤트참여)
	boolean joinEventCheck(String seq_event, String memberno) throws SQLException;
	
	// joinevent 테이블에 데이터를 넣어 이벤트 참여를 시켜주는 메서드 (이벤트참여)
	int insertEventMember(String seq_event, String memberno, String eventcomment) throws SQLException;

	
	
}
