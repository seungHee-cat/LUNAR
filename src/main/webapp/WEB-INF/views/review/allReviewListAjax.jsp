<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${not empty reviewList}">
    <c:forEach var="review" items="${reviewList}">
        <input type="hidden" name="movieId" value="<c:out value='${review.movieId}'/>"/>
        <div class="card border-0">
            <div class="my-review p-3 mb-3 pointer" style="background-color: #f9f9f9; width: 920px;" onclick="fn_reviewDetail('${review.reviewId}');">
                <div class="d-flex flex-column justify-content-between w-100">
                    <div class="d-flex justify-content-between align-items-center pb-2">
                        <div class="d-flex align-items-center">
                            <c:if test="${review.usrImg != null && not empty review.usrImg}">
                                <img style="width: 35px; height: 35px; border-radius: 50%" src="/file/images/${review.usrImg }">
                            </c:if>
                            <c:if test="${review.usrImg == null || empty review.usrImg}">
                                <div class="text-center">
                                    <i style="font-size: 1.6rem;" class="fa fa-user-circle"></i>
                                </div>
                            </c:if>
                            <div class="fw-bold px-2">${review.usrNm}</div>
                        </div>
                        <div class="px-1 bg-white border-5">
                            <i class="fa fa-star"></i>&nbsp;
                            <span>${review.rating}.0</span>
                        </div>
                    </div>
                    <div class="card-text text-pre-line p-2 pointer" style="height: 100px; -webkit-line-clamp: 4;">
                        ${review.reviewContent}
                    </div>
                    <div class="d-flex align-items-center pt-4 ps-2">
                        <i class="fa fa-commenting"></i><span>&nbsp;${review.commentCnt}</span>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</c:if>
<c:if test="${empty reviewList}">
    <div class="text-center py-2"><spring:message code="search.result.none"/></div>
</c:if>
