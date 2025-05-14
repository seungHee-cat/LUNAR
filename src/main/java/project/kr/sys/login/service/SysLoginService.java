package project.kr.sys.login.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import project.kr.com.util.Base64Util;
import project.kr.sys.login.entity.LoginSession;
import project.kr.sys.usr.entity.SysUsrVO;
import project.kr.sys.usr.mapper.SysUsrMapper;

import java.util.Random;
import java.util.UUID;

@Slf4j
@Service
public class SysLoginService {

    @Autowired
    PasswordEncoder passwordEncoder;

    @Autowired
    SysUsrMapper sysUsrMapper;

    /*
    * 로그인
    */
    public LoginSession login(String loginUsrId, String loginUsrPw){
        // 유저 상세
        SysUsrVO vo = new SysUsrVO();
        vo.setUsrId(loginUsrId);
        vo.setUsrPw(loginUsrPw);

        if(loginUsrId.contains("admin")){
            vo.setRoleCode("ROLE_ADMIN");
        }else {
            vo.setRoleCode("ROLE_USER");
        }
        vo = sysUsrMapper.getLoginSession(vo);

        // 세션용 로그인 설정
        LoginSession usrDetail = new LoginSession();
        usrDetail.setLoginUsrId(vo.getUsrId());
        usrDetail.setLoginUsrPw(vo.getUsrPw());
        usrDetail.setUsrNm(vo.getUsrNm());
        usrDetail.setUsrImg(vo.getUsrImg());

        String encodedId = Base64Util.encodeBase64(vo.getUsrId());
        usrDetail.setEncodedId(encodedId);

        // 유저 정보 및 비밀번호 체크
        if (usrDetail == null || !passwordEncoder.matches(loginUsrPw, usrDetail.getLoginUsrPw()))
            return null;

        // 비밀번호 제거
        usrDetail.setLoginUsrPw(null);

        if(usrDetail.getLoginUsrId().contains("admin")){
            usrDetail.setRoleCode("ROLE_ADMIN");
        }else {
            usrDetail.setRoleCode("ROLE_USER");
        }

        return usrDetail;
    }

    /*
     * 회원가입
     */
    public int register(SysUsrVO vo){
        int result = 1;
        String password = vo.getUsrPw(); // 평문 비밀번호
        vo.setUsrPw(passwordEncoder.encode(password)); // 비밀번호 암호화

        try{
            String prefix = "USER";
            Random random = new Random();
            int randomNumber = random.nextInt(10000); // 0~9999
            String randomUsrNm = String.format("%04d", randomNumber);

            vo.setUsrNm(prefix+randomUsrNm);
            sysUsrMapper.insertUsr(vo);

            vo.setDetailId(UUID.randomUUID().toString()); // USER_DETAIL PK 지정
            sysUsrMapper.insertUsrDetail(vo);

        } catch (Exception e) {
            e.printStackTrace();
            result = -1;
        }
        return result;
    }

    /*
     * 회원가입 아이디 체크
     */
    public int idCheck(String id){
        return sysUsrMapper.idCheck(id);
    }
    
}
