package project.kr.movie.entity;

import lombok.Data;

@Data
public class CastVO {
    private Integer castId                 = 0;       // 출연진 아이디 (PK)
    private String castNm                  = null;    // 출연진 한글 이름
    private String castOrgNm               = null;    // 출연진 원어 이름
    private String profilePath             = null;    // 출연진 이미지 경로
    private String characterNm             = null;    // 극중 캐릭터 이름
    private Integer movieId                = 0;       // 영화 아이디 (FK)
    private Integer castOrder              = 0;       // 영화 내 순서
}
