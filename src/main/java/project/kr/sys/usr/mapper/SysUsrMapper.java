package project.kr.sys.usr.mapper;

import org.apache.ibatis.annotations.Mapper;
import project.kr.sys.login.entity.LoginSession;
import project.kr.sys.usr.entity.SysUsrVO;

import java.util.HashMap;

@Mapper
public interface SysUsrMapper {

    /**
     * 유저 상세
     */
    HashMap getSysUsrDetail(SysUsrVO vo);

    /**
     * 로그인 세션용 유저 상세
     */
    LoginSession getLoginSession(SysUsrVO vo);

}
