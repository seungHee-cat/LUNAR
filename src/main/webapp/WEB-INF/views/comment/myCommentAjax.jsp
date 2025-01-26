<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="project.kr.sys.login.entity.LoginSession" %>

<script type="text/javascript">

$(document).ready( function() {
    $('#myCommentBtn').click(function(event) {
        const options = $('#commentOptions')[0];
        options.style.display = options.style.display === 'none' ? 'block' : 'none';
    });
});

/*--------------------------------------------------------
| 코멘트 모달
 --------------------------------------------------------*/
function commentModal() {
    let formData = new FormData();
    formData.append("movieId", $("#commentFrm input[name=movieId]").val());
    formData.append("reviewId", $("#commentFrm input[name=reviewId]").val());

    modal.openModal("<c:url value='/comment/commentModal'/>", formData, "medium");
}


/*--------------------------------------------------------
| 코멘트 삭제 모달
 --------------------------------------------------------*/
function fn_deleteCommentModal() {
    let formData = new FormData();
    formData.append("commentId", $("#myCommentFrm input[name=commentId]").val());

    modal.openModal("<c:url value='/comment/deleteCommentModal'/>", formData, "small");
}

</script>

<form id="myCommentFrm" name="myCommentFrm">
<input type="hidden" name="commentId" value="<c:out value='${myComment.commentId}'/>"/>
<c:if test="${myComment != null && not empty myComment}">
    <div class="p-3">
        <div style="background-color: #f9f9f9; border-radius: 15px;">
            <div class="p-2">
                <!-- 내 코멘트 -->
                <div class="fw-bold p-2" style="font-size: 1.15rem;">
                    <i class="fa fa-thumb-tack"></i>&nbsp;내 코멘트</div>
                    <div class="d-flex align-items-center p-2">
                        <c:if test="${myComment.usrImg != null && not empty myComment.usrImg}">
                            <img class="pointer" style="width: 35px; height: 35px; border-radius: 50%"
                                src="/file/images/${myComment.usrImg }" onclick="fn_usrContents('${myComment.encodedId}');">
                        </c:if>
                        <c:if test="${myComment.usrImg == null || empty myComment.usrImg}">
                            <div class="text-center pointer" onclick="fn_usrContents('${myComment.encodedId}');">
                                <i style="font-size: 1.6rem;" class="fa fa-user-circle"></i>
                            </div>
                        </c:if>
                        <div class="fw-bold px-2 pointer" onclick="fn_usrContents('${myComment.encodedId}');">${myComment.usrNm}</div>
                    </div>
                </div>
                <div class="d-flex flex-column p-3">
                    <div>${myComment.commentContent}</div>
                    <div style="position: relative;">
                        <div id="myCommentBtn" class="text-end fw-bold pointer" style="font-size: 1.2rem;">…</div>
                        <!-- 코멘트 수정/삭제 메뉴 -->
                        <div id="commentOptions" class="p-1 bg-white shadow-sm border-5"
                            style="display: none; position: absolute; bottom: 30px; right: -10px; z-index: 10; width: 150px;">
                            <div id="updateComment" onclick="commentModal();" class="pointer p-3"><spring:message code="button.update"/></div>
                            <div id="deleteComment" onclick="fn_deleteCommentModal();" class="pointer p-3"><spring:message code="button.delete"/></div>
                        </div>
                    </div>
                </div>
                <div class="p-2">
                    <div class="text-end" style="color: gray;">${myComment.commentTime}</div>
                </div>
            </div>
        </div>
    </div>
</c:if>
<c:if test="${not empty loginSession && myComment == null && empty myComment}">
    <div class="w-100 comment-div pointer" style="border-top: 1px solid lightgray; border-bottom: 1px solid lightgray;"
        onclick="commentModal();">
        <div class="d-flex justify-content-center py-2 w-100">
            <i class="bi bi-chat-fill"></i>
            <span><spring:message code="button.comment.insert"/></span>
        </div>
    </div>
</c:if>
</form>
