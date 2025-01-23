package project.kr.movie.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import project.kr.movie.entity.MovieVO;
import project.kr.movie.service.MovieService;

import java.util.List;

@Controller
public class MovieController {

    @Autowired
    private MessageSource messageSource;

    @Autowired
    MovieService movieService;

    /**
     * 영화 목록 조회
     */
    @RequestMapping("/movie/movieListAjax")
    public String movieListAjax(@ModelAttribute MovieVO vo, Model model) {
        List<MovieVO> boxOfficeList = movieService.getBoxOfficeList(vo);
        List<MovieVO> netflixList = movieService.getNetflixList(vo);
        List<MovieVO> watchaList = movieService.getWatchaList(vo);

        if(boxOfficeList != null && !boxOfficeList.isEmpty()) {
            model.addAttribute("boxOfficeList", boxOfficeList);
        }

        if(netflixList != null && !netflixList.isEmpty()) {
            model.addAttribute("netflixList", netflixList);
        }

        if(watchaList != null && !watchaList.isEmpty()) {
            model.addAttribute("watchaList", watchaList);
        }

        return "movieListAjax";
    }

    /**
     * 영화 상세 페이지 조회
     */
    @RequestMapping("/movie/movieDetail")
    public String movieDetail(@ModelAttribute MovieVO vo, Model model) {
        if (vo.getMovieId() != null) {
            MovieVO movie = movieService.getMovieDetail(vo);
            model.addAttribute("movie", movie);
        }
        return "movieDetail";
    }

    /**
     * 영화 검색 리스트 Ajax 조회
     */
    @RequestMapping(value="/movie/getMovieSchListAjax", method = RequestMethod.GET)
    @ResponseBody
    public List<MovieVO> getMovieSchListAjax(@ModelAttribute MovieVO vo, Model model) {
        List<MovieVO> movieList = movieService.getMovieSchListAjax(vo);
        return movieList;
    }

    /**
     * 영화 검색 페이지 조회
     */
    @RequestMapping("/movie/movieSearch")
    public String movieSearch(@ModelAttribute MovieVO vo, Model model) {
        List<MovieVO> boxOfficeList = movieService.getBoxOfficeList(vo);
        List<MovieVO> netflixList = movieService.getNetflixList(vo);
        List<MovieVO> watchaList = movieService.getWatchaList(vo);

        if(boxOfficeList != null && !boxOfficeList.isEmpty()) {
            model.addAttribute("boxOfficeList", boxOfficeList);
        }

        if(netflixList != null && !netflixList.isEmpty()) {
            model.addAttribute("netflixList", netflixList);
        }

        if(watchaList != null && !watchaList.isEmpty()) {
            model.addAttribute("watchaList", watchaList);
        }

        if(vo.getSchTitle() != null && !vo.getSchTitle().isEmpty()) {
            model.addAttribute("schKeyword", vo.getSchTitle());
        }
        return "movieSearchList";
    }

}


















