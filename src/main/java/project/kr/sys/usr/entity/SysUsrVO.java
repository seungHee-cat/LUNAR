package project.kr.sys.usr.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class SysUsrVO extends SysUsrEntity{
    /**************************************************
     * 검색조건 시작
     **************************************************/
    private String loginUsrNm           = null;
    private String loginUsrPw           = null;
    private String dbId                 = null;
    private String dbNm                 = null;
    /**************************************************
     * 검색조건 종료
     **************************************************/
}
