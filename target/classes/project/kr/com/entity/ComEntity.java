package project.kr.com.entity;

import lombok.Data;

@Data
public class ComEntity {
    /* Database */
    private String dbId         = null; // DB 아이디

    /* Additional usr info */
    private String detailId     = null; // 유저상세ID
    private String email 		= null;	// 이메일
    private String usrDesc      = null; // 유저소개말
    private String regDt 		= null;	// 등록일시
    private String mdfId 		= null;	// 수정자ID
    private String mdfDt 		= null;	// 수정일시

}
