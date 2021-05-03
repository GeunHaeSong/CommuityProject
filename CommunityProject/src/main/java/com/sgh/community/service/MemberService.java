package com.sgh.community.service;

import java.util.List;
import java.util.Map;

import com.sgh.community.domain.BoardVo;
import com.sgh.community.domain.CommentVo;
import com.sgh.community.domain.MemberLoginVo;
import com.sgh.community.domain.MemberVo;
import com.sgh.community.domain.ModalPagingDto;
import com.sgh.community.domain.PwFindVo;

public interface MemberService {

	// 아이디 중복 체크
	public int idDupCheck(String member_id) throws Exception;
	// 이메일 중복 체크
	public int emailDupCheck(String member_email) throws Exception;
	// 회원가입
	public void insertMember(MemberVo memberVo) throws Exception;
	// 로그인 처리
	public MemberLoginVo selectMember(String member_id) throws Exception;
	// 로그인 할 때 정지 됐는지 체크하기
	public String selectSuspension(String member_id) throws Exception;
	// 아이디 찾기
	public String selectIdFind(String member_name, String member_email) throws Exception;
	// 비밀번호 찾기
	public int selectPwFind(PwFindVo pwFindVo) throws Exception;
	// 비밀번호 변경
	public void pwChange(String member_id, String member_pw) throws Exception;
	// 개인 정보 조회
	public MemberVo memberInfo(String member_id) throws Exception;
	// 개인 정보 수정
	public void memberInfoModify(MemberVo memberVo) throws Exception;
	// 멤버의 게시글 댓글 수 조회
	public Map<String, Integer> memberBoardCommentCount(String member_id) throws Exception;
	// 마이페이지 게시글 가져오기
	public List<BoardVo> myPageShowBoard(String member_id, ModalPagingDto modalPagingDto) throws Exception;
	// 마이페이지 댓글 가져오기
	public List<CommentVo> myPageShowComment(String member_id, ModalPagingDto modalPagingDto) throws Exception;
	// 멤버 탈퇴 처리
	public int memberWthdr(String member_id) throws Exception;
}
