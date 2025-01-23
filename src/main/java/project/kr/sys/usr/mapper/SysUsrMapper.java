package project.kr.sys.usr.mapper;

import org.apache.ibatis.annotations.Mapper;
import project.kr.review.entity.ReviewVO;
import project.kr.sys.login.entity.LoginSession;
import project.kr.sys.usr.entity.SysUsrVO;

import java.util.List;

@Mapper
public interface SysUsrMapper {

    /**
     * 유저 상세
     */
    SysUsrVO getSysUsrDetail(LoginSession vo);

    /**
     * 유저 사진 정보
     */
    SysUsrVO getSysUsrImg(LoginSession vo);

    /**
     * 로그인 세션용 유저 상세
     */
    SysUsrVO getLoginSession(SysUsrVO vo);

    /**
     * 유저 회원가입
     */
    int insertUsr(SysUsrVO vo);

    /**
     * 신규 유저 상세정보 등록
     */
    int insertUsrDetail(SysUsrVO vo);

    /**
     * 회원가입 아이디 체크
     */
    int idCheck(String id);

    /**
     * 유저 테이블 정보 수정
     */
    int updateUsrProfile(SysUsrVO vo);

    /**
     * 유저 상세 테이블 정보 수정
     */
    int updateUsrDetailProfile(SysUsrVO vo);

    /**
     * 회원탈퇴 비밀번호 확인
     */
    SysUsrVO checkPassword(SysUsrVO vo);

    /**
     * 회원탈퇴 진행
     */
    int withdrawAccount(SysUsrVO vo);

    /**
     * 유저 상세조회 (유저 페이지)
     */
    SysUsrVO getUsrDetail(SysUsrVO vo);

    /**
     * 리뷰 수 통계
     */
    Integer getReviewStatCnt(SysUsrVO vo);

    /**
     * 코멘트 수 통계
     */
    Integer getCommentStatCnt(SysUsrVO vo);

    /**
     * 평균 별점 통계
     */
    Double getRatingStatAvg(SysUsrVO vo);

    /**
     * 유저 평점 데이터 조회
     */
    List<ReviewVO> getRatingByUser(SysUsrVO vo);

    /**
     * 클릭한 영화에 대한 평점 조회
     */
    ReviewVO getRatingOne(SysUsrVO vo);

    /**
     * 유저 리뷰 전체 조회
     */
    List<ReviewVO> getUsrReviewList(SysUsrVO vo);

    /**
     * 프로필 이미지 삭제
     */
    int deleteUsrImg(SysUsrVO vo);


}
