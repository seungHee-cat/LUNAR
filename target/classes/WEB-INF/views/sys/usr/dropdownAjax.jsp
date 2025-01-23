<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="project.kr.sys.login.entity.LoginSession" %>

<script type="text/javascript">

</script>
<div class="dropdown d-inline-flex align-items-center">
    <c:if test="${usr.usrImg != null && not empty usr.usrImg}">
        <img class="pointer" style="width: 45px; height: 45px; border-radius: 50%"
            src="/img/usr/${usr.usrImg }" onclick="fn_usrContents('${loginSession.encodedId}');">
    </c:if>
    <c:if test="${usr.usrImg == null || empty usr.usrImg}">
        <div class="text-center pointer">
            <i style="font-size: 2rem;" class="fa fa-user-circle" onclick="fn_usrContents('${loginSession.encodedId}');"></i>
        </div>
    </c:if>
    <button class="btn btn-icon dropdown-toggle" id="dropdownProfile" type="button"
        data-bs-toggle="dropdown" aria-expanded="false" style="font-size: 1.3rem; padding: 10px;"></button>
    <ul class="dropdown-menu p-3" style="width: 180px;">
        <div style="border-bottom: 1px solid lightgray;" href="#">
            <div style="font-size: 1.3rem;" class="fw-bold">${loginSession.usrNm}</div>
            <p class="pointer" onclick="fn_usrContents('${loginSession.encodedId}');">
                <spring:message code="button.profileView"/>
            </p>
        </div>
        <li class="mt-3">
            <a class="dropdown-item" onclick="settingModal();">
                <i class="fa fa-cog"></i><span class="ms-3"><spring:message code="button.setting"/></span>
            </a>
        </li>
        <li>
            <a class="dropdown-item" onclick="logoutModal();">
                <i class="fa fa-sign-out"></i><span class="ms-3"><spring:message code="button.logout"/></span>
            </a>
        </li>
    </ul>
</div>