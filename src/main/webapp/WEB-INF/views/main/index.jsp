<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
$(document).ready( function() {

});
</script>
<div class="root">
    <div class="wrap">
        <section>
            <div class="search_outer">
                <div class="search_inner">
                    <div class="search_contents">
                        <input type="text" id="searchKeyword" placeholder="원하는 영화를 검색해보세요">
                        <button type="button" id="search_btn">Search</button>
                    </div>
                    <div class="search_wrap">
                        <ul class="search_ul search_hide">
                        </ul>
                    </div>
                </div>
            </div>
            <div class="gradient">
                <div id="title_img">
                    <!-- <img alt="image" src="static/images/hugo.jpg"> -->
                </div>
            </div>
        </section>
        <div class="box">
            <div class="items">
                <div class="item_title">박스오피스(Now Playing)</div>
                <ul class="contents">
                    <div class="lists">
                        <c:forEach var="movie" items="${boxofficeList }" varStatus="loop">
                            <li class="content">
                                <a class="image" href="content.do?movie_id=${movie.movie_id }">
                                    <div class="movieRating">${loop.index + 1 }</div>
                                    <div class="poster">
                                        <img src="${movie.poster_path }" alt="poster">
                                    </div>
                                </a>
                                <div class="movieInfo">
                                    <div class="title">${movie.title }</div>
                                    <div class="year">
                                        ${movie.release_year }&nbsp;<span class="middle_dot">·</span>&nbsp;
                                        <span class="production_countries">${movie.production_countries }</span>
                                    </div>
                                    <div class="vote_average">${movie.vote_count }명&nbsp;<span>★</span>${movie.vote_average }</div>
                                </div>
                            </li>
                        </c:forEach>
                    </div>
                    <div class="boxofficeBtns buttons">
                        <div class="leftBtns">
                            <i class="bi bi-arrow-left-circle-fill"></i>
                        </div>
                        <div class="rightBtns">
                            <i class="bi bi-arrow-right-circle-fill"></i>
                        </div>
                    </div>
                </ul>
            </div>
            <div class="items">
                <div class="item_title">Netflix top10</div>
                <ul class="contents">
                    <div class="lists">
                        <c:forEach var="movie" items="${netflixList }" varStatus="loop">
                            <li class="content">
                                <a class="image" href="content.do?movie_id=${movie.movie_id }">
                                    <div class="movieRating">${loop.index + 1 }</div>
                                    <div class="poster">
                                        <img src="${movie.poster_path }" alt="poster">
                                    </div>
                                </a>
                                <div class="movieInfo">
                                    <div class="title">${movie.title }</div>
                                    <div class="year">
                                        ${movie.release_year }&nbsp;<span class="middle_dot">·</span>&nbsp;
                                        <span class="production_countries">${movie.production_countries }</span>
                                    </div>
                                    <div class="vote_average">${movie.vote_count }명&nbsp;<span>★</span>${movie.vote_average }</div>
                                </div>
                            </li>
                        </c:forEach>
                    </div>
                </ul>
                <div class="netflixBtns buttons">
                    <div class="leftBtns">
                        <i class="bi bi-arrow-left-circle-fill"></i>
                    </div>
                    <div class="rightBtns">
                        <i class="bi bi-arrow-right-circle-fill"></i>
                    </div>
                </div>
            </div>
            <div class="items">
                <div class="item_title">Watcha top10</div>
                <ul class="contents">
                    <div class="lists">
                        <c:forEach var="movie" items="${watchaList }" varStatus="loop">
                            <li class="content">
                                <a class="image" href="content.do?movie_id=${movie.movie_id }">
                                    <div class="movieRating">${loop.index + 1 }</div>
                                    <div class="poster">
                                        <img src="${movie.poster_path }" alt="poster">
                                    </div>
                                </a>
                                <div class="movieInfo">
                                    <div class="title">${movie.title }</div>
                                    <div class="year">
                                        ${movie.release_year }&nbsp;<span class="middle_dot">·</span>&nbsp;
                                        <span class="production_countries">${movie.production_countries }</span>
                                    </div>
                                    <div class="vote_average">${movie.vote_count }명&nbsp;<span>★</span>${movie.vote_average }</div>
                                </div>
                            </li>
                        </c:forEach>
                    </div>
                </ul>
                <div class="watchaBtns buttons">
                    <div class="leftBtns">
                        <i class="bi bi-arrow-left-circle-fill"></i>
                    </div>
                    <div class="rightBtns">
                        <i class="bi bi-arrow-right-circle-fill"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>