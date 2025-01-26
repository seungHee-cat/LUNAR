<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">

/*--------------------------------------------------------
| 모든 리뷰 리스트
 --------------------------------------------------------*/
function fn_allReviewList(){
    let movieId = $("#reviewFrm input[name=movieId]").val();
    location.href = "<c:url value='/review/reviewListAjax'/>" + "?movieId=" + movieId;
}

</script>

<div class="d-flex flex-column px-5 py-3">
    <c:if test="${not empty reviewList}">
        <div class="mx-4 py-3 px-3">
            <div class="d-flex justify-content-between fw-bold" style="font-size: 1.3rem;">
                <c:choose>
                    <c:when test="${sessionScope.locale == 'ko'}">
                        <c:if test="${reviewList.size() < 10}">
                            <spring:message code="button.review"/>&nbsp;${reviewList.size()}
                        </c:if>
                        <c:if test="${reviewList.size() > 10}">
                            <spring:message code="button.review"/>&nbsp;${reviewSize}+
                        </c:if>
                    </c:when>
                    <c:when test="${sessionScope.locale == 'en'}">
                        <c:if test="${reviewList.size() < 10}">
                            ${reviewList.size()}&nbsp;<spring:message code="button.review"/>
                        </c:if>
                        <c:if test="${reviewList.size() > 10}">
                            ${reviewSize}+&nbsp;<spring:message code="button.review"/>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${reviewList.size() < 10}">
                            <spring:message code="button.review"/>&nbsp;${reviewList.size()}
                        </c:if>
                        <c:if test="${reviewList.size() > 10}">
                            <spring:message code="button.review"/>&nbsp;${reviewSize}+
                        </c:if>
                    </c:otherwise>
                </c:choose>
                <button type="button" onclick="fn_allReviewList();" class="btn fw-bold p-0 border-0 bg-transparent fs-6">
                    <spring:message code="button.more"/>
                </button>
            </div>
        </div>
        <div class="mx-3">
            <form id="reviewFrm" class="w-100 d-flex">
            <c:forEach var="review" items="${reviewList}">
                <input type="hidden" name="reviewId" value="<c:out value='${review.reviewId}'/>"/>
                <input type="hidden" name="movieId" value="<c:out value='${review.movieId}'/>"/>
                <input type="hidden" name="usrId" value="<c:out value='${review.usrId}'/>"/>
                <div class="card" style="width: 320px;">
                    <div class="my-review bg-white">
                        <div class="d-flex flex-column w-100 justify-content-between p-3">
                            <div class="d-flex flex-column pt-2">
                                <div class="d-flex justify-content-between align-items-center pb-2" style="border-bottom: 1px solid lightgray;">
                                    <div class="d-flex align-items-center">
                                        <c:if test="${review.usrImg != null && not empty review.usrImg}">
                                            <img class="pointer" style="width: 35px; height: 35px; border-radius: 50%"
                                                src="/file/images/${review.usrImg }" onclick="fn_usrContents('${review.encodedId}');">
                                        </c:if>
                                        <c:if test="${review.usrImg == null || empty review.usrImg}">
                                            <div class="text-center pointer" onclick="fn_usrContents('${review.encodedId}');">
                                                <i style="font-size: 1.6rem;" class="fa fa-user-circle"></i>
                                            </div>
                                        </c:if>
                                        <div class="fw-bold px-2 pointer" onclick="fn_usrContents('${review.encodedId}');">${review.usrNm}</div>
                                    </div>
                                    <div class="px-1 border-5" style="background-color: #f5f5f5;">
                                        <i class="fa fa-star"></i>&nbsp;
                                        <span>${review.rating}.0</span>
                                    </div>
                                </div>
                                <div class="py-3 px-2 card-text text-pre-wrap pointer" style="-webkit-line-clamp: 7; height: 189px;" onclick="fn_reviewDetail('${review.reviewId}');">${review.reviewContent}</div>
                            </div>
                            <div class="d-flex pt-2">
                                <div><i class="fa fa-commenting"></i><span>&nbsp;${review.commentCnt}</span></div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            </form>
        </div>
    </c:if>
    <c:if test="${empty reviewList}">
        <div class="text-center my-5 py-2" style="background-color: #f0f0f0;"><spring:message code="movie.review.none"/></div>
    </c:if>
</div>
