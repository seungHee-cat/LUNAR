package project.kr.comment.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import project.kr.comment.entity.CommentVO;
import project.kr.comment.mapper.CommentMapper;

import java.util.List;
import java.util.UUID;

@Service
public class CommentService {

    @Autowired
    CommentMapper commentMapper;

    /**
     * 코멘트 조회
     */
    public CommentVO getComment(CommentVO vo) {
        return commentMapper.getComment(vo);
    }

    /**
     * 코멘트 작성
     */
    public int insertComment(CommentVO vo) {
        int result = 1;
        try{
            vo.setCommentId(UUID.randomUUID().toString());
            commentMapper.insertComment(vo);
        } catch (Exception e) {
            e.printStackTrace();
            result = -1;
        }
        return result;
    }

    /**
     * 코멘트 수정
     */
    public int updateComment(CommentVO vo) {
        int result = 1;
        try{
            commentMapper.updateComment(vo);
        } catch (Exception e) {
            e.printStackTrace();
            result = -1;
        }
        return result;
    }

    /**
     * 코멘트 리스트 조회
     */
    public List<CommentVO> getCommentList(CommentVO vo) {
        return commentMapper.getCommentList(vo);
    }

    /**
     * 코멘트 삭제
     */
    public int deleteComment(CommentVO vo) {
        int result = 1;
        try{
            commentMapper.deleteComment(vo);
        } catch (Exception e) {
            e.printStackTrace();
            result = -1;
        }
        return result;
    }

}
