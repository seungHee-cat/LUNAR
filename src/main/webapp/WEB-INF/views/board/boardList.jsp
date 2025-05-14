<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">

$(document).ready( function() {
    fn_boardListAjax();
});

/*--------------------------------------------------------
| 게시글 리스트 조회
 --------------------------------------------------------*/
function fn_boardListAjax(){
    fn_ajaxRoadDiv("<c:url value='/board/boardListAjax'/>", null, "boardListDiv");
}

/*--------------------------------------------------------
| 게시글 작성/수정 페이지 조회
 --------------------------------------------------------*/
function fn_boardPost() {
    location.href = "<c:url value='/board/boardPost'/>";
}

</script>

<form id="boardListFrm" name="boardListFrm">
<div class="container-xl pt-5 p-3">
    <div class="d-flex justify-content-between mt-5">
        <div class="mt-3 ms-3">
            <h4 class="fw-bold">공지사항</h4>
        </div>
        <c:if test="${loginSession.roleCode == 'ROLE_ADMIN'}">
            <div class="mt-3">
                <button type="button" onclick="fn_boardPost();" class="btn btn-outline-secondary justify-content-center">
                    <spring:message code="button.boardPost"/>
                </button>
            </div>
        </c:if>
    </div>
    <div id="boardListDiv"></div>
</div>
</form>
