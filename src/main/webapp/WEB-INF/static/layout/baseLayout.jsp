<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="project.kr.sys.login.entity.LoginSession" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>LUNAR</title>

	<!--
	--------------------------------------------------------------------
			공통 CSS Files
	--------------------------------------------------------------------
	-->

    <link rel="icon" href="/file/images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/bootstrap/styles.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/font-awesome/font-awesome.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/star-rating/star-rating.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/jquery-ui/jquery-ui.min.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/chart/Chart.min.css'/>" />

	<!--
	--------------------------------------------------------------------
			공통 JS Files
	--------------------------------------------------------------------
	-->

	<script type="text/javascript" src="<c:url value='/js/jquery-3.7.1.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/bootstrap.bundle.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/star-rating.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/Chart.bundle.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/ajaxFunction.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/modal.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/toast.js'/>"></script>

</head>
<script type="text/javascript">

$(document).ready( function() {
    fn_dropdownAjax(); // 사진/드롭다운 조회

    $('.search-ul').addClass('search-hide');
    /* navbar 스크롤 효과 */
    window.addEventListener('scroll', function () {
        if ($(window).scrollTop() === 0) {
            $('#navbar').removeClass('transparent');
            $('#logo').css('color', 'black');
            $("#schTitle").css('color', 'black');
            $('#schBtn').css('color', 'black');
            $('#dropdownProfile').css('color', 'black');
            $('#login').css('color', 'black');
        } else {
            $('#navbar').addClass('transparent');
            $('#logo').css('color', 'gray');
            $('#schTitle').css('color', 'white');
            $('#schBtn').css('color', 'white');
            $('#dropdownProfile').css('color', 'white');
            $('#login').css('color', 'gray');
        }
    });

    /* 영화 상세 페이지 조회 */
    $('.search-ul').on("click", ".search-movie", function () {
        const movieId = $(this).data('movie-id');
        fn_movieDetail(movieId);
    });

    /* 영화 리스트 ajax 클릭 이벤트 */
    document.addEventListener('click', function () {
       const searchMovieList = document.querySelectorAll('.search-movie');

       if (searchMovieList.length > 0) {
           $('.search-ul').addClass('search-hide');
       }else{
            $('.search-ul').removeClass('search-hide');
       }
    });

    /* 검색 엔터 이벤트 */
    $('#schTitle').on('keydown', function(e) {
        if (e.keyCode === 13) {
            e.preventDefault();
            fn_movieSchPage();
        }
    });
});

/*--------------------------------------------------------
| 유저 프로필 사진, DROPDOWN 로드
 --------------------------------------------------------*/
function fn_dropdownAjax(){
    fn_ajaxRoadDiv("<c:url value='/sys/usr/dropdownAjax'/>", null, "dropdownDiv");
}

/*--------------------------------------------------------
| 영화 검색 리스트 Ajax 로드
 --------------------------------------------------------*/
function fn_schListAjax(){
    let schTitle = $('#schTitle').val();
    if (schTitle === '') {
        return;
    }
    fn_ajaxSearchView("topFrm", "<c:url value='/movie/getMovieSchListAjax'/>", "searchDiv");
}

/*--------------------------------------------------------
| 영화 검색 페이지 이동
 --------------------------------------------------------*/
function fn_movieSchPage(){
    let schTitle = $('#schTitle').val();
    if (schTitle === '') {
        return;
    }
    location.href="/movie/movieSearch?schTitle=" + schTitle;
}

/*--------------------------------------------------------
| 유저 페이지 이동
 --------------------------------------------------------*/
function fn_usrContents(encodedId){
    location.href="/sys/usr/usrContents?encodedId="+encodedId;
}

/*--------------------------------------------------------
| 영화 상세 페이지 이동
 --------------------------------------------------------*/
function fn_movieDetail(movieId) {
    location.href = "<c:url value='/movie/movieDetail'/>" + "?movieId=" + movieId;
}

/*--------------------------------------------------------
| 리뷰 상세 페이지 이동
 --------------------------------------------------------*/
function fn_reviewDetail(reviewId){
    location.href = "<c:url value='/review/reviewDetail'/>" + "?reviewId=" + reviewId;
}

/*--------------------------------------------------------
| 로그인 모달
 --------------------------------------------------------*/
function loginModal() {
    let formData = new FormData();
    modal.openModal("<c:url value='/sys/loginModal'/>", formData, "medium");
}

/*--------------------------------------------------------
| 로그아웃 모달 열기
 --------------------------------------------------------*/
function logoutModal() {
    let formData = new FormData();
    modal.openModal("<c:url value='/sys/login/sysLogoutModal'/>", formData, "small");
}

/*--------------------------------------------------------
| 프로필 설정 모달
 --------------------------------------------------------*/
function settingModal() {
    let formData = new FormData();
    modal.openModal("<c:url value='/sys/usr/settingModal'/>", formData, "medium");
}

/*--------------------------------------------------------
| 다국어 모달
 --------------------------------------------------------*/
function multiLangModal() {
    let formData = new FormData();
    modal.openModal("<c:url value='/main/multiLangModal'/>", formData, "small");
}

</script>
<body class="bg-light">
    <!-- Header: 로고, 검색, 로그인/유저정보 -->
    <form id="topFrm" name="topFrm">
    <input type="hidden" name="loginUsrId" value="${loginSession.loginUsrId}">
        <nav id="navbar" class="top-app-bar navbar navbar-expand-sm justify-content-center shadow-sm" style="height: 70px;">
            <div class="container-fluid">
                <div class="d-flex align-items-center justify-content-start px-4">
                    <!-- Navbar logo -->
                    <a href="/" id="logo" style="text-decoration: none;">LUNAR</a>
                    <!-- Navbar search -->
                    <div class="d-flex align-items-center">
                        <input class="form-control ms-4 me-2" type="text" id="schTitle" name="schTitle"
                            style="position: relative; width: 370px; background-color: transparent;" onKeyup="fn_schListAjax();" >
                        <button class="btn d-flex align-items-center" type="button" id="schBtn" onclick="fn_movieSchPage();"
                            style="position: absolute; left: 420px; border: none; font-size: 0.9rem; padding: 0; background-color: transparent;">Search</button>
                    </div>
                    <!-- 영화 검색 Ajax -->
                    <div id="searchDiv" class="searchDiv">
                        <ul class="search-ul"></ul>
                    </div>
                </div>
                <div>
                <c:if test="${empty loginSession}">
                    <!-- LOGIN -->
                    <a class="nav-link" id="login" onclick="loginModal();">LOGIN/SIGNUP</a>
                </c:if>
                <c:if test="${not empty loginSession}">
                    <!-- User profile dropdown -->
                    <div id="dropdownDiv"></div>
                </c:if>
            </div>
        </nav>
    </form>
    <tiles:insertAttribute name="body"/>
    <!-- Footer : 다국어 설정 -->
    <div class="mt-5">
        <div class="p-5 text-end">
            <span class="bg-white py-2 px-3 border-5 pointer" style="border: 1px solid #eeeeee;" onclick="multiLangModal()">
                <c:choose>
                    <c:when test="${sessionScope.locale == 'ko'}">
                        <spring:message code="main.lang.ko" />
                    </c:when>
                    <c:when test="${sessionScope.locale == 'en'}">
                        <spring:message code="main.lang.en" />
                    </c:when>
                    <c:otherwise>
                        <spring:message code="main.lang.ko" />
                    </c:otherwise>
                </c:choose>
                &nbsp;<i class="fa fa-chevron-circle-down"></i>
            </span>
        </div>
    </div>
</body>
</html>
<!-- Toast -->
<div class="toast-container toast-custom position-fixed p-3">
    <div id="base-toast" class="toast" data-bs-delay="1300" role="alert" aria-atomic="true">
        <div class="toast-body text-center"></div>
    </div>
</div>




























