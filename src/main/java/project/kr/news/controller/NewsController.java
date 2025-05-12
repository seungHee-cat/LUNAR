package project.kr.news.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import project.kr.news.entity.NewsVO;
import project.kr.news.service.NewsService;

@Controller
public class NewsController {

    @Autowired
    private MessageSource messageSource;

    @Autowired
    private NewsService newsservice;

    @RequestMapping("/news")
    public String newsList(@ModelAttribute NewsVO vo, Model model){

        // 게시판 리스트 로드하는 로직?

        return "newsList";
    }

}
