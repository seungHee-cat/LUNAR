package project.kr.review.entity;

import lombok.Data;

import java.util.Date;

@Data
public class ReviewVO {
    /* Search */
    private String schKeyword 	    = null;	// 검색 키워드
    private String schType   	    = null;	// 검색 타입
    private String orderType        = null; // 정렬 조건

    private String reviewId         = null; // 리뷰아이디(PK)
    private String reviewContent    = null; // 리뷰내용
    private Date wrtTime            = null; // 리뷰작성시간
    private Integer views           = 0;    // 조회수
    private Integer commentCnt        = 0;  // 댓글수
    private String usrId           = null;  // 유저아이디
    private String usrNm            = null; // 유저명

    /* Additional */
    private Integer movieId         = 0;    // 영화아이디
    private String postType         = null; // 리뷰타입(Insert/Update)
    private String title            = null; // 영화제목
    private Integer releaseYear     = 0;    // 개봉년도
    private String posterPath       = null;	// 포스터이미지경로
    private Integer limit           = 0;    // 리뷰개수제한
    private Integer rating          = 0;    // 영화별점평가
    private String commentTime      = null; // 코멘트 시간(TimeAgoUtil)
    private String usrImg           = null; // 유저 프로필 이미지
    private String encodedId        = null; // ID 암호화 (URL 노출 방지)
    private Integer ratingMonth     = 0;    // 평가 달(Month)
    private Integer ratingDay       = 0;    // 평가 일(Day)
}
