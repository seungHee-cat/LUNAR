<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="project.kr.sys.login.entity.LoginSession" %>

<script type="text/javascript">

</script>

<div class="d-flex flex-wrap justify-content-around bg-white px-5 py-2">
     <c:forEach var="review" items="${usrReviewList}">
        <div class="d-flex align-items-center px-3 my-2 border-5"
            style="background-color: #f9f9f9; width: 350px; height: auto;">
            <div class="flex-shrink-0 pointer">
                <img src="${review.posterPath}" onclick="fn_movieDetail(${review.movieId});" style="width: 130px; height: auto; ">
            </div>
            <div class="d-flex flex-column p-3 pointer" onclick="fn_reviewDetail('${review.reviewId}');">
                <div class="fw-bold pt-4" style="font-size: 1.2rem;">${review.title}</div>
                <div>${review.releaseYear}</div>
                <div class="card-text text-muted py-2" style="height: 100px; -webkit-line-clamp: 4; word-break: break-word;">
                    ${review.reviewContent}
                </div>
                <div class="py-3">
                    <div><i class="fa fa-commenting"></i><span>&nbsp;${review.commentCnt}</span></div>
                </div>
            </div>
        </div>
     </c:forEach>
</div>