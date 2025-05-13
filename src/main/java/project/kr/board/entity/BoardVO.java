package project.kr.board.entity;

import lombok.Data;

@Data
public class BoardVO {

    private Integer boardId     = 0;
    private String title        = null;
    private String content      = null;
    private String usrId        = null;

}
