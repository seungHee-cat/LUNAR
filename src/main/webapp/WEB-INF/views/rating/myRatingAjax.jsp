<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="project.kr.sys.login.entity.LoginSession" %>

<script type="text/javascript">

$(document).ready( function() {
    const stars = new StarRating('.star-rating');
});

/*--------------------------------------------------------
| 별점 평가 선택
 --------------------------------------------------------*/
 function fn_starRating(){
    let selectedRating = document.getElementById('star-rating').value;
    $("input[name=rating]").val(selectedRating);

    // 같은 별점을 눌렀을 때 별점 취소
    if(selectedRating == ''){
        fn_ajaxFormSubmit("myRatingFrm", "<c:url value='/rating/deleteStarRating'/>", fn_deleteRatingCallback);
    }else{
        fn_ajaxFormSubmit("myRatingFrm", "<c:url value='/rating/starRating'/>", fn_ratingCallback);
    }
};

function fn_ratingCallback(data) {
    if(data.ok){
        fn_showToastMessage(data.message);
        js_starRatingAjax();
    }
}

function fn_deleteRatingCallback(data) {
    if(data.ok){
        fn_showToastMessage(data.message);
        js_starRatingAjax();
    }
}

</script>

<form id="myRatingFrm" name="myRatingFrm">
<input type="hidden" name="movieId" value="<c:out value='${MovieVO.movieId}'/>"/>
<input type="hidden" name="ratingId" value="<c:out value='${rating.ratingId}'/>"/>
<input type="hidden" name="myRating" value="<c:out value='${rating.rating}'/>"/>
<input type="hidden" name="rating" id="rating" value="">
    <div class="py-3 text-center">
        <!-- 별점 등록 -->
        <c:if test="${empty rating.ratingId}">
            <input type="hidden" name="postType" value="I"/>
        </c:if>
        <!-- 별점 수정 -->
        <c:if test="${not empty rating.ratingId}">
            <input type="hidden" name="postType" value="U"/>
        </c:if>
        <c:if test="${empty loginSession}">
            <select id="star-rating" class="star-rating" onchange="loginModal();">
                <option value=""></option>
                <option value="5"></option>
                <option value="4"></option>
                <option value="3"></option>
                <option value="2"></option>
                <option value="1"></option>
            </select>
        </c:if>
        <c:if test="${not empty loginSession}">
            <select id="star-rating" name="star-rating" class="star-rating" onchange="fn_starRating()">
                <option value=""></option>
                <c:forEach begin="1" end="5" var="item">
                    <option value="${item}" ${item == rating.rating ? 'selected' : ''}></option>
                </c:forEach>
            </select>
        </c:if>
    </div>
</form>
