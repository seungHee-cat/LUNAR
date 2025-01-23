<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">

/*--------------------------------------------------------
| 코멘트 삭제
 --------------------------------------------------------*/
function fn_deleteCommentAjax() {
    fn_ajaxFormSubmit("commentDelFrm", "<c:url value='/comment/deleteCommentAjax'/>", fn_commentDelCallback);
}

function fn_commentDelCallback(data) {
    if (data.ok) {
        modal.closeModalWithToast(data.message);
        fn_commentListAjax(); // 코멘트 리스트 조회
        fn_myCommentAjax(); // 내 코멘트 조회
    } else {
        fn_showToastMessage(data.message);
    }
}

</script>

<form id="commentDelFrm" name="commentDelFrm">
<input type="hidden" name="commentId" value="${CommentVO.commentId}">
<div class="modal-header justify-content-end">
    <button class="btn-close text-end" type="button" onclick="modal.closeModal();"></button>
</div>
<div class="modal-body text-center">
    <spring:message code="movie.comment.delete"/>
</div>
<div class="modal-footer">
    <button class="btn btn-sm btn-primary me-2" type="button" onclick="fn_deleteCommentAjax();"></i>&nbsp;<spring:message code="button.conf"/></button>
    <button class="btn btn-sm btn-danger me-2" type="button" onclick="modal.closeModal();"></i>&nbsp;<spring:message code="button.close"/></button>
</div>
</form>