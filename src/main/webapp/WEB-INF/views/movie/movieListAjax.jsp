<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript" src="<c:url value='/js/card.slide.js'/>"></script>

<div class="w-100 mt-1 mb-2">
    <div class="bg-black pointer d-flex justify-content-evenly align-items-center" style="border-radius: 10px;"
        onclick="fn_movieDetail(${mainMovie.movieId});">
        <div class="banner fw-bold" style="color: yellow; font-size: 1.6rem; max-width: 350px;">
        ${mainMovie.originalTitle}
    </div>
    <div class="position-relative" style="width: 300px; height: 120px; left: -50px; z-index: 1;">
        <!-- 배너 이미지 + 그라데이션 오버레이 -->
        <img src="${mainMovie.backdropPath}" style="width: 100%; height: 100%; object-fit: cover; border-radius: 10px;">
            <div style="
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                border-radius: 10px;
                background: linear-gradient(to right, rgba(0,0,0,0.9), transparent 40%, transparent 70%, rgba(0,0,0,0.9));
            "></div>
        </div>
        <div class="banner" style="font-size: 1.6rem; color: yellow;">절찬 상영중!</div>
    </div>
</div>
<!-- 박스오피스 리스트 -->
<div class="container-xl" style="transform: scale(1.05); position: relative;">
    <div class="card-slider-wrapper">
        <div class="mt-5">
            <div class="fw-bold" style="font-size: 1.1rem;"><span class="text-danger" style="padding-right: 5px;">|</span>
                <spring:message code="movie.text.boxOffice"/>&nbsp;(${minDate} ~ ${maxDate})
            </div>
        </div>
        <div class="boxoffice-card-slider">
            <c:forEach var="movie" items="${boxOfficeList }" varStatus="loop">
                <div class="card pointer" onclick="fn_movieDetail(${movie.movieId});">
                    <div class="card-header" style="padding: 0;">
                        <div class="rankingIndex">${loop.index + 1 }</div>
                        <img src="${movie.posterPath}" style="height: 300px;" class="card-img-top" alt="${movie.title}">
                    </div>
                    <div class="card-body">
                        <h5 class="card-title" style="font-size: 1.0rem; word-break: keep-all;">${movie.title }</h5>
                        <div class="card-text" style="font-size: 0.8rem;">
                            ${movie.releaseYear}<span style="padding-left: 5px; padding-right: 5px; word-break: keep-all;">·<span>${movie.productionCountries}
                        </div>
                    </div>
                </div>
            </c:forEach>
         </div>
        </div>
    <button type="button" class="shadow-sm boxoffice-prev-btn">❮</button>
    <button type="button" class="shadow-sm boxoffice-next-btn">❯</button>
    </div>
</div>
<!-- 넷플릭스 리스트 -->
<div class="container-xl" style="transform: scale(1.05); position: relative;">
    <div class="card-slider-wrapper">
        <div class="mt-5">
            <div class="fw-bold" style="font-size: 1.1rem;"><span class="text-danger" style="padding-right: 5px;">|</span><spring:message code="movie.text.netflix"/></div>
        </div>
        <div class="netflix-card-slider">
            <c:forEach var="movie" items="${netflixList }" varStatus="loop">
                <div class="card pointer" onclick="fn_movieDetail(${movie.movieId});">
                    <div class="card-header" style="padding: 0;">
                        <div class="rankingIndex">${loop.index + 1 }</div>
                        <img src="${movie.posterPath}" style="height: 300px;" class="card-img-top" alt="${movie.title}">
                    </div>
                    <div class="card-body">
                        <h5 class="card-title" style="font-size: 1.0rem; word-break: auto-phrase;">${movie.title }</h5>
                        <div class="card-text" style="font-size: 0.8rem;">
                            ${movie.releaseYear}<span style="padding-left: 5px; padding-right: 5px;">·<span>${movie.productionCountries}
                        </div>
                    </div>
                </div>
            </c:forEach>
         </div>
        </div>
        <button type="button" class="shadow-sm netflix-prev-btn">❮</button>
        <button type="button" class="shadow-sm netflix-next-btn">❯</button>
    </div>
</div>
<!-- 왓챠 리스트 -->
<div class="container-xl" style="transform: scale(1.05); position: relative;">
    <div class="card-slider-wrapper">
        <div class="mt-5">
            <div class="fw-bold" style="font-size: 1.1rem;"><span class="text-danger" style="padding-right: 5px;">|</span><spring:message code="movie.text.watcha"/></div>
        </div>
        <div class="watcha-card-slider">
            <c:forEach var="movie" items="${watchaList }" varStatus="loop">
                <div class="card pointer" onclick="fn_movieDetail(${movie.movieId});">
                    <div class="card-header" style="padding: 0;">
                        <div class="rankingIndex">${loop.index + 1 }</div>
                        <img src="${movie.posterPath}" style="height: 300px;" class="card-img-top" alt="${movie.title}">
                    </div>
                    <div class="card-body">
                        <h5 class="card-title" style="font-size: 1.0rem; word-break: auto-phrase;">${movie.title }</h5>
                        <div class="card-text" style="font-size: 0.8rem;">
                            ${movie.releaseYear}<span style="padding-left: 5px; padding-right: 5px;">·<span>${movie.productionCountries}
                        </div>
                    </div>
                </div>
            </c:forEach>
         </div>
        </div>
        <button type="button" class="shadow-sm watcha-prev-btn">❮</button>
        <button type="button" class="shadow-sm watcha-next-btn">❯</button>
    </div>
</div>
<!-- 디즈니 플러스 리스트 -->
<div class="container-xl" style="transform: scale(1.05); position: relative;">
    <div class="card-slider-wrapper">
        <div class="mt-5">
            <div class="fw-bold" style="font-size: 1.1rem;"><span class="text-danger" style="padding-right: 5px;">|</span><spring:message code="movie.text.disney"/></div>
        </div>
        <div class="disney-card-slider">
            <c:forEach var="movie" items="${disneyList }" varStatus="loop">
                <div class="card pointer" onclick="fn_movieDetail(${movie.movieId});">
                    <div class="card-header" style="padding: 0;">
                        <div class="rankingIndex">${loop.index + 1 }</div>
                        <img src="${movie.posterPath}" style="height: 300px;" class="card-img-top" alt="${movie.title}">
                    </div>
                    <div class="card-body">
                        <h5 class="card-title" style="font-size: 1.0rem; word-break: auto-phrase;">${movie.title }</h5>
                        <div class="card-text" style="font-size: 0.8rem;">
                            ${movie.releaseYear}<span style="padding-left: 5px; padding-right: 5px;">·<span>${movie.productionCountries}
                        </div>
                    </div>
                </div>
            </c:forEach>
         </div>
        </div>
        <button type="button" class="shadow-sm disney-prev-btn">❮</button>
        <button type="button" class="shadow-sm disney-next-btn">❯</button>
    </div>
</div>
<!-- 웨이브 리스트 -->
<div class="container-xl" style="transform: scale(1.05); position: relative;">
    <div class="card-slider-wrapper">
        <div class="mt-5">
            <div class="fw-bold" style="font-size: 1.1rem;"><span class="text-danger" style="padding-right: 5px;">|</span><spring:message code="movie.text.wavve"/></div>
        </div>
        <div class="wavve-card-slider">
            <c:forEach var="movie" items="${wavveList }" varStatus="loop">
                <div class="card pointer" onclick="fn_movieDetail(${movie.movieId});">
                    <div class="card-header" style="padding: 0;">
                        <div class="rankingIndex">${loop.index + 1 }</div>
                        <img src="${movie.posterPath}" style="height: 300px;" class="card-img-top" alt="${movie.title}">
                    </div>
                    <div class="card-body">
                        <h5 class="card-title" style="font-size: 1.0rem; word-break: auto-phrase;">${movie.title }</h5>
                        <div class="card-text" style="font-size: 0.8rem;">
                            ${movie.releaseYear}<span style="padding-left: 5px; padding-right: 5px;">·<span>${movie.productionCountries}
                        </div>
                    </div>
                </div>
            </c:forEach>
         </div>
        </div>
        <button type="button" class="shadow-sm wavve-prev-btn">❮</button>
        <button type="button" class="shadow-sm wavve-next-btn">❯</button>
    </div>
</div>
