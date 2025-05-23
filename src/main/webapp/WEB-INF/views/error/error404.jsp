<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">

$(document).ready( function() {
    let lottieAni = bodymovin.loadAnimation({
        container: document.getElementById('lottie-pop'), // 필수
        path: 'https://lottie.host/36bb12c4-9578-4c77-a7aa-e0df382cbf00/ishftB0LnU.json', // 필수
        renderer: 'svg', // 필수
        loop: true, // 반복재생
        autoplay: true // 자동재생
    });
});

</script>

<div class="d-flex flex-column justify-content-center align-items-center" style="min-height: 100vh;">
    <div class="lottie-animation" style="max-width: 400px; margin-bottom: 2rem;"></div>
    <div class="text-center">
        <div id="lottie-pop" style="width: 100%; height: 300px;"></div>
        <h1 class="fw-bold" style="font-size: 3rem; margin-bottom: 1rem;">
            <spring:message code="common.error.404"/><br/><spring:message code="common.error.default"/>
        </h1>
        <p style="font-size: 1.5rem; margin-bottom: 2rem;">
            <spring:message code="common.error.none"/>
        </p>
        <a href="/" style="font-size: 1.3rem; text-decoration: none;" class="btn btn-outline-info">
            <spring:message code="common.error.homepage"/>
        </a>
    </div>
</div>
