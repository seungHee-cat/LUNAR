package project.kr.review.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import project.kr.review.entity.ReviewVO;
import project.kr.review.mapper.ReviewMapper;

import java.util.List;
import java.util.UUID;

@Service
public class ReviewService {

    @Autowired
    ReviewMapper reviewMapper;

    /*
    * 리뷰 작성
     */
    public int insertReview(ReviewVO vo){
        int result = 1;
        try{
            vo.setReviewId(UUID.randomUUID().toString());
            reviewMapper.insertReview(vo);
        } catch (Exception e) {
            e.printStackTrace();
            result = -1;
        }
        return result;
    }

    /*
     * 리뷰 조회
     */
    public ReviewVO getReview(ReviewVO vo) {
        return reviewMapper.getReview(vo);
    }

    /*
     * 리뷰 수정
     */
    public int updateReview(ReviewVO vo) {
        int result = 1;
        try{
            reviewMapper.updateReview(vo);
        } catch (Exception e) {
            e.printStackTrace();
            result = -1;
        }
        return result;
    }

    /**
     * 모든 리뷰 리스트
     */
    public List<ReviewVO> getReviewList(ReviewVO vo) {
        return reviewMapper.getReviewList(vo);
    }

    /**
     * 리뷰 상세 조회
     */
    public ReviewVO getReviewDetail(ReviewVO vo) {
        int result = 1;
        try{
            // 리뷰 클릭 시 조회수 증가
            reviewMapper.updateReviewViews(vo);
        } catch (Exception e) {
            e.printStackTrace();
            result = -1;
        }
        return reviewMapper.getReviewDetail(vo);
    }

    /**
     * 리뷰 삭제
     */
    public int deleteReview(ReviewVO vo) {
        int result = 1;
        try{
            reviewMapper.deleteReview(vo);
            reviewMapper.deleteComment(vo); // 관련 코멘트 삭제
        } catch (Exception e) {
            e.printStackTrace();
            result = -1;
        }
        return result;
    }
}
