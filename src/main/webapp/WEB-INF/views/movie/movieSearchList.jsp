<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">

</script>

<div class="container-xl p-5">
    <h4 class="mt-5">"${schKeyword}"<spring:message code="search.result.text"/></h4>
    <c:if test="${not empty boxOfficeList }">
        <!-- 박스오피스 검색결과 -->
        <div class="d-flex flex-column my-5 p-4" style="background-color: white;">
            <div class="fw-bold"><span class="text-danger" style="padding-right: 5px;">|</span><spring:message code="movie.text.boxOffice"/></div>
            <div class="d-flex flex-column my-3">
                <c:forEach var="movie" items="${boxOfficeList }">
                    <div class="d-flex align-items-center py-3 pointer" onclick="fn_movieDetail(${movie.movieId});"
                        style="border-top: 1px solid lightgray;">
                        <div class="p-3">
                            <fmt:formatNumber type="number" maxFractionDigits="0" value="${movie.voteAverage / 5.0 * 100}" />%
                        </div>
                        <div style="padding: 0;">
                            <img src="${movie.posterPath}" class="border-5" style="width: 90px; height: 120px;" alt="${movie.title}">
                        </div>
                        <div class="mx-3">
                            <h5 class="fw-bold" style="font-size: 1.0rem; word-break: auto-phrase;">${movie.title } (${movie.releaseYear})</h5>
                            <p>${movie.genreIds}</p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </c:if>
    <c:if test="${not empty netflixList }">
        <!-- 넷플릭스 검색결과 -->
        <div class="d-flex flex-column my-5 p-4" style="background-color: white;">
            <div class="fw-bold"><span class="text-danger" style="padding-right: 5px;">|</span><spring:message code="movie.text.netflix"/></div>
            <div class="d-flex flex-column my-3">
                <c:forEach var="movie" items="${netflixList }">
                    <div class="d-flex align-items-center py-3 pointer" onclick="fn_movieDetail(${movie.movieId});"
                        style="border-top: 1px solid lightgray;">
                        <div class="p-3">
                            <fmt:formatNumber type="number" maxFractionDigits="0" value="${movie.voteAverage / 5.0 * 100}" />%
                        </div>
                        <div style="padding: 0;">
                            <img src="${movie.posterPath}" class="border-5" style="width: 90px; height: 120px;" alt="${movie.title}">
                        </div>
                        <div class="mx-3">
                            <h5 class="fw-bold" style="font-size: 1.0rem; word-break: auto-phrase;">${movie.title } (${movie.releaseYear})</h5>
                            <p>${movie.genreIds}</p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </c:if>
    <c:if test="${not empty watchaList }">
        <!-- 왓챠피디아 검색결과 -->
        <div class="d-flex flex-column my-5 p-4" style="background-color: white;">
            <div class="fw-bold"><span class="text-danger" style="padding-right: 5px;">|</span><spring:message code="movie.text.watcha"/></div>
            <div class="d-flex flex-column my-3">
                <c:forEach var="movie" items="${watchaList }">
                    <div class="d-flex align-items-center py-3 pointer" onclick="fn_movieDetail(${movie.movieId});"
                        style="border-top: 1px solid lightgray;">
                        <div class="p-3">
                            <fmt:formatNumber type="number" maxFractionDigits="0" value="${movie.voteAverage / 5.0 * 100}" />%
                        </div>
                        <div style="padding: 0;">
                            <img src="${movie.posterPath}" class="border-5" style="width: 90px; height: 120px;" alt="${movie.title}">
                        </div>
                        <div class="mx-3">
                            <h5 class="fw-bold" style="font-size: 1.0rem; word-break: auto-phrase;">${movie.title } (${movie.releaseYear})</h5>
                            <p>${movie.genreIds}</p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </c:if>
</div>