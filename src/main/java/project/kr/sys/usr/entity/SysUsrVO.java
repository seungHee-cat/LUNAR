package project.kr.sys.usr.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import project.kr.com.entity.ComEntity;

@Data
@EqualsAndHashCode(callSuper = true)
public class SysUsrVO extends ComEntity {
    // 로그인 세션
    private String loginUsrId   = null;	// 사용자ID
    private String loginUsrPw   = null; // 사용자PW
    private String usrNm 		= null;	// 사용자명
    private String email 		= null;	// 이메일
    private String phone		= null;	// 연락처
}
