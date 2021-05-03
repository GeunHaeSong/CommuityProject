package com.sgh.community.dao;

import java.util.List;

import com.sgh.community.domain.BoardVo;
import com.sgh.community.domain.CategoryVo;
import com.sgh.community.domain.ChartDto;
import com.sgh.community.domain.CommentVo;
import com.sgh.community.domain.MemberMngVo;
import com.sgh.community.domain.PagingDto;
import com.sgh.community.domain.SuspensionVo;

public interface AdminDao {
	// 차트 정보 가져오기
	public List<ChartDto> showChartInfo() throws Exception;
	// 회원정보 관리 리스트 가져오기
	public List<MemberMngVo> memberMngList(PagingDto pagingDto) throws Exception;
	// 회원정보 페이징에 필요한 총 유저 수 가져오기
	public int memberCount(PagingDto pagingDto) throws Exception;
	// state 변경 시키기
	public void updateMemberState(String member_id, String member_state) throws Exception;
	// 탈퇴 기록 보여주기
	public String showWthdrDate(String member_id) throws Exception;
	// 정지 내역 보여주기
	public List<SuspensionVo> showSuspensionRecord(String member_id) throws Exception;
	// 정지 내역 총 숫자
	public int showSuspensionRecordCount(String member_id) throws Exception;
	// 정지시키기
	public void insertSuspension(SuspensionVo suspensionVo) throws Exception;
	// 정지 해제시키기
	public void updateSuspension(int suspension_no, String member_id) throws Exception;
	// 게시글 목록 가져오기(전체)
	public List<BoardVo> adminSelectBoardList(PagingDto pagingDto) throws Exception;
	// 게시글 숫자 가져오기(전체)
	public int adminSelectBoardCount(PagingDto pagingDto) throws Exception;
	// 게시글 삭제 복구에 필요한 게시글 번호 가져오기
	public String selectBoardNum(int comment_num) throws Exception;
	// 게시글 삭제(어드민)
	public void adminBoardDelete(int board_num) throws Exception;
	// 게시글 복구(어드민)
	public void adminBoardRestore(int board_num) throws Exception;
	// 댓글 목록 가져오기(전체)
	public List<CommentVo> adminSelectCommentList(PagingDto pagingDto) throws Exception;
	// 댓글 숫자 가져오기(전체)
	public int adminCommentCount(PagingDto pagingDto) throws Exception;
	// 댓글 복구(어드민)
	public void adminCommentDelete(int comment_num) throws Exception;
	// 댓글 삭제(어드민)
	public void adminCommentRestore(int comment_num) throws Exception;
	// 게시글 댓글 수를 포함하는 카테고리(어드민)
	public List<CategoryVo> selectCategoryList(PagingDto pagingDto) throws Exception;
	// 카테고리 총 숫자 가져오기(어드민)
	public int adminCategoryCount(PagingDto pagingDto) throws Exception;
	// 세팅에 사용할 카테고리 목록 가져오기
	public List<CategoryVo> selectSetCategoryList() throws Exception;
	// 카테고리 권한 변경
	public void accessChange(String category_code, String category_access) throws Exception;
	// 카테고리 삭제
	public void deleteCategory(String category_code) throws Exception;
	// 카테고리 복구
	public void restoreCategory(String category_code) throws Exception;
	// 카테고리 생성
	public void insertCategory(String category_name, String category_access) throws Exception;
	// 카테고리 순서 변경
	public void updateCategoryOrder(String category_code, int category_order) throws Exception;
	// 살아있는 카테고리 숫자
	public int liveCategoryCount() throws Exception;
}
