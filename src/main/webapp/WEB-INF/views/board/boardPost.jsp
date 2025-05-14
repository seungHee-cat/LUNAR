<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">

$(document).ready( function() {

    $('#summernote').summernote({
        focus: true,
        height: 350,
        lang: "ko-KR",
        placeholder: "내용을 입력하세요.",
        disableResizeEditor: true,
        // 이미지 업로드 시 콜백함수
        callbacks: {

        }
    });

});

/*--------------------------------------------------------
| 게시글 작성/수정
 --------------------------------------------------------*/
function fn_boardPostAjax(){
    const content = $('#summernote').summernote('code');
    $('#content').val(content);

    fn_ajaxFormSubmit("boardPostFrm", "<c:url value='/board/boardPostAjax'/>", fn_listPostCallback);
}

function fn_listPostCallback(data) {
    if(data.ok){
        fn_showToastMessage(data.message);
        setTimeout(function () {
            location.href="/board";
        }, 1500);
    }else{
        fn_showToastMessage(data.message);
    }
}

</script>

<form id="boardPostFrm" name="boardPostFrm">
<input type="hidden" id="content" name="content">
<input type="hidden" name="boardId" value="${board.boardId}">
<div class="container-xl p-3">
    <div class="d-flex flex-column align-items-center pt-5">
        <!-- 게시글 등록 -->
        <c:if test="${empty board.boardId}">
        <div class="d-flex flex-column w-75 mt-5">
            <div class="d-flex align-items-center ms-3">
                <div style="width: 40px;">제목</div>
                <input type="hidden" name="postType" value="I"/>
                <div class="w-75">
                    <input type="text" class="form-control" name="title"></input>
                </div>
            </div>
            <div class="post-form mt-2 w-100">
                <textarea id="summernote"></textarea>
            </div>
        </div>
        </c:if>
        <!-- 게시글 수정 -->
        <c:if test="${not empty board.boardId}">
        <div class="d-flex flex-column w-75 mt-5">
            <div class="d-flex align-items-center ms-3">
                <div style="width: 40px;">제목</div>
                <input type="hidden" name="postType" value="U"/>
                <div class="w-75">
                    <input type="text" class="form-control" name="title" value="${board.title}"></input>
                </div>
            </div>
            <div class="post-form mt-2 w-100">
                <textarea id="summernote">${board.content}</textarea>
            </div>
        </div>
        </c:if>
    </div>
    <div class="my-3 mx-5 text-end">
        <button class="btn btn-primary" onclick="fn_boardPostAjax();" type="button">
            <spring:message code="button.save"/>
        </button>
    </div>
</div>
</form>
