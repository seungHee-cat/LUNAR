package project.kr.review.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import project.kr.com.util.Base64Util;
import project.kr.com.util.Response;
import project.kr.com.util.TimeAgoUtil;
import project.kr.movie.entity.MovieVO;
import project.kr.review.entity.ReviewVO;
import project.kr.review.service.ReviewService;
import project.kr.sys.login.entity.LoginSession;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;
import java.util.Locale;

@Controller
public class ReviewController {

    @Autowired
    private MessageSource messageSource;

    @Autowired
    ReviewService reviewService;

    /**
     * 리뷰 모달
     */
    @RequestMapping("/review/reviewModal")
    public String reviewModal(@ModelAttribute("MovieVO") MovieVO vo, HttpServletRequest request, Model model) {
        ReviewVO review = new ReviewVO();
        LoginSession login = (LoginSession) request.getSession().getAttribute("loginSession");
        review.setUsrId(login.getLoginUsrId());
        review.setMovieId(vo.getMovieId());

        int reviewText = 0;
        ReviewVO curReview = reviewService.getReview(review);

        if(curReview != null){
            reviewText = curReview.getReviewContent().length();
        }
        model.addAttribute("review", curReview);
        model.addAttribute("reviewText", reviewText);
        return "reviewModal";
    }

    /**
     * 리뷰 작성/수정
     */
    @RequestMapping("/review/reviewPostAjax")
    @ResponseBody
    public Response reviewPostAjax(@ModelAttribute ReviewVO vo, HttpServletRequest request) {
        Response response = new Response();
        LoginSession login = (LoginSession) request.getSession().getAttribute("loginSession");
        vo.setUsrId(login.getLoginUsrId());

        int result = 0;
        // 리뷰 INSERT
        if (vo.getPostType().equals("I")) {
            result = reviewService.insertReview(vo);

            if(result > 0){
                response.setOk(true);
                response.setMessage(messageSource.getMessage("success.review.insert", null, Locale.getDefault()));
            } else {
                response.setOk(false);
                response.setMessage(messageSource.getMessage("fail.review.insert", null, Locale.getDefault()));
            }
        // 리뷰 UPDATE
        } else if(vo.getPostType().equals("U")){
            result = reviewService.updateReview(vo);

            if(result > 0){
                response.setOk(true);
                response.setMessage(messageSource.getMessage("success.review.update", null, Locale.getDefault()));
            } else {
                response.setOk(false);
                response.setMessage(messageSource.getMessage("fail.review.update", null, Locale.getDefault()));
            }
        }
        return response;
    }

    /**
     * 리뷰 삭제 모달
     */
    @RequestMapping("/review/deleteReviewModal")
    public String deleteReviewModal(@ModelAttribute("ReviewVO") ReviewVO vo) {
        return "deleteReviewModal";
    }

    /**
     * 리뷰 삭제
     */
    @RequestMapping("/review/deleteReviewAjax")
    @ResponseBody
    public Response deleteReviewAjax(@ModelAttribute ReviewVO vo, HttpServletRequest request) {
        Response response = new Response();

        int result = 0;
        // 리뷰 DELETE
        result = reviewService.deleteReview(vo);

        if(result > 0){
            response.setOk(true);
            response.setMessage(messageSource.getMessage("success.review.delete", null, Locale.getDefault()));
        } else {
            response.setOk(false);
            response.setMessage(messageSource.getMessage("fail.review.delete", null, Locale.getDefault()));
        }
        return response;
    }

    /**
     * 리뷰 조회
     */
    @RequestMapping("/review/myReviewAjax")
    public String myReviewAjax(@ModelAttribute ReviewVO vo, HttpServletRequest request, Model model){
        LoginSession login = (LoginSession) request.getSession().getAttribute("loginSession");
        // 로그인 정보가 없는 경우
        if (login == null) {
            model.addAttribute("review", new ReviewVO());
            return "myReviewAjax";
        }
        vo.setUsrId(login.getLoginUsrId());
        ReviewVO review = reviewService.getReview(vo);
        model.addAttribute("review", review);
        return "myReviewAjax";
    }

    /**
     * 모든 리뷰 리스트
     */
    @RequestMapping("/review/reviewListAjax")
    public String reviewListAjax(@ModelAttribute("MovieVO") MovieVO movie, @ModelAttribute ReviewVO vo, Model model){
        List<ReviewVO> reviewList = reviewService.getReviewList(vo);
        for(ReviewVO review : reviewList){
            review.setEncodedId(Base64Util.encodeBase64(review.getUsrId()));
        }

        // 5개 리뷰만 조회
        if(vo.getLimit() != 0){
            // 리뷰 개수
            int reviewSize = (int) (Math.ceil(reviewList.size() / 10.0) * 10);
            model.addAttribute("reviewSize", reviewSize);
            model.addAttribute("reviewList", reviewList);
            return "reviewListAjax";
        // [더보기]로 리뷰 전체 조회
        }else{
            model.addAttribute("reviewList", reviewList);
            return "allReviewList";
        }
    }

    /**
     * 리뷰 상세 조회
     */
    @RequestMapping("/review/reviewDetail")
    public String reviewDetail(@ModelAttribute ReviewVO vo, Model model){
        ReviewVO review = reviewService.getReviewDetail(vo);
        review.setEncodedId(Base64Util.encodeBase64(review.getUsrId()));

        // TimeAgoUtil 적용
        Date commentWrtTime = review.getWrtTime();
        if (commentWrtTime != null) {
            LocalDateTime commentWrtTimeAsLocalDateTime =
                    commentWrtTime.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
            String commentTime = TimeAgoUtil.timeAgo(commentWrtTimeAsLocalDateTime);
            review.setCommentTime(commentTime);
        }

        model.addAttribute("review", review);
        return "reviewDetail";
    }

    /**
     * 리뷰 검색 조회
     */
    @RequestMapping("/review/allReviewListAjax")
    public String allReviewListAjax(@ModelAttribute ReviewVO vo, Model model){
        List<ReviewVO> reviewList = reviewService.getReviewList(vo);

        model.addAttribute("reviewList", reviewList);
        return "allReviewListAjax";
    }
}
















