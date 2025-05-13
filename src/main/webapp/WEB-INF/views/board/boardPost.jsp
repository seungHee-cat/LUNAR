<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">

$(document).ready( function() {

    $('#summernote').summernote({
        focus: true,
        height: 300,
        lang: "ko-KR",
        placeholder: "내용을 입력하세요.",
        disableResizeEditor: true,
        // 이미지 업로드 시 콜백함수
        callbacks: {

        }
    });

});

/*--------------------------------------------------------
| 게시판 글 작성
 --------------------------------------------------------*/
function fn_boardPostAjax(){
    const content = $('#summernote').summernote('code');
    $('#content').val(content);

    fn_ajaxFormSubmit("boardPostFrm", "<c:url value='/board/boardPostAjax'/>", fn_listPostCallback);
}

function fn_listPostCallback(data) {
    if(data.ok){
        fn_showToastMessage(data.message);
    }else{
        fn_showToastMessage(data.message);
    }
}

</script>

<form id="boardPostFrm" name="boardPostFrm">
<input type="hidden" id="content" name="content">
<div class="container-xl p-3">
    <div class="d-flex flex-column p-5">
        <div class="d-flex align-items-center mt-5">
            <div style="width: 40px;">제목</div>
            <div class="w-50">
                <input type="text" class="form-control" name="title"></input>
            </div>
        </div>
        <div class="post-form mt-2 w-75">
        	<textarea id="summernote"></textarea>
        </div>
        <div class="my-4 text-end">
            <button class="btn btn-primary" onclick="fn_boardPostAjax();" type="button">
                <spring:message code="button.save"/>
            </button>
        </div>
    </div>
</div>
</form>
