<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="project.kr.sys.login.entity.LoginSession" %>

<script type="text/javascript">

$(document).ready( function() {

});

</script>

<div class="mx-auto py-3" style="width: 1240px;">
    <c:if test="${not empty commentList}">
        <c:forEach var="comment" items="${commentList}">
            <input type="hidden" name="commentId" value="<c:out value='${comment.commentId}'/>"/>
            <input type="hidden" name="reviewId" value="<c:out value='${comment.reviewId}'/>"/>
            <input type="hidden" name="movieId" value="<c:out value='${comment.movieId}'/>"/>
            <!-- 코멘트 리스트 -->
            <div class="d-flex align-items-center">
                <c:if test="${comment.usrImg != null && not empty comment.usrImg}">
                    <img class="pointer" style="width: 35px; height: 35px; border-radius: 50%"
                        src="/file/images/${comment.usrImg }" onclick="fn_usrContents('${comment.encodedId}');">
                </c:if>
                <c:if test="${comment.usrImg == null || empty comment.usrImg}">
                    <div class="text-center pointer" onclick="fn_usrContents('${comment.encodedId}');">
                        <i style="font-size: 1.6rem;" class="fa fa-user-circle"></i>
                    </div>
                </c:if>
                <div class="fw-bold px-2 pointer" onclick="fn_usrContents('${comment.encodedId}');">${comment.usrNm}</div>
            </div>
            <div class="py-3">${comment.commentContent}</div>
            <div class="d-flex justify-content-between pb-3">
                <div class="text-end w-100 pb-1" style="color: gray; border-bottom: 1px solid #f0f0f0;">${comment.commentTime}</div>
            </div>
        </c:forEach>
    </c:if>
    <c:if test="${empty commentList}">
        <div class="ms-3 me-4 py-3">
            <div class="text-center py-2" style="background-color: #f0f0f0;"><spring:message code="movie.comment.none"/></div>
        </div>
    </c:if>
</div>
