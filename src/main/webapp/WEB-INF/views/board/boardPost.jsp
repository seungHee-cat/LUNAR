<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css"
    integrity="sha256-IKhQVXDfwbVELwiR0ke6dX+pJt0RSmWky3WB2pNx9Hg=" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"
    integrity="sha256-5slxYrL5Ct3mhMAp/dgnb5JSnTYMtkr4dHby34N10qw=" crossorigin="anonymous"></script>

    <!-- language pack -->
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/lang/summernote-ko-KR.min.js"
    integrity="sha256-y2bkXLA0VKwUx5hwbBKnaboRThcu7YOFyuYarJbCnoQ=" crossorigin="anonymous"></script>
</head>
<script type="text/javascript">

$(document).ready( function() {

    $('#summernote').summernote({
        focus: true,
        height: 480,
        lang: "ko-KR",
        placeholder: "<spring:message code='board.content.info'/>",
        disableResizeEditor: true,
        // 이미지 업로드 시 콜백함수
        callbacks: {
            onImageUpload: function(files){
                editorImageUpload(files[0], this);
            }
        },
    });

});

/*--------------------------------------------------------
| summernote 이미지 업로드
 --------------------------------------------------------*/
function editorImageUpload(file, editor){
    data = new FormData();
    data.append("file", file);

    $.ajax({
        data: data,
        type: "POST",
        url: "/editorImageUpload",
        contentType: false,
        processData: false,
        success: function(data){
            $(editor).summernote('insertImage', data.url);
        }
    });
}

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
    <div class="d-flex mt-5 flex-column align-items-center">
        <!-- 게시글 등록 -->
        <c:if test="${empty board.boardId}">
        <!-- 공지사항 태그 -->
        <div class="d-flex flex-column w-75">
            <div class="position-relative d-flex flex-column w-75 mt-5">
                <div class="position-absolute mt-5 pt-5" style="top: -100px;">
                    <select id="schType" name="schType" style="border: none; width: 100px; height: 34px;">
                        <option value="notice" selected ><spring:message code="select.option.notice"/></option>
                        <option value="ui" ><spring:message code="select.option.ui"/></option>
                        <option value="func"><spring:message code="select.option.func"/></option>
                    </select>
                </div>
            </div>
            <div class="d-flex justify-content-center align-items-center ms-5">
                <div class="ms-5" style="width: 40px;"><spring:message code="common.board.title"/></div>
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
        <!-- 공지사항 태그 -->
        <div class="position-relative d-flex flex-column w-75 mt-5">
            <div class="position-absolute mt-5 pt-5" style="top: -100px;">
                <select id="schType" name="schType" style="border: none; width: 100px; height: 34px;">
                    <option value="notice" <c:if test="${board.tagNm eq '공지사항'}">selected</c:if>>
                        <spring:message code="select.option.notice"/>
                    </option>
                    <option value="ui" <c:if test="${board.tagNm eq 'UI개선'}">selected</c:if>>
                        <spring:message code="select.option.ui"/>
                     </option>
                    <option value="func" <c:if test="${board.tagNm eq '기능개선'}">selected</c:if>>
                        <spring:message code="select.option.func"/>
                    </option>
                </select>
            </div>
            <div class="d-flex justify-content-center align-items-center ms-5">
                <div class="ms-5" style="width: 40px;"><spring:message code="common.board.title"/></div>
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
