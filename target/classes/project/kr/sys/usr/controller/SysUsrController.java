package project.kr.sys.usr.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import project.kr.com.util.Base64Util;
import project.kr.com.util.Response;
import project.kr.review.entity.ReviewVO;
import project.kr.sys.login.entity.LoginSession;
import project.kr.sys.usr.entity.SysUsrVO;
import project.kr.sys.usr.service.SysUsrService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Locale;

@Slf4j
@Controller
public class SysUsrController {

    @Autowired
    SysUsrService sysUsrService;

    @Autowired
    private MessageSource messageSource;

    /**
     * 유저 프로필 사진, DROPDOWN 로드
     */
    @RequestMapping("/sys/usr/dropdownAjax")
    public String dropdownAjax(HttpServletRequest request, Model model) {
        LoginSession login = (LoginSession) request.getSession().getAttribute("loginSession");
        if(login != null){
            SysUsrVO usr = sysUsrService.getSysUsrImg(login);
            model.addAttribute("usr", usr);
        }

        return "dropdownAjax";
    }

    /**
     * 프로필 설정 모달
     */
    @RequestMapping("/sys/usr/settingModal")
    public String sysLoginModal(@ModelAttribute SysUsrVO vo, HttpServletRequest request, Model model) {
        LoginSession login = (LoginSession) request.getSession().getAttribute("loginSession");

        SysUsrVO usrDetail = sysUsrService.getSysUsrDetail(login);
        model.addAttribute("usrDetail", usrDetail);
        return "settingModal";
    }

    /**
     * 프로필 조회
     */
    @RequestMapping("/sys/usr/usrProfileAjax")
    public String usrProfileAjax(@ModelAttribute SysUsrVO vo, HttpServletRequest request, Model model) {
        LoginSession login = (LoginSession) request.getSession().getAttribute("loginSession");

        SysUsrVO usr = sysUsrService.getSysUsrDetail(login);
        model.addAttribute("usr", usr);
        return "usrProfileAjax";
    }

    /**
     * 프로필 수정
     */
    @ResponseBody
    @RequestMapping("/sys/usr/updateUsrProfileAjax")
    public Response updateUsrProfileAjax(@ModelAttribute SysUsrVO vo, HttpServletRequest request) {
        Response response = new Response();
        LoginSession login = (LoginSession) request.getSession().getAttribute("loginSession");
        vo.setUsrId(login.getLoginUsrId());
        int result = sysUsrService.updateUsrProfile(vo);

        if(result > 0){
            response.setOk(true);
            response.setMessage(messageSource.getMessage("success.profile.update", null, Locale.KOREAN));
        } else if(result == -2){
            response.setOk(false);
            response.setMessage(messageSource.getMessage("fail.profile.upload", null, Locale.KOREAN));
        }
        else {
            response.setOk(false);
            response.setMessage(messageSource.getMessage("fail.profile.update", null, Locale.KOREAN));
        }
        return response;
    }

    /**
     * 프로필 이미지 삭제 모달
     */
    @RequestMapping("/sys/usr/deleteImgModal")
    public String deleteImgModal(@ModelAttribute ("SysUsrVO") SysUsrVO vo, HttpServletRequest request) {
        LoginSession login = (LoginSession) request.getSession().getAttribute("loginSession");
        vo.setUsrId(login.getLoginUsrId());
        return "deleteImgModal";
    }

    /**
     * 프로필 이미지 삭제
     */
    @ResponseBody
    @RequestMapping("/sys/usr/deleteImgAjax")
    public Response deleteImgAjax(@ModelAttribute SysUsrVO vo, HttpServletRequest request) {
        Response response = new Response();
        LoginSession login = (LoginSession) request.getSession().getAttribute("loginSession");
        vo.setUsrId(login.getLoginUsrId());
        int result = sysUsrService.deleteUsrImg(vo);

        if(result > 0){
            response.setOk(true);
            response.setMessage(messageSource.getMessage("success.img.delete", null, Locale.KOREAN));
        } else {
            response.setOk(false);
            response.setMessage(messageSource.getMessage("fail.img.delete", null, Locale.KOREAN));
        }
        return response;
    }

    /**
     * 회원탈퇴 모달
     */
    @RequestMapping("/sys/usr/withdrawModal")
    public String withdrawModal(@ModelAttribute SysUsrVO vo, HttpServletRequest request, Model model) {
        LoginSession login = (LoginSession) request.getSession().getAttribute("loginSession");
        model.addAttribute("login", login);
        return "withdrawModal";
    }

    /**
     * 회원탈퇴 비밀번호 확인
     */
    @RequestMapping("/sys/usr/checkPassword")
    @ResponseBody
    public String checkPassword(@RequestBody String usrPw, HttpServletRequest request) {
        SysUsrVO vo = new SysUsrVO();
        LoginSession login = (LoginSession) request.getSession().getAttribute("loginSession");
        vo.setUsrId(login.getLoginUsrId());
        vo.setUsrPw(usrPw);

        // 현재 로그인한 유저의 비밀번호 확인 로직
        boolean result = sysUsrService.checkPassword(vo);
        if(result) return "password match";
        else return "error";
    }

    /**
     * 회원탈퇴 진행
     */
    @ResponseBody
    @RequestMapping("/sys/usr/withdrawAccount")
    public Response withdrawAccount(@ModelAttribute SysUsrVO vo, HttpSession session, HttpServletRequest request){
        Response response = new Response();
        LoginSession login = (LoginSession) request.getSession().getAttribute("loginSession");
        vo.setUsrId(login.getLoginUsrId());
        int result = sysUsrService.withdrawAccount(vo);

        if(result > 0){
            response.setOk(true);
            session.invalidate(); // 세션 무효화
            response.setMessage(messageSource.getMessage("success.usr.delete", null, Locale.KOREAN));
        } else {
            response.setOk(false);
            response.setMessage(messageSource.getMessage("fail.usr.delete", null, Locale.KOREAN));
        }

        return response;
    }

    /**
     * 유저 페이지 정보
     */
    @RequestMapping("/sys/usr/usrContents")
    public String usrContents(@ModelAttribute SysUsrVO vo, Model model) {
        String decodedId = Base64Util.decodeBase64(vo.getEncodedId());
        vo.setUsrId(decodedId);
        SysUsrVO usr = sysUsrService.getUsrDetail(vo);

        model.addAttribute("usr", usr);
        return "usrContents";
    }

    /**
     * 유저 통계 조회
     */
    @RequestMapping("/sys/usr/usrStatisticsAjax")
    public String usrStatisticsAjax(@ModelAttribute SysUsrVO vo, Model model) {
        // 리뷰 수 통계
        Integer reviewCnt = sysUsrService.getReviewStatCnt(vo);
        // 코멘트 수 통계
        Integer commentCnt = sysUsrService.getCommentStatCnt(vo);
        // 평균 별점 통계
        Double ratingAvg = sysUsrService.getRatingStatAvg(vo);
        // 유저 정보
        SysUsrVO usr = sysUsrService.getUsrDetail(vo);

        String encodedId = Base64Util.encodeBase64(usr.getUsrId());
        usr.setEncodedId(encodedId);

        model.addAttribute("reviewCnt", reviewCnt);
        model.addAttribute("commentCnt", commentCnt);
        model.addAttribute("ratingAvg", ratingAvg);
        model.addAttribute("usr", usr);
        return "usrStatisticsAjax";
    }

    /**
     * 유저 캘린더 조회
     */
    @RequestMapping("/sys/usr/usrCalenderAjax")
    public String usrCalenderAjax(@ModelAttribute SysUsrVO vo, Model model) throws JsonProcessingException {
        // 유저 평점 데이터 조회
        List<ReviewVO> ratingList = sysUsrService.getRatingByUser(vo);

        for(int i=0; i<ratingList.size(); i++){
            String encodedId = Base64Util.encodeBase64(ratingList.get(i).getUsrId());
            ratingList.get(i).setEncodedId(encodedId);
        }
        ObjectMapper objectMapper = new ObjectMapper();
        String ratingListJson = objectMapper.writeValueAsString(ratingList);

        model.addAttribute("ratingList", ratingListJson);
        return "usrCalenderAjax";
    }

    /**
     * 유저 전체 평점 조회
     */
    @RequestMapping("/sys/usr/usrRatingList")
    public String usrRatingList(@ModelAttribute SysUsrVO vo, Model model) {
        String decodedId = Base64Util.decodeBase64(vo.getEncodedId());
        vo.setUsrId(decodedId);

        List<ReviewVO> ratingList = sysUsrService.getRatingByUser(vo);

        // 클릭한 영화에 대한 평점 조회
        ReviewVO rating = sysUsrService.getRatingOne(vo);

        model.addAttribute("ratingList", ratingList);
        model.addAttribute("rating", rating);
        return "usrRatingList";
    }

    /**
     * 유저 리뷰 전체 조회
     */
    @RequestMapping("/sys/usr/usrReviewList")
    public String usrReviewList(@ModelAttribute SysUsrVO vo, Model model) {
        String decodedId = Base64Util.decodeBase64(vo.getEncodedId());
        vo.setUsrId(decodedId);
        SysUsrVO usr = sysUsrService.getUsrDetail(vo);

        model.addAttribute("usr", usr);
        return "usrReviewList";
    }

    /**
     * 유저 리뷰 전체 조회 Ajax
     */
    @RequestMapping("/sys/usr/usrReviewListAjax")
    public String usrReviewListAjax(@ModelAttribute SysUsrVO vo, Model model) {
        List<ReviewVO> usrReviewList = sysUsrService.getUsrReviewList(vo);

        model.addAttribute("usrReviewList", usrReviewList);
        return "usrReviewListAjax";
    }

}
