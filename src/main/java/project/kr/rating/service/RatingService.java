package project.kr.rating.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import project.kr.rating.entity.RatingVO;
import project.kr.rating.mapper.RatingMapper;

import java.util.UUID;

@Service
public class RatingService {

    @Autowired
    private RatingMapper ratingMapper;

    /**
     * 영화 평가 INSERT
     */
    public int insertRating(RatingVO vo) {
        int result = 1;
        try{
            vo.setRatingId(UUID.randomUUID().toString()); // RaitngId PK 지정
            ratingMapper.insertRating(vo);
        } catch (Exception e) {
            e.printStackTrace();
            result = -1;
        }
        return result;
    }

    /**
     * 영화 평가 UPDATE
     */
    public int updateRating(RatingVO vo) {
        int result = 1;
        try{
            ratingMapper.updateRating(vo);
        } catch (Exception e) {
            e.printStackTrace();
            result = -1;
        }
        return result;
    }

    /**
     * 별점 평가 로드
     */
    public RatingVO getRating(RatingVO vo) {
        return ratingMapper.getRating(vo);
    }

    /**
     * 영화 평가 DELETE
     */
    public int deleteRating(RatingVO vo) {
        int result = 1;
        try{
            ratingMapper.deleteRating(vo);
        } catch (Exception e) {
            e.printStackTrace();
            result = -1;
        }
        return result;
    }
}
