<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">

/*--------------------------------------------------------
| 게시글 삭제
 --------------------------------------------------------*/
function fn_deleteBoardAjax() {
    fn_ajaxFormSubmit("boardDelFrm", "<c:url value='/board/deleteBoardAjax'/>", fn_boardDelCallback);
}

function fn_boardDelCallback(data) {
    if(data.ok){
        modal.closeModalWithToast(data.message);
        setTimeout(function () {
            location.href="/board";
        }, 1500);
    }else{
        fn_showToastMessage(data.message);
    }
}

</script>

<form id="boardDelFrm" name="boardDelFrm">
<input type="hidden" name="boardId" value="${BoardVO.boardId}">
<div class="modal-header justify-content-end">
    <button class="btn-close text-end" type="button" onclick="modal.closeModal();"></button>
</div>
<div class="modal-body text-center">
    <spring:message code="board.delete.info"/>
</div>
<div class="modal-footer">
    <button class="btn btn-sm btn-primary me-2" type="button" onclick="fn_deleteBoardAjax();"></i>&nbsp;<spring:message code="button.conf"/></button>
    <button class="btn btn-sm btn-danger me-2" type="button" onclick="modal.closeModal();"></i>&nbsp;<spring:message code="button.close"/></button>
</div>
</form>