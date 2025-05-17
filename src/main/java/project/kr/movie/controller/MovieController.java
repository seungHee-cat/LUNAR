package project.kr.movie.controller;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import project.kr.movie.entity.CastVO;
import project.kr.movie.entity.MovieVO;
import project.kr.movie.service.MovieService;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
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
    public String movieListAjax(@ModelAttribute MovieVO vo, Model model) throws URISyntaxException {
        List<MovieVO> boxOfficeList = movieService.getBoxOfficeList(vo);
        List<MovieVO> netflixList = movieService.getNetflixList(vo);
        List<MovieVO> watchaList = movieService.getWatchaList(vo);
        List<MovieVO> disneyList = movieService.getDisneyList(vo);
        List<MovieVO> wavveList = movieService.getWavveList(vo);

        // 메인 배너 영화
        model.addAttribute("mainMovie", boxOfficeList.get(0));

        if(boxOfficeList != null && !boxOfficeList.isEmpty()) {
            model.addAttribute("boxOfficeList", boxOfficeList);
        }

        if(netflixList != null && !netflixList.isEmpty()) {
            model.addAttribute("netflixList", netflixList);
        }

        if(watchaList != null && !watchaList.isEmpty()) {
            model.addAttribute("watchaList", watchaList);
        }

        if(disneyList != null && !disneyList.isEmpty()) {
            model.addAttribute("disneyList", disneyList);
        }

        if(wavveList != null && !wavveList.isEmpty()) {
            model.addAttribute("wavveList", wavveList);
        }

        final String ApiKey = "729201bdf1f62b5e99c9816a70e5d445";

        // Now Playing
        String apiURL = "https://api.themoviedb.org/3/movie/now_playing?api_key="
                + ApiKey +"&language=ko-KR&page=1&region=KR";

        String maxDate = null;
        String minDate = null;

        try {
            URI uri = new URI(apiURL);
            URL url = uri.toURL();
            BufferedReader bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
            String result = bf.readLine();

            JSONObject jsonObject = new JSONObject(result);
            JSONObject dates = jsonObject.getJSONObject("dates");
            maxDate = dates.getString("maximum");
            minDate = dates.getString("minimum");

        } catch (Exception e) {
            e.printStackTrace();
        }
        model.addAttribute("maxDate", maxDate);
        model.addAttribute("minDate", minDate);

        return "movieListAjax";
    }

    /**
     * 영화 상세 페이지 조회
     */
    @RequestMapping("/movie/movieDetail")
    public String movieDetail(@ModelAttribute MovieVO vo, Model model) {
        if (vo.getMovieId() != null) {
            MovieVO movie = movieService.getMovieDetail(vo);
            List<CastVO> castList = movieService.getMovieCast(vo);
            model.addAttribute("movie", movie);
            model.addAttribute("castList", castList);
        }
        return "movieDetail";
    }

    /**
     * 영화 검색 리스트 Ajax 조회
     */
    @RequestMapping(value="/movie/getMovieSchListAjax", method = RequestMethod.GET)
    @ResponseBody
    public List<MovieVO> getMovieSchListAjax(@ModelAttribute MovieVO vo) {
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
        List<MovieVO> disneyList = movieService.getDisneyList(vo);
        List<MovieVO> wavveList = movieService.getWavveList(vo);

        if(boxOfficeList != null && !boxOfficeList.isEmpty()) {
            model.addAttribute("boxOfficeList", boxOfficeList);
        }

        if(netflixList != null && !netflixList.isEmpty()) {
            model.addAttribute("netflixList", netflixList);
        }

        if(watchaList != null && !watchaList.isEmpty()) {
            model.addAttribute("watchaList", watchaList);
        }

        if(disneyList != null && !disneyList.isEmpty()) {
            model.addAttribute("disneyList", disneyList);
        }

        if(wavveList != null && !wavveList.isEmpty()) {
            model.addAttribute("wavveList", wavveList);
        }

        if(vo.getSchTitle() != null && !vo.getSchTitle().isEmpty()) {
            model.addAttribute("schKeyword", vo.getSchTitle());
        }
        return "movieSearchList";
    }

}


















