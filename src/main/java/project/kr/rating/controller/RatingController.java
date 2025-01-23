package project.kr.rating.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import project.kr.com.util.Response;
import project.kr.movie.entity.MovieVO;
import project.kr.rating.entity.RatingVO;
import project.kr.rating.service.RatingService;
import project.kr.sys.login.entity.LoginSession;

import javax.servlet.http.HttpServletRequest;
import java.util.Locale;

@Controller
public class RatingController {

    @Autowired
    private MessageSource messageSource;

    @Autowired
    private RatingService ratingService;

    /**
     * 별점 평가 로드
     */
    @RequestMapping("/rating/myRatingAjax")
    public String myRatingAjax(@ModelAttribute("MovieVO") MovieVO movie, @ModelAttribute("RatingVO") RatingVO vo, HttpServletRequest request, Model model) {
        LoginSession login = (LoginSession) request.getSession().getAttribute("loginSession");

        if(login != null){
            vo.setUsrId(login.getLoginUsrId());
            RatingVO rating = ratingService.getRating(vo);
            model.addAttribute("rating", rating);
        }
        return "myRatingAjax";
    }

    /**
     * 별점 평가 선택
     */
    @RequestMapping("/rating/starRating")
    @ResponseBody
    public Response starRating(@ModelAttribute RatingVO vo, HttpServletRequest request) {
        Response response = new Response();
        LoginSession login = (LoginSession) request.getSession().getAttribute("loginSession");
        vo.setUsrId(login.getLoginUsrId());

        int result = 0;
        // 별점 평가 INSERT
        if (vo.getPostType().equals("I")) {
            result = ratingService.insertRating(vo);

            if(result > 0){
                response.setOk(true);
                response.setMessage(messageSource.getMessage("success.rating.insert", null, Locale.KOREAN));
            } else {
                response.setOk(false);
                response.setMessage(messageSource.getMessage("fail.rating.insert", null, Locale.KOREAN));
            }
        // 별점 평가 UPDATE
        } else if(vo.getPostType().equals("U")){
            result = ratingService.updateRating(vo);

            if(result > 0){
                response.setOk(true);
                response.setMessage(messageSource.getMessage("success.rating.update", null, Locale.KOREAN));
            } else {
                response.setOk(false);
                response.setMessage(messageSource.getMessage("fail.rating.update", null, Locale.KOREAN));
            }
        }
        return response;
    }

    /**
     * 별점 평가 취소
     */
    @RequestMapping("/rating/deleteStarRating")
    @ResponseBody
    public Response deleteStarRating(@ModelAttribute RatingVO vo, HttpServletRequest request) {
        Response response = new Response();
        LoginSession login = (LoginSession) request.getSession().getAttribute("loginSession");
        vo.setUsrId(login.getLoginUsrId());

        int result = 0;
        // 별점 평가 DELETE
        result = ratingService.deleteRating(vo);

        if(result > 0){
            response.setOk(true);
            response.setMessage(messageSource.getMessage("success.rating.delete", null, Locale.KOREAN));
        } else {
            response.setOk(false);
            response.setMessage(messageSource.getMessage("fail.rating.delete", null, Locale.KOREAN));
        }
        return response;
    }
}
