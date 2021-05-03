package com.sgh.community.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sgh.community.dao.AdminDao;
import com.sgh.community.dao.CommentDao;
import com.sgh.community.domain.BoardVo;
import com.sgh.community.domain.CategoryVo;
import com.sgh.community.domain.ChartDto;
import com.sgh.community.domain.CommentVo;
import com.sgh.community.domain.MemberMngVo;
import com.sgh.community.domain.PagingDto;
import com.sgh.community.domain.SuspensionVo;

@Service
public class AdminServiceImpl implements AdminService {

	@Inject
	private AdminDao adminDao;
	@Inject
	private CommentDao commentDao;

	// 차트 정보 관리
	@Override
	public List<ChartDto> showChartInfo() throws Exception {
		return adminDao.showChartInfo();
	}

	// 회원 정보 리스트
	@Override
	public List<MemberMngVo> memberMngList(PagingDto pagingDto) throws Exception {
		return adminDao.memberMngList(pagingDto);
	}

	// 회원정보 페이징에 필요한 총 유저 수 가져오기
	@Override
	public int memberCount(PagingDto pagingDto) throws Exception {
		return adminDao.memberCount(pagingDto);
	}
	
	// state 변경 시키기
	@Override
	public void updateMemberState(String member_id, String member_state) throws Exception {
		adminDao.updateMemberState(member_id, member_state);
	}


	// 탈퇴 기록 보여주기
	@Override
	public String showWthdrDate(String member_id) throws Exception {
		return adminDao.showWthdrDate(member_id);
	}

	// 정지 내역 보여주기
	@Override
	public List<SuspensionVo> showSuspensionRecord(String member_id) throws Exception {
		return adminDao.showSuspensionRecord(member_id);
	}
	
	// 정지 내역 총 숫자
	@Override
	public int showSuspensionRecordCount(String member_id) throws Exception {
		return adminDao.showSuspensionRecordCount(member_id);
	}


	// 정지 시키기
	@Override
	public void insertSuspension(SuspensionVo suspensionVo) throws Exception {
		adminDao.insertSuspension(suspensionVo);
	}

	// 정지 풀어주기
	@Override
	public void updateSuspension(int suspension_no, String member_id) throws Exception {
		adminDao.updateSuspension(suspension_no, member_id);
	}

	// 게시글 가져오기(전체)
	@Override
	public List<BoardVo> adminSelectBoardList(PagingDto pagingDto) throws Exception {
		return adminDao.adminSelectBoardList(pagingDto);
	}

	// 게시글 숫자 가져오기(전체)
	@Override
	public int adminSelectBoardCount(PagingDto pagingDto) throws Exception {
		return adminDao.adminSelectBoardCount(pagingDto);
	}

	// 관리자 게시글 삭제
	@Override
	public void adminBoardDelete(int board_num) throws Exception {
		adminDao.adminBoardDelete(board_num);
	}

	// 관리자 게시글 복구
	@Override
	public void adminBoardRestore(int board_num) throws Exception {
		adminDao.adminBoardRestore(board_num);
	}

	// 댓글 가져오기(전체)
	@Override
	public List<CommentVo> adminSelectCommentList(PagingDto pagingDto) throws Exception {
		return adminDao.adminSelectCommentList(pagingDto);
	}

	// 댓글 숫자 가져오기(전체)
	@Override
	public int adminCommentCount(PagingDto pagingDto) throws Exception {
		return adminDao.adminCommentCount(pagingDto);
	}

	// 댓글 삭제(어드민)
	@Transactional
	@Override
	public void adminCommentDelete(int comment_num) throws Exception {
		String board_num = adminDao.selectBoardNum(comment_num);
		commentDao.deleteCommentCount(board_num);
		adminDao.adminCommentDelete(comment_num);
	}

	// 댓글 복구(어드민)
	@Override
	public void adminCommentRestore(int comment_num) throws Exception {
		String board_num = adminDao.selectBoardNum(comment_num);
		commentDao.updateCommentCount(board_num);
		adminDao.adminCommentRestore(comment_num);
	}

	// 게시글 댓글 수를 포함하는 카테고리(어드민)
	@Override
	public List<CategoryVo> selectCategoryList(PagingDto pagingDto) throws Exception {
		return adminDao.selectCategoryList(pagingDto);
	}
	
	// 카테고리 숫자 가져오기(어드민)
	@Override
	public int adminCategoryCount(PagingDto pagingDto) throws Exception {
		return adminDao.adminCategoryCount(pagingDto);
	}

	// 세팅에 사용할 카테고리 목록 가져오기
	@Override
	public List<CategoryVo> selectSetCategoryList() throws Exception {
		return adminDao.selectSetCategoryList();
	}
	
	// 카테고리 권한 변경
	@Override
	public void accessChange(String category_code, String category_access) throws Exception {
		adminDao.accessChange(category_code, category_access);
	}

	// 카테고리 삭제
	@Override
	public void deleteCategory(String category_code) throws Exception {
		adminDao.deleteCategory(category_code);
	}

	// 카테고리 복구
	@Override
	public void restoreCategory(String category_code) throws Exception {
		adminDao.restoreCategory(category_code);
	}

	// 카테고리 생성
	@Override
	public void insertCategory(String category_name, String category_access) throws Exception {
		adminDao.insertCategory(category_name, category_access);
	}

	// 카테고리 순서 변경
	@Override
	public void updateCategoryOrder(String[] category_code_arr, String[] category_order_arr) throws Exception {
		// 최대 길이 알아내서 길이만큼 배열에서 값을 빼내어 실행시키기
		int length = category_code_arr.length;
		for(int i = 0; i < length; i++) {
			String category_code = category_code_arr[i];
			String category_order_st = category_order_arr[i];
			if(category_order_st.equals("undefined")) {
				category_order_st = "0";
			}
			int category_order = Integer.parseInt(category_order_st);
			adminDao.updateCategoryOrder(category_code, category_order);
		}
	}

	// 살아있는 카테고리 숫자
	@Override
	public int liveCategoryCount() throws Exception {
		return adminDao.liveCategoryCount();
	}
}
