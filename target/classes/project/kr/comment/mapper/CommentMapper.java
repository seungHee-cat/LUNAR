package project.kr.comment.mapper;

import org.apache.ibatis.annotations.Mapper;
import project.kr.comment.entity.CommentVO;

import java.util.List;

@Mapper
public interface CommentMapper {

    /**
     * 코멘트 조회
     */
    public CommentVO getComment(CommentVO vo);

    /**
     * 코멘트 작성
     */
    public int insertComment(CommentVO vo);

    /**
     * 코멘트 수정
     */
    public int updateComment(CommentVO vo);

    /**
     * 코멘트 리스트 조회
     */
    List<CommentVO> getCommentList(CommentVO vo);


    /**
     * 코멘트 삭제
     */
    public int deleteComment(CommentVO vo);

}