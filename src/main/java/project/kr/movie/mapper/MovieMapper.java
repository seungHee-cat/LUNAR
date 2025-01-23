package project.kr.movie.mapper;

import org.apache.ibatis.annotations.Mapper;
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
}
