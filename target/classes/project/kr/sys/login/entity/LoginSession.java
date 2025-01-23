package project.kr.sys.login.entity;

import lombok.Data;

@Data
public class LoginSession {
    // 로그인 세션
    private String loginUsrId 		= null;	// 유저 ID
    private String loginUsrPw 		= null;	// 비밀번호
    private String loginUsrNm 		= null;	// 유저 닉네임
    private String usrNm            = null; // 유저명
    private String usrImg           = null; // 유저 이미지
    private String encodedId        = null; // ID 암호화 (URL 노출 방지)
}
