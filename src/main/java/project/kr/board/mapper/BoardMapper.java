package project.kr.board.mapper;

import org.apache.ibatis.annotations.Mapper;
import project.kr.board.entity.BoardVO;

import java.util.List;

@Mapper
public interface BoardMapper {

    /**
     * 게시글 리스트 조회
     */
    List<BoardVO> getBoardList(BoardVO vo);

    /**
     * 게시글 상세 페이지 조회
     */
    BoardVO getBoardDetail(BoardVO vo);

    /**
     * 게시글 작성
     */
    public int insertBoardPost(BoardVO vo);

    /**
     * 게시글 수정
     */
    public int updateBoardPost(BoardVO vo);

    /**
     * 게시글 삭제
     */
    public int deleteBoard(BoardVO vo);
}