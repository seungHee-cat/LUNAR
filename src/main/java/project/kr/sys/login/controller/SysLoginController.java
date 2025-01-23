package project.kr.sys.login.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import project.kr.com.util.Response;
import project.kr.sys.login.entity.LoginSession;
import project.kr.sys.login.service.SysLoginService;
import project.kr.sys.usr.entity.SysUsrVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Locale;

@Slf4j
@Controller
public class SysLoginController {

    @Autowired
    private MessageSource messageSource;

    @Autowired
    SysLoginService sysLoginService;

    /**
     * 로그인 모달
     */
    @RequestMapping("/sys/loginModal")
    public String sysLoginModal(HttpServletRequest request, String logoutMsg, Model model) {
        String referer = request.getHeader("Referer"); // 이전 페이지 URL

        if (referer != null && !referer.contains("/sys/loginModal")) {
            request.getSession().setAttribute("redirectUrl", referer);
        }

        model.addAttribute("logoutMsg", logoutMsg);
        return "sysLoginModal";
    }

    /**
     * 로그인
     */
    @ResponseBody
    @RequestMapping("/sys/login/loginAjax")
    public Response loginAjax(@ModelAttribute SysUsrVO vo, HttpServletRequest request) {
        Response response = new Response();

        // 로그인 체크
        try {
            LoginSession loginSession = sysLoginService.login(vo.getUsrId(), vo.getUsrPw());
            response.setMessage(messageSource.getMessage("success.login.conf", new Object[] {loginSession.getUsrNm()}, Locale.KOREAN));

            // 세션에 유저 상세 담기 & 세션 유지 시간 설정
            HttpSession session = request.getSession();
            session.setAttribute("loginSession", loginSession);
            session.setMaxInactiveInterval(60 * 60 * 24 * 5); // 5일

        } catch (Exception e){
            return new Response(false, "ID 또는 PW가 잘못되었습니다.");
        }
        return response;
    }

    /**
     * 로그아웃 화면 조회
     */
    @RequestMapping("/sys/login/sysLogoutModal")
    public String sysLogoutModal() {
        return "sysLogoutModal";
    }

    /**
     * 로그아웃
     */
    @RequestMapping("/sys/login/logout")
    public String logout(HttpSession session, RedirectAttributes attributes) {
        session.invalidate();
        attributes.addFlashAttribute("logoutMsg", "로그아웃되었습니다.");
        return "redirect:/main";
    }

    /**
     *  회원가입 모달
     */
    @RequestMapping("/sys/registerModal")
    public String registerModal(String registerMsg, Model model){
        model.addAttribute("registerMsg", registerMsg);
        return "registerModal";
    }

    /**
     * 회원가입
     */
    @ResponseBody
    @RequestMapping("/sys/register/registerAjax")
    public Response registerAjax(@ModelAttribute SysUsrVO vo, HttpServletRequest request) {
        Response response = new Response();
        int result = sysLoginService.register(vo);

        if(result > 0){
            response.setOk(true);
            response.setMessage(messageSource.getMessage("success.register.insert", null, Locale.KOREAN));
        } else {
            response.setOk(false);
            response.setMessage(messageSource.getMessage("fail.register.insert", null, Locale.KOREAN));
        }
        return new Response(true);
    }

    /**
     * 회원가입 아이디 체크
     */
    @RequestMapping("/sys/usr/idCheck")
    @ResponseBody
    public String idCheck(@RequestBody String id) {
        int check = sysLoginService.idCheck(id);

        if(check == 1) return "duplicated";
        else return "available";
    }
}
