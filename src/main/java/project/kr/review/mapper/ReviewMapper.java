package project.kr.review.mapper;

import org.apache.ibatis.annotations.Mapper;
import project.kr.review.entity.ReviewVO;

import java.util.List;

@Mapper
public interface ReviewMapper {

    /**
     * 리뷰 작성
     */
    int insertReview(ReviewVO vo);

    /**
     * 리뷰 조회
     */
    ReviewVO getReview(ReviewVO vo);

    /**
     * 리뷰 수정
     */
    int updateReview(ReviewVO vo);

    /**
     * 모든 리뷰 리스트
     */
    List<ReviewVO> getReviewList(ReviewVO vo);

    /**
     * 리뷰 상세 조회
     */
    ReviewVO getReviewDetail(ReviewVO vo);

    /**
     * 리뷰 클릭 시 조회수 증가
     */
    int updateReviewViews(ReviewVO vo);

    /**
     * 리뷰 삭제
     */
    int deleteReview(ReviewVO vo);

    /**
     * 삭제 리뷰에 관련된 코멘트 삭제
     */
    int deleteComment(ReviewVO vo);
}
