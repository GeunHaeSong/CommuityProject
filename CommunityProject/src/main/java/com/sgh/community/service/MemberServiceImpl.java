package com.sgh.community.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.sgh.community.dao.MemberDao;
import com.sgh.community.domain.MemberLoginVo;
import com.sgh.community.domain.MemberVo;
import com.sgh.community.domain.PwFindVo;

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

	// 로그인
	@Override
	public MemberLoginVo selectMember(String member_id, String member_pw) throws Exception {
		return memberDao.selectMember(member_id, member_pw);
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
}
