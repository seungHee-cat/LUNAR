<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="project.kr.sys.login.entity.LoginSession" %>

<script type="text/javascript">

/* 캘린더 데이터 전달 */
window.initRatingList = function() {
    return ${ratingList};
};

/*--------------------------------------------------------
| 캘린더 영화 리스트 조회
 --------------------------------------------------------*/
function fn_calenderRatingList(movieId, encodedId, ratingMonth){
    let params = "movieId=" + movieId + "&encodedId=" + encodedId + "&ratingMonth=" + ratingMonth;
    location.href="/sys/usr/usrRatingList?"+params;
}

</script>
<script type="text/javascript" src="<c:url value='/js/calender.js'/>"></script>
<div class="card mx-5 my-3 d-flex justify-content-center bg-white">
    <div class="calender_wrap">
        <div class="d-flex pt-5">
            <div class="month_btns">
                <button class="go-prev" onclick="prevMonth();">&lt;</button>
                <div class="curDate">
                    <div class="curYear"></div>
                    <div class="curMonth"></div>
                </div>
                <button class="go-next" onclick="nextMonth();">&gt;</button>
            </div>
        </div>
        <div class="text-end" style="padding-right: 120px;">
            <button type="button" class="today" onclick="goToday();"><spring:message code="button.today"/></button>
        </div>
        <div class="calenderBody">
            <ul id="monthList">
                <li>Jan</li>
                <li>Feb</li>
                <li>Mar</li>
                <li>Apr</li>
                <li>May</li>
                <li>Jun</li>
                <li>Jul</li>
                <li>Aug</li>
                <li>Sep</li>
                <li>Oct</li>
                <li>Nov</li>
                <li>Dec</li>
            </ul>
            <div id="calender"></div>
        </div>
    </div>
</div>
