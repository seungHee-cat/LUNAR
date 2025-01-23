package project.kr.comment.entity;

import lombok.Data;

import java.util.Date;

@Data
public class CommentVO {
    private String commentId        = null;     // 코멘트 아이디 (PK)
    private String commentContent   = null;     // 코멘트 내용
    private Date wrtTime            = null;     // 코멘트 작성시간
    private String reviewId         = null;     // 리뷰 아이디
    private String usrId            = null;     // 유저 아이디
    private String usrNm            = null;     // 유저 닉네임
    private Integer movieId         = 0;        // 영화 아이디

    /* Additional */
    private String postType         = null;     // 코멘트 타입(Insert/Update)
    private String commentTime      = null;     // 코멘트 시간(TimeAgoUtil)
    private String usrImg           = null;     // 유저 프로필 이미지
    private String encodedId        = null;     // ID 암호화 (URL 노출 방지)
}
