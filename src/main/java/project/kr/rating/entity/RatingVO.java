package project.kr.rating.entity;

import lombok.Data;

import java.util.Date;

@Data
public class RatingVO {
    private String ratingId            = null;	// 평가ID (PK)
    private Integer Rating             = null;	// 영화평가점수
    private String usrId               = null;	// 유저아이디
    private Integer movieId            = null;	// 영화아이디 (FK)
    private Date wrtTime                = null; // 평점작성시간

    private String postType         = null;     // 평가 타입(Insert/Update)
    private Double avgRating        = 0.0;      // 평균 별점 통계
}

