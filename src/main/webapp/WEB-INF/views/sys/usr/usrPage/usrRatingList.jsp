<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="project.kr.sys.login.entity.LoginSession" %>

<script type="text/javascript">

$(document).ready( function() {
    let ratingDay = ${rating.ratingDay != null ? rating.ratingDay : 'null'};

    if (ratingDay != null) {
        let targetElement = $("#rating-" + ratingDay);
        targetElement.css("color", "#ff5557");

        let elementPosition = targetElement.get(0).getBoundingClientRect().top + window.pageYOffset;

        let offset = 60;
        window.scrollTo({
            top: elementPosition - offset,
            behavior: "smooth"
        });
    }
});

</script>

<div class="container-xl mb-5">
    <div class="mx-5 py-5">
        <div class="mx-5 py-5">
            <c:if test="${rating.ratingMonth != null}">
                <h4 class="fw-bold">
                    ${rating.ratingMonth}<spring:message code="rating.text.month"/>
                </h4>
            </c:if>
            <div class="d-flex flex-column bg-white">
                <c:set var="prevDay" value="" />
                <c:set var="prevMonth" value="" />
                <c:forEach var="ratingList" items="${ratingList}">
                    <c:set var="formattedDate" value="" />
                    <!-- 전체 평점 조회일 때 -->
                    <c:if test="${empty rating}">
                        <c:if test="${fn:substring(ratingList.wrtTime, 5, 7) != fn:substring(prevMonth, 5, 7)}">
                            <div class="fw-bold text-center" style="width: 75px; font-size: 1.6rem;">
                                <fmt:formatDate value='${ratingList.wrtTime}' pattern='M' /><spring:message code="rating.text.month"/>
                                <c:set var="prevMonth" value="${ratingList.wrtTime}" />
                            </div>
                        </c:if>
                    </c:if>
                    <div class="d-flex pt-3 pb-4">
                        <div id="rating-<fmt:formatDate value='${ratingList.wrtTime}' pattern='d' />" class="fw-bold text-center"
                            style="color: gray; width: 75px; font-size: 1.6rem;">
                            <c:if test="${ratingList.wrtTime != prevDay}">
                                <fmt:formatDate value='${ratingList.wrtTime}' pattern='d' />
                                <c:set var="prevDay" value="${ratingList.wrtTime}" />
                            </c:if>
                        </div>
                        <div>
                            <img src="${ratingList.posterPath}" class="border-5 pointer" style="width: 90px; height: 120px;"
                                onclick="fn_movieDetail(${ratingList.movieId})">
                            <div class="py-1">${ratingList.title}</div>
                            <div style="color: #ffd055;"><spring:message code="rating.text.confirm"/>&nbsp;★&nbsp;${ratingList.rating}.0&nbsp;</div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>


