package project.kr.comment.controller;

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
import project.kr.comment.entity.CommentVO;
import project.kr.comment.service.CommentService;
import project.kr.review.entity.ReviewVO;
import project.kr.sys.login.entity.LoginSession;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;
import java.util.Locale;

@Controller
public class CommentController {

    @Autowired
    private MessageSource messageSource;

    @Autowired
    private CommentService commentService;

    /**
     * 코멘트 모달
     */
    @RequestMapping("/comment/commentModal")
    public String commentModal(@ModelAttribute("ReviewVO") ReviewVO review, @ModelAttribute CommentVO vo, HttpServletRequest request, Model model) {
        LoginSession login = (LoginSession) request.getSession().getAttribute("loginSession");
        vo.setUsrId(login.getLoginUsrId());

        int commentText = 0;
        CommentVO comment = commentService.getComment(vo);

        if(comment != null){
            commentText = comment.getCommentContent().length();
        }
        model.addAttribute("comment", comment);
        model.addAttribute("commentText", commentText);
        return "commentModal";
    }

    /**
     * 코멘트 작성/수정
     */
    @RequestMapping("/comment/commentPostAjax")
    @ResponseBody
    public Response commentPostAjax(@ModelAttribute CommentVO vo, HttpServletRequest request) {
        Response response = new Response();
        LoginSession login = (LoginSession) request.getSession().getAttribute("loginSession");
        vo.setUsrId(login.getLoginUsrId());

        int result = 0;
        // 코멘트 INSERT
        if (vo.getPostType().equals("I")) {
            result = commentService.insertComment(vo);

            if(result > 0){
                response.setOk(true);
                response.setMessage(messageSource.getMessage("success.comment.insert", null, Locale.getDefault()));
            } else {
                response.setOk(false);
                response.setMessage(messageSource.getMessage("fail.comment.insert", null, Locale.getDefault()));
            }
            // 코멘트 UPDATE
        } else if(vo.getPostType().equals("U")){
            result = commentService.updateComment(vo);

            if(result > 0){
                response.setOk(true);
                response.setMessage(messageSource.getMessage("success.comment.update", null, Locale.getDefault()));
            } else {
                response.setOk(false);
                response.setMessage(messageSource.getMessage("fail.comment.update", null, Locale.getDefault()));
            }
        }
        return response;
    }

    /**
     * 코멘트 리스트 조회
     */
    @RequestMapping("/comment/commentListAjax")
    public String commentListAjax(@ModelAttribute CommentVO vo,  Model model) {
        List<CommentVO> commentList = commentService.getCommentList(vo);
        for(CommentVO comment : commentList){
            comment.setEncodedId(Base64Util.encodeBase64(comment.getUsrId()));
        }

        if(commentList != null && !commentList.isEmpty()) {
            // TimeAgoUtil 적용
            for (CommentVO comment : commentList) {
                Date commentWrtTime = comment.getWrtTime();
                if (commentWrtTime != null) {
                    LocalDateTime commentWrtTimeAsLocalDateTime =
                            commentWrtTime.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
                    String commentTime = TimeAgoUtil.timeAgo(commentWrtTimeAsLocalDateTime);
                    comment.setCommentTime(commentTime);
                }
            }
            model.addAttribute("commentList", commentList);
        }
        return "commentListAjax";
    }

    /**
     * 코멘트 삭제 모달
     */
    @RequestMapping("/comment/deleteCommentModal")
    public String deleteCommentModal(@ModelAttribute("CommentVO") CommentVO vo) {
        return "deleteCommentModal";
    }

    /**
     * 코멘트 삭제
     */
    @RequestMapping("/comment/deleteCommentAjax")
    @ResponseBody
    public Response deleteCommentAjax(@ModelAttribute CommentVO vo, HttpServletRequest request) {
        Response response = new Response();
        LoginSession login = (LoginSession) request.getSession().getAttribute("loginSession");
        vo.setUsrId(login.getLoginUsrId());
        int result = 0;

        if(vo.getCommentId() != null){
            // 코멘트 DELETE
            result = commentService.deleteComment(vo);
        }

        if(result > 0){
            response.setOk(true);
            response.setMessage(messageSource.getMessage("success.comment.delete", null, Locale.getDefault()));
        } else {
            response.setOk(false);
            response.setMessage(messageSource.getMessage("fail.comment.delete", null, Locale.getDefault()));
        }
        return response;
    }

    /**
     * 내 코멘트 조회
     */
    @RequestMapping("/comment/myCommentAjax")
    public String myCommentAjax(@ModelAttribute("CommentVO") CommentVO vo, HttpServletRequest request, Model model) {
        LoginSession login = (LoginSession) request.getSession().getAttribute("loginSession");

        if(login != null){
            vo.setUsrId(login.getLoginUsrId());
            CommentVO myComment = commentService.getComment(vo);

            if(myComment != null){
                myComment.setEncodedId(Base64Util.encodeBase64(myComment.getUsrId()));
                // TimeAgoUtil 적용
                Date commentWrtTime = myComment.getWrtTime();
                if (commentWrtTime != null) {
                    LocalDateTime commentWrtTimeAsLocalDateTime =
                            commentWrtTime.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
                    String commentTime = TimeAgoUtil.timeAgo(commentWrtTimeAsLocalDateTime);
                    myComment.setCommentTime(commentTime);
                }
            }
            model.addAttribute("myComment", myComment);
        }
        return "myCommentAjax";
    }
}
