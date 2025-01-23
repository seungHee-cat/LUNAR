<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">

/*--------------------------------------------------------
| 리뷰 삭제 모달
 --------------------------------------------------------*/
function deleteReviewModal(reviewId) {
    let formData = new FormData();
    modal.openModal("<c:url value='/review/deleteReviewModal'/>" + "?reviewId=" + reviewId, formData, "small");
}

</script>

<div class="card mx-3">
    <c:if test="${not empty loginSession}">
        <c:if test="${not empty review.reviewId}">
            <div class="my-review flex-start p-4">
                <div class="card-text text-pre-wrap" style="width: 1000px; -webkit-line-clamp: 4;">${review.reviewContent}</div>
                <div class="d-flex justify-content-evenly" style="width: 200px;">
                    <button type="button" onclick="reviewModal();"><spring:message code="button.update"/></button>
                    <button type="button" onclick="deleteReviewModal('${review.reviewId}');"><spring:message code="button.delete"/></button>
                </div>
            </div>
        </c:if>
        <c:if test="${empty review.reviewId}">
            <div class="my-review justify-content-between p-3">
                <spring:message code="movie.review.none"/>
                <button type="button" onclick="reviewModal();">
                    <spring:message code="button.review.insert"/>
                </button>
            </div>
        </c:if>
    </c:if>
    <c:if test="${empty loginSession}">
        <div class="my-review justify-content-between p-3">
            <spring:message code="movie.review.none"/>
            <button type="button" onclick="loginModal();">
                <spring:message code="button.review.insert"/>
            </button>
        </div>
    </c:if>
</div>