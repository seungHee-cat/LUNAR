package project.kr.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
    /**
     * 로그인(루트) 화면 조회
     */
    @RequestMapping("/main")
    public String main() {
        return "main";
    }
}
