<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="project.kr.sys.login.entity.LoginSession" %>

<script type="text/javascript">

$(document).ready( function() {
    fn_reviewSchAjax();

    // 검색 Enter 이벤트
    const schKeywordInput = document.querySelector("input[name='schKeyword']");
    schKeywordInput.addEventListener("keydown", function (event) {
        if (event.key === "Enter") {
            event.preventDefault(); // 폼 제출 방지
            fn_reviewSchAjax();
        }
    });
});

/*--------------------------------------------------------
| 리뷰 상세 조회
 --------------------------------------------------------*/
function fn_reviewDetail(reviewId){
    location.href = "<c:url value='/review/reviewDetail'/>" + "?reviewId=" + reviewId;
}

/*--------------------------------------------------------
| 리뷰 검색 조회
 --------------------------------------------------------*/
function fn_reviewSchAjax(){
    let schType = document.getElementById("schType").value;
    let schKeyword = $("input[name=schKeyword]").val();
    let movieId = $("input[name=movieId]").val();
    let params = "schType=" + schType + "&schKeyword=" + schKeyword + "&movieId=" + movieId;

    fn_ajaxRoadDiv("<c:url value='/review/allReviewListAjax'/>", params, "reviewListDiv");
}

</script>

<form id="reviewSchFrm" name="reviewSchFrm">
<input type="hidden" name="movieId" value="${MovieVO.movieId}" />
<div class="container" style="max-width: 1680px;">
    <div class="bg-white mx-auto py-5" style="width: 1240px;">
        <div class="py-5">
            <div class="d-flex flex-column">
                <!-- 리뷰 키워드 검색 -->
                <div class="d-flex mx-auto pb-5">
                    <select id="schType" name="schType" style="border: none; width: 80px; height: 34px;">
                        <option value="reviewContent" selected><spring:message code="select.option.content"/></option>
                        <option value="usrNm"><spring:message code="select.option.nickname"/></option>
                    </select>
                    <div class="ms-3" style="position: relative;">
                        <input type="text" name="schKeyword" class="form-control py-1" style="padding-left: 30px; width: 320px;"
                            placeholder="<spring:message code='search.common.text'/>">
                        <i class="fa fa-search" style="position: absolute; left: 12px; top: 9px;"></i>
                    </div>
                </div>
                <!-- 전체 리뷰 조회 -->
                <div id="reviewListDiv" class="mx-auto pb-5"></div>
            </div>
        </div>
    </div>
</div>
</form>