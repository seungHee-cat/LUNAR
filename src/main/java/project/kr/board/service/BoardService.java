package project.kr.board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import project.kr.board.entity.BoardVO;
import project.kr.board.mapper.BoardMapper;

@Service
public class BoardService {

    @Autowired
    BoardMapper boardapper;

    /**
     * 게시글 작성
     */
    public int insertBoardPost(BoardVO vo) {
        int result = 1;
        try{
            boardapper.insertBoardPost(vo);
        } catch (Exception e) {
            e.printStackTrace();
            result = -1;
        }
        return result;
    }
}
