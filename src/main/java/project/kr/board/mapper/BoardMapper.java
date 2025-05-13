package project.kr.board.mapper;

import org.apache.ibatis.annotations.Mapper;
import project.kr.board.entity.BoardVO;

@Mapper
public interface BoardMapper {

    /**
     * 게시글 작성
     */
    public int insertBoardPost(BoardVO vo);


}