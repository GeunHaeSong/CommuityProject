package com.sgh.community.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sgh.community.dao.MemberDao;
import com.sgh.community.domain.BoardVo;
import com.sgh.community.domain.CommentVo;
import com.sgh.community.domain.MemberLoginVo;
import com.sgh.community.domain.MemberVo;
import com.sgh.community.domain.ModalPagingDto;
import com.sgh.community.domain.PwFindVo;
import com.sgh.community.domain.SuspensionCheckVo;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Inject
	private MemberDao memberDao;
	
	// 아이디 중복 확인
	@Override
	public int idDupCheck(String member_id) throws Exception {
		return memberDao.idDupCheck(member_id);
	}

	// 이메일 중복 확인
	@Override
	public int emailDupCheck(String member_email) throws Exception {
		return memberDao.emailDupCheck(member_email);
	}

	// 회원가입
	@Override
	public void insertMember(MemberVo memberVo) throws Exception {
		memberDao.insertMember(memberVo);
	}

	// 로그인(트랜잭션)
	// 멤버가 오늘 로그인을 처음 했다면 방문 테이블에 추가시키기
	// 로그인 시간 업데이트 시키고 로그인 시키기
	@Transactional
	@Override
	public MemberLoginVo selectMember(String member_id) throws Exception {
		int checkNum = memberDao.memberTodayCheck(member_id);
		if(checkNum == 0) {
			memberDao.insertCheck(member_id);
		}
		memberDao.loginCheck(member_id);
		return memberDao.selectMember(member_id);
	}
	
	// 정지 됐는지 확인하기
	// 정지 일이 지났다면 업데이트 시켜서 state를 비활성화 시키기
	@Transactional
	@Override
	public String selectSuspension(String member_id) {
		try {
			SuspensionCheckVo suspensionCheckVo = memberDao.selectSuspension(member_id);
			if(suspensionCheckVo != null) {
				int suspension_no = suspensionCheckVo.getSuspension_no();
				String suspension_end_date = suspensionCheckVo.getSuspension_end_date();
				
				// 시간을 비교해서 업데이트 시키기
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
				Date now = new Date();
				Date end_date = format.parse(suspension_end_date);
				int result = now.compareTo(end_date);
				
				if(result > 0) {
					memberDao.updateLoginSuspension(member_id, suspension_no);
					return null;
				}
				return suspension_end_date;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}


	// 아이디 찾기
	@Override
	public String selectIdFind(String member_name, String member_email) throws Exception {
		return memberDao.selectIdFind(member_name, member_email);
	}

	// 비밀번호 찾기
	@Override
	public int selectPwFind(PwFindVo pwFindVo) throws Exception {
		return memberDao.selectPwFind(pwFindVo);
	}

	// 비밀번호 변경(비밀번호 찾기 진행 시)
	@Override
	public void pwChange(String member_id, String member_pw) throws Exception {
		memberDao.pwChange(member_id, member_pw);
	}

	// 개인 정보 조회
	@Override
	public MemberVo memberInfo(String member_id) throws Exception {
		return memberDao.memberInfo(member_id);
	}
	
	// 개인 정보 수정 실행
	@Override
	public void memberInfoModify(MemberVo memberVo) throws Exception {
		memberDao.memberInfoModify(memberVo);
	}

	// 게시글 수와 댓글 수 조회
	@Override
	public Map<String, Integer> memberBoardCommentCount(String member_id) throws Exception {
		return memberDao.memberBoardCommentCount(member_id);
	}

	// 마이페이지 게시글 보여주기
	@Override
	public List<BoardVo> myPageShowBoard(String member_id, ModalPagingDto modalPagingDto) throws Exception {
		return memberDao.myPageShowBoard(member_id, modalPagingDto);
	}

	// 마이페이지 댓글 보여주기
	@Override
	public List<CommentVo> myPageShowComment(String member_id, ModalPagingDto modalPagingDto) throws Exception {
		return memberDao.myPageShowComment(member_id, modalPagingDto);
	}
	
	// 회원 탈퇴
	@Override
	public int memberWthdr(String member_id) throws Exception {
		return memberDao.memberWthdr(member_id);
	}
}
