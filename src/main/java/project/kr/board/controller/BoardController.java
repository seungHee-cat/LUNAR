package project.kr.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import project.kr.board.entity.BoardVO;
import project.kr.board.service.BoardService;
import project.kr.com.util.Response;
import project.kr.sys.login.entity.LoginSession;

import javax.servlet.http.HttpServletRequest;
import java.util.Locale;

@Controller
public class BoardController {

    @Autowired
    private MessageSource messageSource;

    @Autowired
    private BoardService boardService;

    /**
     * 게시판 리스트 조회
     */
    @RequestMapping("/board")
    public String board(Model model){
        // 게시판 리스트 로드 Ajax

        return "board";
    }

    /**
     * 게시판 작성 화면 조회
     */
    @RequestMapping("/board/post")
    public String boardPost(){
        return "boardPost";
    }

    /**
     * 게시판 글 작성
     */
    @RequestMapping("/board/boardPostAjax")
    @ResponseBody
    public Response boardPostAjax(@ModelAttribute BoardVO vo, HttpServletRequest request){
        Response response = new Response();
        LoginSession login = (LoginSession) request.getSession().getAttribute("loginSession");

        if(login != null){
            vo.setUsrId(login.getLoginUsrId());

            // 게시글 INSERT
            int result = boardService.insertBoardPost(vo);

            if(result > 0){
                response.setOk(true);
                response.setMessage(messageSource.getMessage("success.board.insert", null, Locale.getDefault()));
            } else {
                response.setOk(false);
                response.setMessage(messageSource.getMessage("fail.board.insert", null, Locale.getDefault()));
            }
        }

        return response;
    }

}
