package project.kr.sys.login.entity;

import lombok.Data;

@Data
public class LoginSession {
    // 사용자 (USER)
    private String usrId 		= null;	// 사용자ID
    private String usrNm 		= null;	// 사용자명
    private String usrPw 		= null;	// 비밀번호
    private String email 		= null;	// 이메일
    private String phone		= null;	// 연락처
    private String regId 		= null;	// 등록자ID
    private String regDt 		= null;	// 등록일시
    private String mdfId 		= null;	// 수정자ID
    private String mdfDt 		= null;	// 수정일시
}
