<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">

$(document).ready( function() {
    // 코멘트 글자 수 세기
    const commentArea = document.querySelector('#commentArea');
    let textCount = document.querySelector('#textCount');

    commentArea.addEventListener('keyup', function () {
        const curLength = commentArea.value.length;
        textCount.textContent = curLength;
    });
});

/*--------------------------------------------------------
| 코멘트 작성/수정
 --------------------------------------------------------*/
function fn_commentPost() {
    const textCountValue = parseInt(document.querySelector('#textCount').textContent, 10); // 글자 수 가져오기
    if(textCountValue <= 0){
        return;
    }
    fn_ajaxFormSubmit("commentModalFrm", "<c:url value='/comment/commentPostAjax'/>", fn_commentCallback);
}

function fn_commentCallback(data) {
    if (data.ok) {
        modal.closeModalWithToast(data.message);
        fn_commentListAjax(); // 코멘트 리스트 조회
        fn_myCommentAjax(); // 내 코멘트 조회
    } else {
        fn_showToastMessage(data.message);
    }
}

</script>

<form id="commentModalFrm" name="commentModalFrm">
<input type="hidden" name="commentId" value="<c:out value='${comment.commentId}'/>"/>
<input type="hidden" name="movieId" value="<c:out value='${ReviewVO.movieId}'/>"/>
<input type="hidden" name="reviewId" value="<c:out value='${ReviewVO.reviewId}'/>"/>
    <div class="container">
        <div class="modal-header d-flex justify-content-between w-100">
            <div>
                <c:if test="${empty comment.commentId}">
                    <h5 class="modal-title fw-bold"><spring:message code="button.comment.insert"/></h5>
                </c:if>
                <c:if test="${not empty comment.commentId}">
                    <h5 class="modal-title fw-bold"><spring:message code="button.comment.update"/></h5>
                </c:if>
            </div>
            <button type="button" class="btn-close" onclick="modal.closeModal();"></button>
        </div>
        <div class="modal-body">
            <div class="container">
                <div class="d-flex flex-column">
                    <div>
                        <textarea class="form-control" id="commentArea" name="commentContent" style="overflow: hidden; border: none; height: 150px;"
                            placeholder="<spring:message code='movie.comment.insert'/>">${comment.commentContent}</textarea>
                        <div class="text-end">
                            <c:if test="${empty commentText or commentText == 0}">
                                <div><span id="textCount">0</span>/1000</div>
                            </c:if>
                            <c:if test="${commentText != 0}">
                                <div><span id="textCount">${commentText}</span>/1000</div>
                            </c:if>
                        </div>
                        <div class="d-flex justify-content-end mt-4 mb-0">
                            <!-- 코멘트 신규 작성 -->
                            <c:if test="${empty comment.commentId}">
                                <input type="hidden" name="postType" value="I"/>
                            </c:if>
                            <!-- 코멘트 수정 -->
                            <c:if test="${not empty comment.commentId}">
                                <input type="hidden" name="postType" value="U"/>
                            </c:if>
                            <a class="btn btn-primary float-right" onclick="fn_commentPost();"><spring:message code="button.post"/></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>