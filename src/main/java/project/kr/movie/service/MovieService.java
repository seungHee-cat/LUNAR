package project.kr.movie.service;

import lombok.extern.slf4j.Slf4j;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import project.kr.movie.entity.MovieVO;
import project.kr.movie.mapper.MovieMapper;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URI;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Slf4j
@Service
public class MovieService {

    @Autowired
    MovieMapper movieMapper;

    /**
     * 박스오피스 목록 조회
     */
    public List<MovieVO> getBoxOfficeList(MovieVO vo) {
        vo.setGroupNum(1); // 박스오피스 groupNum

        movieMapper.getMovieListCnt(vo);
        List<MovieVO> list = movieMapper.getMovieList(vo);
        return list;
    }

    /**
     * 넷플릭스 목록 조회
     */
    public List<MovieVO> getNetflixList(MovieVO vo) {
        vo.setGroupNum(2); // 넷플릭스 groupNum

        movieMapper.getMovieListCnt(vo);
        List<MovieVO> list = movieMapper.getMovieList(vo);
        return list;
    }

    /**
     * 왓챠 목록 조회
     */
    public List<MovieVO> getWatchaList(MovieVO vo) {
        vo.setGroupNum(3); // 왓챠 groupNum

        movieMapper.getMovieListCnt(vo);
        List<MovieVO> list = movieMapper.getMovieList(vo);
        return list;
    }

    /**
     * 디즈니 플러스 목록 조회
     */
    public List<MovieVO> getDisneyList(MovieVO vo) {
        vo.setGroupNum(4); // 디즈니플러스 groupNum

        movieMapper.getMovieListCnt(vo);
        List<MovieVO> list = movieMapper.getMovieList(vo);
        return list;
    }

    /**
     * 웨이브 목록 조회
     */
    public List<MovieVO> getWavveList(MovieVO vo) {
        vo.setGroupNum(5); // 웨이브 groupNum

        movieMapper.getMovieListCnt(vo);
        List<MovieVO> list = movieMapper.getMovieList(vo);
        return list;
    }

    /**
     * 영화 상세 페이지 조회
     */
    public MovieVO getMovieDetail(MovieVO vo) {
        MovieVO movie = movieMapper.getMovieDetail(vo);
        return movie;
    }

    /**
     * 영화 검색 리스트 Ajax 조회
     */
    public List<MovieVO> getMovieSchListAjax(MovieVO vo) {
        List<MovieVO> movieList = movieMapper.getMovieSchListAjax(vo);
        return movieList;
    }

    /**
     *  스케줄러를 적용하여 매일 오후 15시마다 영화 DB 업데이트
     */
    @Scheduled(cron = "0 59 13 * * *")
    public void updateMovieList(){
        /* MOVIE SETTING START */
        final String ApiKey = "729201bdf1f62b5e99c9816a70e5d445";
        List<String> apiURL_list = new ArrayList<>();
        List<Integer> movieIdLists = new ArrayList<>();
        List<String> detailLists = new ArrayList<>();

        final Integer NetflixApiKey = 8;
        final Integer WatchaApiKey = 97;
        final Integer DisneyPlusApiKey = 337;
        final Integer WavveApiKey = 356;

        // Now Playing
        apiURL_list.add("https://api.themoviedb.org/3/movie/now_playing?api_key="
                + ApiKey +"&language=ko-KR&page=1&region=KR");

        // Netflix
        apiURL_list.add("https://api.themoviedb.org/3/discover/movie?api_key="
                + ApiKey +"&language=ko-KR&page=1&sort_by=popularity.desc&watch_region=KR&with_watch_providers="+NetflixApiKey);

        // Watcha
        apiURL_list.add("https://api.themoviedb.org/3/discover/movie?api_key="
                + ApiKey +"&language=ko-KR&page=1&sort_by=popularity.desc&watch_region=KR&with_watch_providers="+WatchaApiKey);

        // Disney Plus
        apiURL_list.add("https://api.themoviedb.org/3/discover/movie?api_key="
                + ApiKey +"&language=ko-KR&page=1&sort_by=popularity.desc&watch_region=KR&with_watch_providers="+DisneyPlusApiKey);

        // Wavve
        apiURL_list.add("https://api.themoviedb.org/3/discover/movie?api_key="
                + ApiKey +"&language=ko-KR&page=1&sort_by=popularity.desc&watch_region=KR&with_watch_providers="+WavveApiKey);

        StringBuilder detailStringBuilder = new StringBuilder();

        for(String apiURL : apiURL_list) {
            try {
                URI uri = new URI(apiURL);
                URL url = uri.toURL();
                BufferedReader bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
                String result = bf.readLine();
                movieIdLists.clear();

                JSONObject jsonObject = new JSONObject(result);
                JSONArray list = jsonObject.getJSONArray("results");

                for(int j=0; j < list.length(); j++) {
                    JSONObject contents = list.getJSONObject(j);
                    int movieId = contents.getInt("id");
                    movieIdLists.add(movieId);
                    detailStringBuilder.append("https://api.themoviedb.org/3/movie/").append(movieIdLists.get(j))
                            .append("?api_key=").append(ApiKey).append("&language=ko-KR").append("\n");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        detailLists.addAll(Arrays.asList(detailStringBuilder.toString().split("\n")));

        // movie_group delete
        movieMapper.deleteAllMovieGroups();
        getDetailMovie(detailLists);

        /* MOVIE SETTING END */
    }

    /**
     * 영화 상세 정보 가져오기
     */
    public void getDetailMovie(List<String> detailLists) {
        final String API_KEY = "729201bdf1f62b5e99c9816a70e5d445";
        final String prefix_url = "https://image.tmdb.org/t/p/original";
        List<Integer> providerGroupNums = Arrays.asList(1, 2, 3, 4, 5); // OTT별 groupNum
        JSONObject detailObject = null;
        int index = 0;

        for(String detailURLString : detailLists) {
            try {
                MovieVO movie = new MovieVO();
                URI detailURI = new URI(detailURLString);
                URL detailURL = detailURI.toURL();
                BufferedReader br = new BufferedReader(new InputStreamReader(detailURL.openStream(), "UTF-8"));
                String rs = br.readLine();

                detailObject = new JSONObject(rs);
                movie.setMovieId(detailObject.getInt("id"));
                movie.setTitle(detailObject.getString("title"));
                movie.setBackdropPath(prefix_url+detailObject.getString("backdrop_path"));
                movie.setOriginalTitle(detailObject.getString("original_title"));
                movie.setReleaseYear(Integer.parseInt(detailObject.getString("release_date").substring(0, 4)));
                movie.setPosterPath(prefix_url+detailObject.getString("poster_path"));
                movie.setVoteCount(detailObject.getInt("vote_count"));
                movie.setTagline(detailObject.getString("tagline"));
                movie.setOverview(detailObject.getString("overview"));
                movie.setPopularity(detailObject.getDouble("popularity"));

                int groupIndex = index / 20;
                int groupNum = providerGroupNums.get(groupIndex);
                int movieRank = (index % 20) + 1;

                int runtime = detailObject.getInt("runtime");
                int runtime_hour = runtime / 60;
                int runtime_minute = runtime % 60;

                if(runtime_hour == 0) {
                    movie.setRuntime(runtime+"분");
                }else {
                    movie.setRuntime(runtime_hour+"시간 "+runtime_minute+"분");
                }

                double voteAvg = detailObject.getDouble("vote_average") / 2;
                movie.setVoteAverage(Math.floor(voteAvg * 10) / 10);

                // 나라 정보
                JSONArray country_list = (JSONArray) detailObject.get("production_countries");
                String iso_3166_1 = "";
                for(int i=0; i<country_list.length(); i++) {
                    JSONObject countryObject = country_list.getJSONObject(i);
                    iso_3166_1 += countryObject.get("iso_3166_1");
                    if(i < country_list.length() - 1) {
                        iso_3166_1 += " · ";
                    }
                }
                List<String> isoList = getIsoList(API_KEY);
                List<String> nativeNameList = getNativeNameList(API_KEY);
                for(int i=0; i<isoList.size(); i++) {
                    if(iso_3166_1.contains(isoList.
                            get(i))) {
                        iso_3166_1 = iso_3166_1.replace(isoList.get(i), nativeNameList.get(i));
                    }
                }
                movie.setProductionCountries(iso_3166_1);

                // 장르 정보
                JSONArray genre_list = (JSONArray) detailObject.get("genres");
                String genre = "";
                for(int i=0; i<genre_list.length(); i++) {
                    JSONObject genreObject = genre_list.getJSONObject(i);
                    genre += genreObject.getString("name");
                    if(i < genre_list.length() - 1) {
                        genre += " · ";
                    }
                }
                movie.setGenreIds(genre);

                // movie insert
                movieMapper.insertMovie(movie);

                // movie_group insert
                movieMapper.insertMovieGroup(movie.getMovieId(), groupNum, movieRank);
                index++;

            }catch(Exception e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 영화 나라 정보 조회
     */
    public static List<String> getIsoList(String API_KEY){
        String countryURL = "https://api.themoviedb.org/3/configuration/countries?api_key="+API_KEY+"&language=ko-KR";
        List<String> isoList = new ArrayList<String>();

        try {
            URI uri = new URI(countryURL);
            URL url = uri.toURL();
            BufferedReader bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
            String result = bf.readLine();
            JSONArray jsonArray = new JSONArray(result);

            for(int i=0; i<jsonArray.length(); i++) {
                JSONObject jsonObejct = jsonArray.getJSONObject(i);
                try {
                    String iso_3166_1 = jsonObejct.getString("iso_3166_1");
                    isoList.add(iso_3166_1);

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

        }catch(Exception e) {
            e.printStackTrace();
        }
        return isoList;
    }

    /**
     * 영화 제작 국가 조회
     */
    public static List<String> getNativeNameList(String API_KEY){
        String countryURL = "https://api.themoviedb.org/3/configuration/countries?api_key="+API_KEY+"&language=ko-KR";
        List<String> nativeNameList = new ArrayList<String>();

        try {
            URI uri = new URI(countryURL);
            URL url = uri.toURL();
            BufferedReader bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
            String result = bf.readLine();
            JSONArray jsonArray = new JSONArray(result);

            for(int i=0; i<jsonArray.length(); i++) {
                JSONObject jsonObejct = jsonArray.getJSONObject(i);
                try {
                    String native_name = jsonObejct.getString("native_name");
                    nativeNameList.add(native_name);

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

        }catch(Exception e) {
            e.printStackTrace();
        }
        return nativeNameList;
    }
}
