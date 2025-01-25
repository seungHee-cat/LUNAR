<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="project.kr.sys.login.entity.LoginSession" %>

<script type="text/javascript">

$(document).ready( function() {
    fn_commentListAjax(); // 코멘트 리스트 조회
    fn_myCommentAjax(); // 내 코멘트 조회
});


/*--------------------------------------------------------
| 코멘트 리스트 조회
 --------------------------------------------------------*/
function fn_commentListAjax(){
    let movieId = $("#commentFrm input[name=movieId]").val();
    let reviewId = $("#commentFrm input[name=reviewId]").val();
    let params = "movieId=" + movieId + "&reviewId=" + reviewId;

    fn_ajaxRoadDiv("<c:url value='/comment/commentListAjax'/>", params, "commentListDiv");
}

/*--------------------------------------------------------
| 내 코멘트 조회
 --------------------------------------------------------*/
function fn_myCommentAjax(){
    let movieId = $("#commentFrm input[name=movieId]").val();
    let reviewId = $("#commentFrm input[name=reviewId]").val();
    let params = "movieId=" + movieId + "&reviewId=" + reviewId;

    fn_ajaxRoadDiv("<c:url value='/comment/myCommentAjax'/>", params, "myCommentDiv");
}

</script>

<form id="commentFrm" name="commentFrm">
<input type="hidden" name="movieId" value="<c:out value='${review.movieId}'/>"/>
<input type="hidden" name="reviewId" value="<c:out value='${review.reviewId}'/>"/>
<input type="hidden" name="commentId" value="<c:out value='${comment.commentId}'/>"/>
<div class="container" style="max-width: 1680px;">
    <div class="d-flex row py-5 mx-auto bg-white" style="width: 1440px;">
        <div class="d-flex row justify-content-between px-5 py-4">
            <div class="py-2 fw-bold" style="font-size: 1.3rem;">${review.title}&nbsp;(${review.releaseYear})</div>
            <div class="d-flex col-9 w-100 justify-content-between">
                <div class="d-flex flex-column justify-content-between">
                    <div class="d-flex align-items-center">
                        <c:if test="${review.usrImg != null && not empty review.usrImg}">
                            <img class="pointer" style="width: 35px; height: 35px; border-radius: 50%"
                                src="/img/usr/${review.usrImg }" onclick="fn_usrContents('${review.encodedId}');">
                        </c:if>
                        <c:if test="${review.usrImg == null || empty review.usrImg}">
                            <div class="text-center pointer" onclick="fn_usrContents('${review.encodedId}');">
                                <i style="font-size: 1.6rem;" class="fa fa-user-circle"></i>
                            </div>
                        </c:if>
                        <div class="px-2 fw-bold pointer" onclick="fn_usrContents('${review.encodedId}');">${review.usrNm}&nbsp;</div>
                        <div class="px-1 border-5" style="background-color: #f5f5f5;">
                            <i class="fa fa-star"></i>&nbsp;
                            <span>${review.rating}.0</span>
                        </div>
                    </div>
                    <div class="pt-2" style="color: gray; font-size: 0.9rem;">${review.commentTime}</div>
                    <div class="py-4 pe-3 text-pre-wrap">${review.reviewContent}</div>
                    <c:choose>
                        <c:when test="${sessionScope.locale == 'ko'}">
                            <div><spring:message code="button.comment"/><span>&nbsp;${review.commentCnt}</span></div>
                        </c:when>
                        <c:when test="${sessionScope.locale == 'en'}">
                            <div><span>${review.commentCnt}</span>&nbsp;<spring:message code="button.comment"/></div>
                        </c:when>
                        <c:otherwise>
                            <div><spring:message code="button.comment"/><span>&nbsp;${review.commentCnt}</span></div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="col-3 p-1 border-5 pointer" style="width: 150px; height: 200px; border: 1px solid lightgray;">
                    <img src="${review.posterPath}" class="w-100 h-100" onclick="fn_movieDetail(${review.movieId})">
                </div>
            </div>
        </div>
        <!-- 좋아요, 공유 -->
        <div class="d-flex row justify-content-between">
            <div class="d-flex flex-column px-5">
                <!-- 내 댓글 -->
                <div id="myCommentDiv"></div>
            </div>
        </div>
        <!-- 댓글 리스트 -->
        <div id="commentListDiv"></div>
    </div>
</div>
</form>