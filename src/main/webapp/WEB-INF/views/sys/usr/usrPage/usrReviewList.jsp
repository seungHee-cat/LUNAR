<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="project.kr.sys.login.entity.LoginSession" %>

<script type="text/javascript">
let isMenuOpen = false;

$(document).ready( function() {
    fn_usrReviewAjax(); // 유저 리뷰 리스트 전체 Ajax

    window.onclick = function (event) {
        if (!event.target.matches('.dropdown-btn')) {
            let dropdowns = document.getElementsByClassName('dropdown_content');

            for (let i = 0; i < dropdowns.length; i++) {
                let openDropdown = dropdowns[i];
                if (openDropdown.classList.contains('show-dropdown')) {
                    openDropdown.classList.remove('show-dropdown');
                    isMenuOpen = false;
                }
            }
        }
    };

    document.querySelector('.fa-caret-down').addEventListener('click', function(event) {
        event.stopPropagation();
        toggleDropdown();
    });

});

/*--------------------------------------------------------
| 유저 리뷰 리스트 전체 Ajax
 --------------------------------------------------------*/
function fn_usrReviewAjax(orderType){
    let usrId = $("input[name=usrId]").val();
    let params = "usrId=" + usrId + "&orderType=" + orderType;
    fn_ajaxRoadDiv("<c:url value='/sys/usr/usrReviewListAjax'/>", params, "usrReviewAjax");
}

/*--------------------------------------------------------
| 정렬 Dropdown 이벤트
 --------------------------------------------------------*/
function toggleDropdown() {
    let dropdown = document.getElementById('myDropdown');
    dropdown.classList.toggle('show-dropdown');
    isMenuOpen = !isMenuOpen;
}

</script>

<input type="hidden" name="usrId" value="${usr.usrId}">
<div class="container-xl mb-5 bg-white">
    <div class="mx-5 py-5">
        <div class="py-5 px-4">
            <div class="fw-bold" style="font-size: 1.3rem;">${usr.usrNm}<spring:message code="usr.text.review"/></div>
        </div>
        <!-- 정렬 필터(orderType) -->
        <div style="background-color: #f9f9f9;">
            <div class="px-3">
                <div class="order_div dropdown">
                    <div onclick="toggleDropdown();">
                        <button class="dropdown-btn">
                            <spring:message code="button.order"/><i class="fa fa-caret-down"></i>
                        </button>
                    </div>
                    <div class="dropdown_content" id="myDropdown">
                        <div class="sortByCommentCnt p-1" onclick="fn_usrReviewAjax('title')"><spring:message code="select.option.title"/></div>
                        <div class="sortByCommentViews p-1" onclick="fn_usrReviewAjax('commentCnt')"><spring:message code="select.option.comment"/></div>
                        <div class="sortByCommentViews p-1" onclick="fn_usrReviewAjax('')"><spring:message code="select.option.asc"/></div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 유저 리뷰 리스트 전체 Ajax -->
        <div id="usrReviewAjax"></div>
    </div>
</div>


