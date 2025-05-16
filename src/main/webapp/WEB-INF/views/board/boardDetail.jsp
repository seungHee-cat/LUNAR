<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">

$(document).ready( function() {

});

/*--------------------------------------------------------
| 게시판 리스트 조회
 --------------------------------------------------------*/
function fn_boardList(){
    location.href = "/board";
}

/*--------------------------------------------------------
| 게시글 작성/수정 화면 조회
 --------------------------------------------------------*/
function fn_boardPost(){
    let boardId = $("input[name=boardId]").val();
    location.href = "<c:url value='/board/boardPost'/>" + "?boardId=" + boardId;
}

/*--------------------------------------------------------
| 게시글 삭제 모달
 --------------------------------------------------------*/
function fn_deleteBoardModal() {
    let formData = new FormData();
    formData.append("boardId", $("#boardDetailFrm input[name=boardId]").val());

    modal.openModal("<c:url value='/board/deleteBoardModal'/>", formData, "small");
}

</script>

<form id="boardDetailFrm" name="boardDetailFrm">
<input type="hidden" name="boardId" value="<c:out value='${board.boardId}'/>">
<div class="container-xl pt-5 p-3">
    <div class="d-flex flex-column mt-5">
        <div class="d-flex mt-3 ms-3">
            <div class="me-4" style="font-size: 1.2rem;">제목</div>
            <div style="font-size: 1.2rem;">${board.title}</div>
        </div>
        <div class="bg-white p-4 mt-3 mb-3 border rounded shadow-sm" style="height: 500px; overflow-y: auto;">
            <div>${board.content}</div>
        </div>
    </div>
    <c:if test="${loginSession.roleCode == 'ROLE_ADMIN'}">
        <div class="d-flex justify-content-between mt-3">
            <div>
                <!-- 게시글 수정 -->
                <button type="button" onclick="fn_boardPost();" class="btn btn-outline-info justify-content-center">
                    <spring:message code="button.update"/>
                </button>
                <!-- 게시글 삭제 모달 -->
                <button type="button" onclick="fn_deleteBoardModal();" class="btn btn-outline-warning justify-content-center">
                    <spring:message code="button.delete"/>
                </button>
            </div>
            <div>
                <button type="button" onclick="fn_boardList();" class="btn btn-outline-success">
                    <spring:message code="button.list"/>
                </button>
            </div>
        </div>
    </c:if>
    <c:if test="${loginSession.roleCode != 'ROLE_ADMIN'}">
        <div class="text-end">
            <button type="button" onclick="fn_boardList();" class="btn btn-outline-success">
                <spring:message code="button.list"/>
            </button>
        </div>
    </c:if>
</div>
</form>
