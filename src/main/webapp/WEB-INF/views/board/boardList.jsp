<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">

$(document).ready( function() {

});

/*--------------------------------------------------------
| 게시글 작성 화면 조회
 --------------------------------------------------------*/
function fn_boardPost() {
    location.href = "<c:url value='/board/post'/>";
}

</script>

<form id="boardListFrm" name="boardListFrm">
<div class="container-xl pt-5 p-3">
    <div class="d-flex justify-content-between mt-5">
        <div class="ms-3">
            <h4 class="fw-bold">공지사항</h4>
        </div>
        <div class="">
            <button type="button" onclick="fn_boardPost();" class="btn btn-outline-secondary justify-content-center">
                <spring:message code="button.boardPost"/>
            </button>
        </div>
    </div>
    <table class="w-100 text-center bg-white">
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>날짜</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td>예시 게시글 제목입니다</td>
                <td>2025-05-12</td>
                <td>123</td>
            </tr>
            <tr>
                <td>2</td>
                <td>두 번째 글 제목</td>
                <td>2025-05-11</td>
                <td>98</td>
            </tr>
        </tbody>
    </table>
</div>
</form>
