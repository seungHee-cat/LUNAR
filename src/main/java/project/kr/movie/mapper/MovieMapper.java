package project.kr.movie.mapper;

import org.apache.ibatis.annotations.Mapper;
import project.kr.movie.entity.CastVO;
import project.kr.movie.entity.CrewVO;
import project.kr.movie.entity.MovieVO;
import java.util.List;

@Mapper
public interface MovieMapper {

    /**
     * 영화 목록 조회
     */
    List<MovieVO> getMovieList(MovieVO vo);

    /**
     * 영화 목록 insert
     */
    int insertMovie(MovieVO vo);

    /**
     * 영화 그룹 insert
     */
    int insertMovieGroup(int movieId, int groupNum, int movieRank);

    /**
     * 영화 그룹 전체 delete
     */
    int deleteAllMovieGroups();

    /**
     * 영화 목록 개수 조회
     */
    void getMovieListCnt(MovieVO vo);

    /**
     * 영화 상세 페이지 조회
     */
    MovieVO getMovieDetail(MovieVO vo);

    /**
     * 영화 검색리스트 Ajax 조회
     */
    List<MovieVO> getMovieSchListAjax(MovieVO vo);

    /**
     * 출연진 insert
     */
    int insertCast(CastVO credit);

    /**
     * 영화 출연진 정보
     */
    List<CastVO> getMovieCast(MovieVO vo);

    /**
     * 크루 insert
     */
    int insertCrew(CrewVO crew);
}
