<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">

$(document).ready( function() {
    // 리뷰 글자 수 세기
    const reviewContent = document.querySelector('#reviewContent');
    let textCount = document.querySelector('#textCount');

    reviewContent.addEventListener('keyup', function () {
        const curLength = reviewContent.value.length;
        textCount.textContent = curLength;
    });
});

/*--------------------------------------------------------
| 리뷰 작성
 --------------------------------------------------------*/
function fn_reviewPost() {
    const textCountValue = parseInt(document.querySelector('#textCount').textContent, 10); // 글자 수 가져오기
    if(textCountValue <= 0){
        return;
    }
    fn_ajaxFormSubmit("reviewModalFrm", "<c:url value='/review/reviewPostAjax'/>", fn_reviewCallback);
}

function fn_reviewCallback(data) {
    if (data.ok) {
        modal.closeModalWithToast(data.message);
        fn_myReviewAjax(); // 리뷰 조회
        fn_reviewListAjax(); // 리뷰 리스트 조회
    } else {
        fn_showToastMessage(data.message);
    }
}

</script>
<form id="reviewModalFrm" name="reviewModalFrm">
<input type="hidden" name="movieId" value="<c:out value='${MovieVO.movieId}'/>"/>
<input type="hidden" name="reviewId" value="<c:out value='${review.reviewId}'/>"/>
<div class="container">
    <div class="modal-header d-flex justify-content-between w-100">
        <div>
            <div class="modal-title">
                <span style="font-size: 1.2rem;" class="fw-bold">${MovieVO.title}</span><span>&nbsp;(${MovieVO.releaseYear})</span>
            </div>
        </div>
        <button type="button" class="btn-close" onclick="modal.closeModal();"></button>
    </div>
    <div class="modal-body">
        <div class="container">
            <div class="d-flex flex-column">
                <div>
                    <div>
                        <textarea class="form-control" id="reviewContent" name="reviewContent"
                            style="overflow: hidden; height: 150px; border: none;" placeholder="<spring:message code='movie.review.none'/>">${review.reviewContent}</textarea>
                    <div>
                    <div class="text-end">
                        <div><span id="textCount">${reviewText}</span>/4000</div>
                    </div>
                    <div class="d-flex justify-content-end mt-4 mb-0">
                        <!-- 리뷰 신규 작성 -->
                        <c:if test="${empty review.reviewContent}">
                            <input type="hidden" name="postType" value="I"/>
                        </c:if>
                        <!-- 리뷰 수정 -->
                        <c:if test="${not empty review.reviewContent}">
                            <input type="hidden" name="postType" value="U"/>
                        </c:if>
                            <a class="btn btn-primary float-right" onclick="fn_reviewPost();"><spring:message code="button.post"/></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</form>