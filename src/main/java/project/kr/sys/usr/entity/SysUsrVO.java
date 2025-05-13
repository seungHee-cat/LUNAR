package project.kr.sys.usr.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.springframework.web.multipart.MultipartFile;
import project.kr.com.entity.ComEntity;

@Data
@EqualsAndHashCode(callSuper = true)
public class SysUsrVO extends ComEntity {
    // 역할 (USER_ROLE)
    private String roleCode         = null; // 유저 역할

    // 유저 (USER, USER_DETAIL)
    private String usrId            = null;	// 유저 ID
    private String usrPw            = null; // 유저 PW
    private String usrNm 		    = null;	// 유저명
    private String usrImg           = null; // 유저 프로필 이미지
    private String encodedId        = null; // ID 암호화 (URL 노출 방지)

    private MultipartFile file      = null; // 유저 이미지 파일
    private Integer movieId         = 0;    // 유저 영화 조회
    private Integer ratingMonth     = 0;    // 유저 평가 Month
    private String orderType        = null; // 정렬 조건


}
