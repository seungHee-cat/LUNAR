package project.kr.sys.login.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import project.kr.sys.login.entity.LoginSession;
import project.kr.sys.usr.entity.SysUsrVO;
import project.kr.sys.usr.mapper.SysUsrMapper;

@Slf4j
@Service
public class SysLoginService {

    @Autowired
    PasswordEncoder passwordEncoder;

    @Autowired
    SysUsrMapper sysUsrMapper;

    public LoginSession login(String loginUsrNm, String loginUsrPw){
        // 유저 상세
        SysUsrVO vo = new SysUsrVO();
        vo.setLoginUsrNm(loginUsrNm);
        LoginSession usrDetail = sysUsrMapper.getLoginSession(vo);

        // 유저 정보 및 비밀번호 체크
        if (usrDetail == null || !passwordEncoder.matches(loginUsrPw, usrDetail.getUsrPw()))
            return null;

//        passwordEncoder.encode(pwd); //암호화 하는부분

        // 비밀번호 제거
        usrDetail.setUsrPw(null);

        return usrDetail;
    }
    
}
