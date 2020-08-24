package com.sgh.community.dao;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.sgh.community.domain.MemberLoginVo;
import com.sgh.community.domain.MemberVo;
import com.sgh.community.domain.PwFindVo;

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
	public MemberLoginVo selectMember(String member_id, String member_pw) throws Exception {
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("member_id", member_id);
		paramMap.put("member_pw", member_pw);
		return sqlSession.selectOne(NAMESPACE + "selectMember", paramMap);
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
}
