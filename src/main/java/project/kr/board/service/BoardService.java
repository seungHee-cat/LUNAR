package project.kr.board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import project.kr.board.entity.BoardVO;
import project.kr.board.mapper.BoardMapper;

import java.util.List;

@Service
public class BoardService {

    @Autowired
    BoardMapper boardMapper;

    /**
     * 게시글 리스트 조회
     */
    public List<BoardVO> getBoardList(BoardVO vo) {
        return boardMapper.getBoardList(vo);
    }

    /**
     * 게시글 리스트 개수 조회
     */
    public int getBoardListCnt(BoardVO vo) {
        return boardMapper.getBoardListCnt(vo);
    }

    /**
     * 게시글 상세 페이지 조회
     */
    public BoardVO getBoardDetail(BoardVO vo) {
        return boardMapper.getBoardDetail(vo);
    }

    /**
     * 게시글 작성
     */
    public int insertBoardPost(BoardVO vo) {
        int result = 1;
        try{
            boardMapper.insertBoardPost(vo);
        } catch (Exception e) {
            e.printStackTrace();
            result = -1;
        }
        return result;
    }

    /**
     * 게시글 수정
     */
    public int updateBoardPost(BoardVO vo) {
        int result = 1;
        try{
            boardMapper.updateBoardPost(vo);
        } catch (Exception e) {
            e.printStackTrace();
            result = -1;
        }
        return result;
    }

    /**
     * 게시글 삭제
     */
    public int deleteBoard(BoardVO vo) {
        int result = 1;
        try{
            boardMapper.deleteBoard(vo);
        } catch (Exception e) {
            e.printStackTrace();
            result = -1;
        }
        return result;
    }

    /**
     * 게시글 태그 추가
     */
    public int insertBoardTag(BoardVO vo) {
        int result = 1;
        try{
            boardMapper.insertBoardTag(vo);
        } catch (Exception e) {
            e.printStackTrace();
            result = -1;
        }
        return result;
    }

    /**
     * 게시글 태그 수정
     */
    public int updateBoardTag(BoardVO vo) {
        int result = 1;
        try{
            boardMapper.updateBoardTag(vo);
        } catch (Exception e) {
            e.printStackTrace();
            result = -1;
        }
        return result;
    }
}
