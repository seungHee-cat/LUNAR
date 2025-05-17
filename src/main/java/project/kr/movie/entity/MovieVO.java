package project.kr.movie.entity;

import lombok.Data;

@Data
public class MovieVO {
    /* Search */
    private String schTitle 	            = null;	// 제목검색

    /* Movie Group */
    private Integer groupNum                = 0;	// 영화그룹구분
    private Integer movieRank               = 0;    // 영화랭킹

    private Integer movieId                 = 0;	// 영화아이디 (PK)
    private String title                    = null;	// 영화제목
    private String backdropPath             = null;	// 배경이미지경로
    private String genreIds                 = null;	// 장르
    private String originalTitle            = null;	// 원제목
    private Integer releaseYear             = 0;	// 개봉년도
    private String runtime                  = null;	// 상영시간
    private String posterPath               = null;	// 포스터이미지경로
    private Double voteAverage              = 0.0;	// 평균별점
    private Integer avgPercentage           = 0;	// 평균퍼센티지
    private Integer voteCount               = 0;	// 별점평가수
    private String tagline                  = null;	// 영화한줄소개
    private String overview                 = null;	// 줄거리
    private Double popularity               = 0.0;	// 인기도
    private String productionCountries      = null;	// 제작국가

    /* Cast info */
    private String crewNm                   = null; // 크루 이름
    private String crewOrgNm                = null; // 크루 원어 이름
    private String profilePath              = null; // 크루 프로필 경로
    private String job                      = null; // 크루 직업

}
