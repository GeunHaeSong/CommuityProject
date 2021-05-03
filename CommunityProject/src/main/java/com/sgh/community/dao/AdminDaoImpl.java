package com.sgh.community.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.sgh.community.domain.BoardVo;
import com.sgh.community.domain.CategoryVo;
import com.sgh.community.domain.ChartDto;
import com.sgh.community.domain.CommentVo;
import com.sgh.community.domain.MemberMngVo;
import com.sgh.community.domain.PagingDto;
import com.sgh.community.domain.SuspensionVo;

@Repository
public class AdminDaoImpl implements AdminDao {

	private final String NAMESPACE = "mappers.admin-mapper.";
	@Inject
	private SqlSession sqlSession;
	
	// 차트 정보 가져오기
	@Override
	public List<ChartDto> showChartInfo() throws Exception {
		return sqlSession.selectList(NAMESPACE + "showChartInfo");
	}

	// 회원 관리 리스트 가져오기
	@Override
	public List<MemberMngVo> memberMngList(PagingDto pagingDto) throws Exception {
		return sqlSession.selectList(NAMESPACE + "memberMngList", pagingDto);
	}

	// 회원정보 페이징에 필요한 총 유저 수 가져오기
	@Override
	public int memberCount(PagingDto pagingDto) throws Exception {
		return sqlSession.selectOne(NAMESPACE + "memberCount", pagingDto);
	}
	
	// state 변경 시키기
	@Override
	public void updateMemberState(String member_id, String member_state) throws Exception {
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("member_id", member_id);
		paramMap.put("member_state", member_state);
		sqlSession.update(NAMESPACE + "updateMemberState", paramMap);
	}

	// 탈퇴 기록 보여주기
	@Override
	public String showWthdrDate(String member_id) throws Exception {
		return sqlSession.selectOne(NAMESPACE + "showWthdrDate", member_id);
	}

	// 정지 내역 보여주기
	@Override
	public List<SuspensionVo> showSuspensionRecord(String member_id) throws Exception {
		return sqlSession.selectList(NAMESPACE + "showSuspensionRecord", member_id);
	}
	
	// 정지 내역 총 숫자
	@Override
	public int showSuspensionRecordCount(String member_id) throws Exception {
		return sqlSession.selectOne(NAMESPACE + "showSuspensionRecordCount", member_id);
	}


	// 정지시키기
	@Override
	public void insertSuspension(SuspensionVo suspensionVo) throws Exception {
		sqlSession.insert(NAMESPACE + "insertSuspension", suspensionVo);
	}

	// 정지 해제 시키기
	@Override
	public void updateSuspension(int suspension_no, String member_id) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("suspension_no", suspension_no);
		paramMap.put("member_id", member_id);
		sqlSession.update(NAMESPACE + "updateSuspension", paramMap);
	}

	// 게시글 가져오기(전체)
	@Override
	public List<BoardVo> adminSelectBoardList(PagingDto pagingDto) throws Exception {
		return sqlSession.selectList(NAMESPACE + "adminSelectBoardList", pagingDto);
	}

	// 게시글 숫자 가져오기(전체)
	@Override
	public int adminSelectBoardCount(PagingDto pagingDto) throws Exception {
		return sqlSession.selectOne(NAMESPACE + "adminSelectBoardCount", pagingDto);
	}
	
	// 세팅에 사용할 카테고리 목록 가져오기
	@Override
	public List<CategoryVo> selectSetCategoryList() throws Exception {
		return sqlSession.selectList(NAMESPACE + "selectSetCategoryList");
	}

	// 관리자 게시글 삭제
	@Override
	public void adminBoardDelete(int board_num) throws Exception {
		sqlSession.update(NAMESPACE + "adminBoardDelete", board_num);
	}
	
	// 관리자 게시글 복구
	@Override
	public void adminBoardRestore(int board_num) throws Exception {
		sqlSession.update(NAMESPACE + "adminBoardRestore", board_num);
	}

	// 댓글 가져오기(전체)
	@Override
	public List<CommentVo> adminSelectCommentList(PagingDto pagingDto) throws Exception {
		return sqlSession.selectList(NAMESPACE + "adminSelectCommentList", pagingDto);
	}

	// 댓글 총 숫자 가져오기(전체)
	@Override
	public int adminCommentCount(PagingDto pagingDto) throws Exception {
		return sqlSession.selectOne(NAMESPACE + "adminCommentCount", pagingDto);
	}

	// 게시글 삭제 복구에 필요한 게시글 번호 가져오기
	@Override
	public String selectBoardNum(int comment_num) throws Exception {
		return sqlSession.selectOne(NAMESPACE + "selectBoardNum", comment_num);
	}
		
	// 댓글 삭제(어드민)
	@Override
	public void adminCommentDelete(int comment_num) throws Exception {
		sqlSession.update(NAMESPACE + "adminCommentDelete", comment_num);
	}

	// 댓글 복구(어드민)
	@Override
	public void adminCommentRestore(int comment_num) throws Exception {
		sqlSession.update(NAMESPACE + "adminCommentRestore", comment_num);
	}

	// 게시글 댓글 수를 포함하는 카테고리(어드민)
	@Override
	public List<CategoryVo> selectCategoryList(PagingDto pagingDto) throws Exception {
		return sqlSession.selectList(NAMESPACE + "selectCategoryList", pagingDto);
	}
	
	// 카테고리 숫자 가져오기(어드민)
	@Override
	public int adminCategoryCount(PagingDto pagingDto) throws Exception {
		return sqlSession.selectOne(NAMESPACE + "adminCategoryCount", pagingDto);
	}

	// 카테고리 권한 변경
	@Override
	public void accessChange(String category_code, String category_access) throws Exception {
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("category_code", category_code);
		paramMap.put("category_access", category_access);
		sqlSession.update(NAMESPACE + "accessChange", paramMap);
	}

	// 카테고리 삭제
	@Override
	public void deleteCategory(String category_code) throws Exception {
		sqlSession.update(NAMESPACE + "deleteCategory", category_code);
	}

	// 카테고리 복구
	@Override
	public void restoreCategory(String category_code) throws Exception {
		sqlSession.update(NAMESPACE + "restoreCategory", category_code);
	}

	// 카테고리 생성
	@Override
	public void insertCategory(String category_name, String category_access) throws Exception {
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("category_name", category_name);
		paramMap.put("category_access", category_access);
		sqlSession.insert(NAMESPACE + "insertCategory", paramMap);
	}

	// 카테고리 순서 변경
	@Override
	public void updateCategoryOrder(String category_code, int category_order) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("category_code", category_code);
		paramMap.put("category_order", category_order);
		sqlSession.update(NAMESPACE + "updateCategoryOrder", paramMap);
	}

	// 살아있는 카테고리 숫자
	@Override
	public int liveCategoryCount() throws Exception {
		return sqlSession.selectOne(NAMESPACE + "liveCategoryCount");
	}
}
