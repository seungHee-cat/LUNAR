package project.kr.sys.login.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import project.kr.com.util.Reply;
import project.kr.sys.login.entity.LoginSession;
import project.kr.sys.login.service.SysLoginService;
import project.kr.sys.usr.entity.SysUsrVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Slf4j
@Controller
public class SysLoginController {

    @Autowired
    private MessageSource messageSource;

    @Autowired
    SysLoginService sysLoginService;

    /**
     * 로그인(루트) 화면 조회
     */
    @RequestMapping("/sys/loginPop")
    public String sysLoginPop(String logoutMsg, Model model) {
        model.addAttribute("logoutMsg", logoutMsg);
        return "sysLoginPop";
    }

    /**
     * 로그인
     */
    @ResponseBody
    @RequestMapping("/sys/login/loginAjax")
    public Reply loginAjax(@ModelAttribute SysUsrVO vo, HttpServletRequest request) {
        // 로그인 체크
        LoginSession loginSession = sysLoginService.login(vo.getLoginUsrId(), vo.getLoginUsrPw());
        if(loginSession == null)
            return new Reply(false, "ID 또는 PW가 잘못되었습니다.");

        // 세션에 유저 상세 담기 & 세션 유지 시간 설정
        HttpSession session = request.getSession();
        session.setAttribute("loginSession", loginSession);
        session.setMaxInactiveInterval(60 * 60 * 24 * 5); // 5일

        return new Reply(true);
    }

    /**
     * 로그아웃 화면 조회
     */
    @RequestMapping("/sys/login/sysLoginLogout")
    public String sysLoginLogout() {
        return "sysLoginLogout";
    }

}
