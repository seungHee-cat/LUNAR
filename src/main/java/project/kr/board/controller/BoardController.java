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
import java.util.List;
import java.util.Locale;

@Controller
public class BoardController {

    @Autowired
    private MessageSource messageSource;

    @Autowired
    private BoardService boardService;

    /**
     * 게시판 조회
     */
    @RequestMapping("/board")
    public String board(){
        return "board";
    }

    /**
     * 게시글 상세 페이지 조회
     */
    @RequestMapping("/board/boardDetail")
    public String boardDetail(@ModelAttribute BoardVO vo, Model model){
        if(vo != null) {
            BoardVO board = boardService.getBoardDetail(vo);
            model.addAttribute("board", board);
        }
        return "boardDetail";
    }

    /**
     * 게시판 리스트 초기화
     */
    @RequestMapping("/board/boardListInitAjax")
    public String boardListInitAjax(@ModelAttribute BoardVO vo, Model model){
        int page = 1;
        final int SIZE = 5;
        int offset = (page - 1) * SIZE;
        int totalCnt = boardService.getBoardListCnt(vo);
        vo.setSize(SIZE);
        vo.setOffset(offset);
        List<BoardVO> boardList = boardService.getBoardList(vo);

        if(boardList != null && !boardList.isEmpty()) {
            int totalPages = (int) Math.ceil((double) totalCnt / SIZE);
            model.addAttribute("totalPages", totalPages);

            model.addAttribute("curPage", page);
            model.addAttribute("totalCnt", totalCnt);
            model.addAttribute("size", SIZE);
            model.addAttribute("boardList", boardList);
        }
        return "boardListAjax";
    }

    /**
     * 게시판 리스트 조회
     */
    @RequestMapping("/board/boardListAjax")
    public String boardListAjax(@ModelAttribute BoardVO vo, Model model){
        int page = vo.getPage();
        final int SIZE = 5;
        int offset = (page - 1) * SIZE;
        int totalCnt = boardService.getBoardListCnt(vo);
        vo.setSize(SIZE);
        vo.setOffset(offset);
        List<BoardVO> boardList = boardService.getBoardList(vo);

        if(boardList != null && !boardList.isEmpty()) {
            int totalPages = (int) Math.ceil((double) totalCnt / SIZE);
            model.addAttribute("totalPages", totalPages);

            model.addAttribute("curPage", page);
            model.addAttribute("totalCnt", totalCnt);
            model.addAttribute("size", SIZE);
            model.addAttribute("boardList", boardList);
        }
        return "boardListAjax";
    }

    /**
     * 게시글 작성/수정 페이지 조회
     */
    @RequestMapping("/board/boardPost")
    public String boardPost(@ModelAttribute BoardVO vo, Model model){
        if(vo.getBoardId() != null && vo.getBoardId() != 0){
            BoardVO board = boardService.getBoardDetail(vo);
            model.addAttribute("board", board);
        }
        return "boardPost";
    }

    /**
     * 게시글 작성/수정
     */
    @RequestMapping("/board/boardPostAjax")
    @ResponseBody
    public Response boardPostAjax(@ModelAttribute BoardVO vo, Model model, HttpServletRequest request){
        Response response = new Response();
        LoginSession login = (LoginSession) request.getSession().getAttribute("loginSession");

        if(login != null){
            vo.setUsrId(login.getLoginUsrId());

            int result = 0;

            // 공지사항 태그
            if(vo.getSchType().equals("notice")) {
                vo.setSchType("1");
                vo.setTagId(1);
            }else if(vo.getSchType().equals("func")){
                vo.setSchType("2");
                vo.setTagId(2);
            }else if(vo.getSchType().equals("ui")){
                vo.setSchType("3");
                vo.setTagId(3);
            }

            // 게시글 INSERT
            if (vo.getPostType().equals("I")) {
                result = boardService.insertBoardPost(vo);
                result = boardService.insertBoardTag(vo);

                if(result > 0){
                    response.setOk(true);
                    response.setMessage(messageSource.getMessage("success.board.insert", null, Locale.getDefault()));
                } else {
                    response.setOk(false);
                    response.setMessage(messageSource.getMessage("fail.board.insert", null, Locale.getDefault()));
                }
            // 게시글 UPDATE
            }else if(vo.getPostType().equals("U")){
                result = boardService.updateBoardPost(vo);
                result = boardService.updateBoardTag(vo);

                if(result > 0){
                    response.setOk(true);
                    response.setMessage(messageSource.getMessage("success.board.update", null, Locale.getDefault()));
                } else {
                    response.setOk(false);
                    response.setMessage(messageSource.getMessage("fail.board.update", null, Locale.getDefault()));
                }

            }

        }
        return response;
    }

    /**
     * 게시글 삭제 모달
     */
    @RequestMapping("/board/deleteBoardModal")
    public String deleteBoardModal(@ModelAttribute("BoardVO") BoardVO vo) {
        return "deleteBoardModal";
    }


    /**
     * 게시글 삭제
     */
    @RequestMapping("/board/deleteBoardAjax")
    @ResponseBody
    public Response deleteBoardAjax(@ModelAttribute BoardVO vo){
        Response response = new Response();
        int result = 0;

        if(vo.getBoardId() != null){
            // 게시글 DELETE
            result = boardService.deleteBoard(vo);
            result = boardService.deleteBoardTag(vo);
        }

        if(result > 0){
            response.setOk(true);
            response.setMessage(messageSource.getMessage("success.board.delete", null, Locale.getDefault()));
        } else {
            response.setOk(false);
            response.setMessage(messageSource.getMessage("fail.board.delete", null, Locale.getDefault()));
        }
        return response;
    }

}
