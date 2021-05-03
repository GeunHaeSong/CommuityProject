package com.sgh.community.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.sgh.community.domain.BoardVo;
import com.sgh.community.domain.CommentVo;
import com.sgh.community.domain.MemberLoginVo;
import com.sgh.community.domain.MemberVo;
import com.sgh.community.domain.ModalPagingDto;
import com.sgh.community.domain.PwFindVo;
import com.sgh.community.domain.SuspensionCheckVo;

@Repository
public class MemberDaoImpl implements MemberDao {

	private final String NAMESPACE = "mappers.member-mapper.";
	
	@Inject
	private SqlSession sqlSession;
	
	// 아이디 중복 체크
	@Override
	public int idDupCheck(String member_id) throws Exception {
		return sqlSession.selectOne(NAMESPACE + "idDupCheck", member_id);
	}

	// 이메일 중복 체크
	@Override
	public int emailDupCheck(String member_email) throws Exception {
		return sqlSession.selectOne(NAMESPACE + "emailDupCheck", member_email);
	}

	// 회원가입
	@Override
	public void insertMember(MemberVo memberVo) throws Exception {
		sqlSession.insert(NAMESPACE + "insertMember", memberVo);
	}

	// 회원 찾아서 로그인
	@Override
	public MemberLoginVo selectMember(String member_id) throws Exception {
		return sqlSession.selectOne(NAMESPACE + "selectMember", member_id);
	}
	
	// 로그인 할 때 멤버 로그인 시간 업데이트 시키기
	@Override
	public void loginCheck(String member_id) throws Exception {
		sqlSession.update(NAMESPACE + "loginCheck", member_id);
	}
	
	// 로그인 할 때 정지 됐는지 체크하기
	@Override
	public SuspensionCheckVo selectSuspension(String member_id) throws Exception {
		return sqlSession.selectOne(NAMESPACE + "selectSuspension", member_id);
	}

	// 정지 시간이 지났으면 state N으로 업데이트
	@Override
	public void updateLoginSuspension(String member_id, int suspension_no) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("member_id", member_id);
		paramMap.put("suspension_no", suspension_no);
		sqlSession.update(NAMESPACE + "updateLoginSuspension", paramMap);
	}


	// 오늘 방문했는지 체크하기
	@Override
	public int memberTodayCheck(String member_id) throws Exception {
		return sqlSession.selectOne(NAMESPACE + "memberTodayCheck", member_id);
	}

	// 로그인 시간 하루에 한번 방문 테이블에 넣기
	@Override
	public void insertCheck(String member_id) throws Exception {
		sqlSession.insert(NAMESPACE + "insertCheck", member_id);
	}

	// 아이디 찾기
	@Override
	public String selectIdFind(String member_name, String member_email) throws Exception {
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("member_name", member_name);
		paramMap.put("member_email", member_email);
		return sqlSession.selectOne(NAMESPACE + "selectIdFind", paramMap);
	}

	// 비밀번호 찾기
	@Override
	public int selectPwFind(PwFindVo pwFindVo) throws Exception {
		return sqlSession.selectOne(NAMESPACE + "selectPwFind", pwFindVo);
	}

	// 비밀번호 변경
	@Override
	public void pwChange(String member_id, String member_pw) throws Exception {
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("member_id", member_id);
		paramMap.put("member_pw", member_pw);
		sqlSession.update(NAMESPACE + "pwChange", paramMap);
	}

	// 개인 정보 조회
	@Override
	public MemberVo memberInfo(String member_id) throws Exception {
		return sqlSession.selectOne(NAMESPACE + "memberInfo", member_id);
	}
	
	// 개인 정보 수정 실행
	@Override
	public void memberInfoModify(MemberVo memberVo) throws Exception {
		sqlSession.update(NAMESPACE + "memberInfoModify", memberVo);
	}

	// 멤버 게시글 댓글 수 조회
	@Override
	public Map<String, Integer> memberBoardCommentCount(String member_id) throws Exception {
		return sqlSession.selectOne(NAMESPACE + "memberBoardCommentCount", member_id);
	}

	// 마이페이지 게시글 보여주기
	@Override
	public List<BoardVo> myPageShowBoard(String member_id, ModalPagingDto modalPagingDto) throws Exception {
		Map<String, String> paramMap = new HashMap<>();
		String startRow = String.valueOf(modalPagingDto.getStartRow());
		String endRow = String.valueOf(modalPagingDto.getEndRow());
		paramMap.put("member_id", member_id);
		paramMap.put("startRow", startRow);
		paramMap.put("endRow", endRow);
		return sqlSession.selectList(NAMESPACE + "myPageShowBoard", paramMap);
	}

	// 마이페이지 댓글 보여주기
	@Override
	public List<CommentVo> myPageShowComment(String member_id, ModalPagingDto modalPagingDto) throws Exception {
		Map<String, String> paramMap = new HashMap<>();
		String startRow = String.valueOf(modalPagingDto.getStartRow());
		String endRow = String.valueOf(modalPagingDto.getEndRow());
		paramMap.put("member_id", member_id);
		paramMap.put("startRow", startRow);
		paramMap.put("endRow", endRow);
		return sqlSession.selectList(NAMESPACE + "myPageShowComment", paramMap);
	}

	// 멤버 탈퇴 처리
	@Override
	public int memberWthdr(String member_id) throws Exception {
		return sqlSession.update(NAMESPACE + "memberWthdr", member_id);
	}
}
