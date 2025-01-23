package project.kr.rating.mapper;

import org.apache.ibatis.annotations.Mapper;
import project.kr.rating.entity.RatingVO;

@Mapper
public interface RatingMapper {

    /**
     * 별점 평가 INSERT
     */
    public int insertRating(RatingVO vo);

    /**
     * 별점 평가 UPDATE
     */
    public int updateRating(RatingVO vo);

    /**
     * 별점 평가 로드
     */
    public RatingVO getRating(RatingVO vo);

    /**
     * 별점 평가 DELETE
     */
    public int deleteRating(RatingVO vo);
}
