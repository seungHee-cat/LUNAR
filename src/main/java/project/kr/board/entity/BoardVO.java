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
    private Integer page            = 0;
    private Integer size            = 0;
    private Integer offset          = 0;
    private Integer totalCnt        = 0;
    private Integer tagId           = 0;    // 게시글 ID
    private String tagNm            = null; // 게시글 태그
    private String postType         = null; // 게시글 타입(Insert/Update)
    private String schType   	    = null;	// 검색 타입

}
