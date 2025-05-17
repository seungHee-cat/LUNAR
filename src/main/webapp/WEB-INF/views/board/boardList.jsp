<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">

$(document).ready( function() {
    fn_boardListInitAjax();
});

/*--------------------------------------------------------
| 게시글 리스트 초기화
 --------------------------------------------------------*/
function fn_boardListInitAjax(){
    fn_ajaxRoadDiv("<c:url value='/board/boardListInitAjax'/>", null, "boardListDiv");
}

/*--------------------------------------------------------
| 게시글 리스트 조회
 --------------------------------------------------------*/
function fn_boardListAjax(pageNum){
    let schType = document.getElementById("schType").value;
    let params = "schType=" + schType + "&page=" + pageNum;
    fn_ajaxRoadDiv("<c:url value='/board/boardListAjax'/>", params, "boardListDiv");
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
    <!-- 공지사항 필터/검색 -->
    <div class="d-flex justify-content-end mt-5 pt-3">
        <select id="schType" name="schType" onchange="fn_boardListAjax(1)" style="border: none; width: 100px; height: 34px;">
            <option value="" selected><spring:message code="select.option.all"/></option>
            <option value="notice" ><spring:message code="select.option.notice"/></option>
            <option value="ui" ><spring:message code="select.option.ui"/></option>
            <option value="func"><spring:message code="select.option.func"/></option>
        </select>
    </div>
    <div class="d-flex mt-3 justify-content-between align-items-center">
        <div class="ms-3">
            <h4 class="fw-bold"><spring:message code="common.menu.board"/></h4>
        </div>
        <c:if test="${loginSession.roleCode == 'ROLE_ADMIN'}">
            <div class="">
                <button type="button" onclick="fn_boardPost();" class="btn btn-outline-secondary justify-content-center">
                    <spring:message code="button.boardPost"/>
                </button>
            </div>
        </c:if>
    </div>
    <div id="boardListDiv"></div>
</div>
</form>
