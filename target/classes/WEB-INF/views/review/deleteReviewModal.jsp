<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">

/*--------------------------------------------------------
| 리뷰 삭제
 --------------------------------------------------------*/
function fn_deleteReviewAjax() {
    fn_ajaxFormSubmit("reviewDelFrm", "<c:url value='/review/deleteReviewAjax'/>", fn_reviewDelCallback);
}

function fn_reviewDelCallback(data) {
    if (data.ok) {
        modal.closeModalWithToast(data.message);
        fn_myReviewAjax(); // 리뷰 조회
        fn_reviewListAjax(); // 리뷰 리스트 조회
    } else {
        fn_showToastMessage(data.message);
    }
}

</script>

<form id="reviewDelFrm" name="reviewDelFrm">
<input type="hidden" name="reviewId" value="${ReviewVO.reviewId}">
<div class="modal-header justify-content-end">
    <button class="btn-close text-end" type="button" onclick="modal.closeModal();"></button>
</div>
<div class="modal-body text-center">
    <spring:message code="movie.review.delete"/>
</div>
<div class="modal-footer">
    <button class="btn btn-sm btn-primary me-2" type="button" onclick="fn_deleteReviewAjax();"></i>&nbsp;<spring:message code="button.conf"/></button>
    <button class="btn btn-sm btn-danger me-2" type="button" onclick="modal.closeModal();"></i>&nbsp;<spring:message code="button.close"/></button>
</div>
</form>