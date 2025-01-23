package project.kr.main.controller;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Locale;

@Controller
public class MainController implements ErrorController {
    /**
     * 메인 화면 조회
     */
    @RequestMapping("/main")
    public String main() {
        return "main";
    }

    /**
     * 에러 화면 조회
     */
    @RequestMapping("/error")
    public String handleError(HttpServletRequest request) {
        // HTTP 상태 코드 가져오기
        Object status = request.getAttribute("javax.servlet.error.status_code");

        if (status != null) {
            int statusCode = Integer.parseInt(status.toString());
            if (statusCode == 404) {
                return "error404";
            } else if (statusCode == 500) {
                return "error500";
            }
        }
        // 에러 기본 페이지 설정
        return "error500";
    }

    // 에러 페이지 테스트
    @RequestMapping("/test500")
    public String test500() {
        throw new RuntimeException("강제 500 에러 발생");
    }

    /**
     * 다국어 모달
     */
    @RequestMapping("/main/multiLangModal")
    public String multiLangModal() {
        return "multiLangModal";
    }

    /**
     * 다국어 인터셉터 -> 요청 처리
     */
    @RequestMapping("/changeLang")
    public String changeLang(@RequestParam String lang, HttpServletRequest request){
        Locale locale = new Locale(lang);
        HttpSession session = request.getSession();

        session.setAttribute("locale", locale.getLanguage());
        return "redirect:" + request.getHeader("Referer"); // 이전 페이지로 리다이렉트
    }
}









