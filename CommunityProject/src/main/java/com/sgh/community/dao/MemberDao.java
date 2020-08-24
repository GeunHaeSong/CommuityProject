package com.sgh.community.dao;

import com.sgh.community.domain.MemberLoginVo;
import com.sgh.community.domain.MemberVo;
import com.sgh.community.domain.PwFindVo;

public interface MemberDao {

	// 아이디 중복 체크
	public int idDupCheck(String member_id) throws Exception;
	// 이메일 중복 체크
	public int emailDupCheck(String member_email) throws Exception;
	// 회원가입
	public void insertMember(MemberVo memberVo) throws Exception;
	// 로그인 처리
	public MemberLoginVo selectMember(String member_id, String member_pw) throws Exception;
	// 아이디 찾기
	public String selectIdFind(String member_name, String member_email) throws Exception;
	// 비밀번호 찾기
	public int selectPwFind(PwFindVo pwFindVo) throws Exception;
	// 비밀번호 변경
	public void pwChange(String member_id, String member_pw) throws Exception;
}
