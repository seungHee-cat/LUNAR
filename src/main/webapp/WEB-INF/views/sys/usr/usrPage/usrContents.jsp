<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="project.kr.sys.login.entity.LoginSession" %>

<script type="text/javascript">

$(document).ready( function() {
    fn_usrStatisticsAjax(); // 유저 통계 조회
    fn_usrCalenderAjax(); // 유저 캘린더 조회
});

/*--------------------------------------------------------
| 유저 통계 조회
 --------------------------------------------------------*/
function fn_usrStatisticsAjax(){
    let usrId = $("input[name=usrId]").val();
    fn_ajaxRoadDiv("<c:url value='/sys/usr/usrStatisticsAjax'/>", "usrId="+usrId, "usrStatistics");
}

/*--------------------------------------------------------
| 유저 캘린더 조회
 --------------------------------------------------------*/
function fn_usrCalenderAjax(){
    let usrId = $("input[name=usrId]").val();
    fn_ajaxRoadDiv("<c:url value='/sys/usr/usrCalenderAjax'/>", "usrId="+usrId, "usrCalender");
}

</script>
<input type="hidden" name="usrId" value="${usr.usrId}">
<div class="d-flex justify-content-center container-xl mb-5">
    <div class="d-flex flex-column mx-5 py-5" style="width: 850px;">
        <div class="card mt-5 mx-5">
            <div style="position: relative; height: 170px; background-color: rgb(227 227 227);">
                <c:if test="${usr.usrImg != null && not empty usr.usrImg}">
                  <img style="position: absolute; left: 15px; top: 30px; width: 175px; height: 175px; border-radius: 50%"
                      src="/file/images/${usr.usrImg }">
                </c:if>
                <c:if test="${usr.usrImg == null || empty usr.usrImg}">
                  <div class="text-center px-2">
                      <i style="position: absolute; left: 15px; top: 80px; font-size: 8.5rem;" class="fa fa-user-circle"></i>
                  </div>
                </c:if>
            </div>
            <div class="d-flex justify-content-between pt-5 pb-4 bg-white">
                <div class="d-flex flex-column pt-2 px-4">
                    <div class="fw-bold pb-1" style="font-size: 1.5rem;">${usr.usrNm}</div>
                    <c:if test="${empty usr.email}">
                        <div class="py-1" style="font-size: 0.9rem; color: gray;"><spring:message code="usr.profile.email"/></div>
                    </c:if>
                    <c:if test="${not empty usr.email}">
                        <div style="color: gray;">${usr.email}</div>
                    </c:if>
                    <c:if test="${empty usr.usrDesc}">
                        <div class="py-1" style="font-size: 0.9rem; color: gray;"><spring:message code="usr.profile.desc"/></div>
                    </c:if>
                    <c:if test="${not empty usr.usrDesc}">
                        <div class="pt-4" style="color: gray;">${usr.usrDesc}</div>
                    </c:if>
                </div>
                <div class="d-flex align-items-center px-5">
                  <c:if test="${usr.usrId == loginSession.loginUsrId}">
                      <button type="button" onclick="settingModal();" class="p-3"
                           style="border: none; border-radius: 10px; background-color: #eeeeee;"><spring:message code="button.profileEdit"/>
                      </button>
                  </c:if>
                </div>
            </div>
          <!-- 유저의 기록 조회 -->
          <div id="usrStatistics"></div>
        </div>
    <!-- 캘린더 조회 -->
    <div id="usrCalender"></div>
    </div>
</div>


