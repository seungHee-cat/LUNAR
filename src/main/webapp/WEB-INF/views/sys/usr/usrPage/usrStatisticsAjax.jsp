<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="project.kr.sys.login.entity.LoginSession" %>

<script type="text/javascript">

$(document).ready( function() {

});

/*--------------------------------------------------------
| 유저 리뷰 전체 조회
 --------------------------------------------------------*/
function fn_usrReviewList(){
    let encodedId = $("input[name=encodedId]").val();
    location.href = "<c:url value='/sys/usr/usrReviewList'/>" + "?encodedId=" + encodedId;
}

</script>
<input type="hidden" name="encodedId" value="${usr.encodedId}">
<div class="d-flex justify-content-center bg-white px-5 py-2">
    <div class="d-flex justify-content-around mx-5 py-2 text-center" style="width: 650px; border-top: 1px solid #e7e7e7; border-bottom: 1px solid #e7e7e7;">
        <div class="d-flex flex-column pointer" onclick="fn_usrReviewList();">
          <div class="fw-bold">${reviewCnt}</div>
          <div><spring:message code="button.review"/></div>
        </div>
        <div style="color: #e7e7e7; font-size: 2rem;">|</div>
        <div class="d-flex flex-column pointer" onclick="fn_calenderRatingList('', '${usr.encodedId}', '')">
          <div class="fw-bold">${ratingAvg}</div>
          <div><spring:message code="rating.text.avg"/></div>
        </div>
    </div>
</div>