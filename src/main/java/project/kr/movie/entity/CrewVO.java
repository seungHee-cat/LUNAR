package project.kr.movie.entity;

import lombok.Data;

@Data
public class CrewVO {
    private Integer crewId = 0; // 크루 아이디
    private String crewNm = null; // 크루 한글 이름
    private String crewOrgNm = null; // 크루 원어 이름
    private String profilePath = null; // 크루 이미지 경로
    private String job = null; // 크루 직업
    private Integer movieId = 0; // 영화 아이디 (FK)
}
