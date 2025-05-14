package project.kr.board.entity;

import lombok.Data;

import java.util.Date;

@Data
public class BoardVO {

    private Integer boardId     = 0;
    private String title        = null;
    private String content      = null;
    private String usrId        = null;
    private Date wrtTime        = null;

    /* Additional */
    private String postType         = null; // 게시글 타입(Insert/Update)

}
