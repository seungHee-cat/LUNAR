<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>LUNAR</title>

	<!--
	--------------------------------------------------------------------
			공통 CSS Files
	--------------------------------------------------------------------
	-->

    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common/common.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/bootstrap/styles.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/font-awesome/font-awesome.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/star-rating/star-rating.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/jquery-ui/jquery-ui.min.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/chart/Chart.min.css'/>" />


	<!--
	--------------------------------------------------------------------
			공통 JS Files
	--------------------------------------------------------------------
	-->

	<script type="text/javascript" src="<c:url value='/js/jquery-3.7.1.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/bootstrap.bundle.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/star-rating.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/Chart.bundle.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/ajaxFunction.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/modal.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/toast.js'/>"></script>

	<!-- 에러 페이지용 로티 라이브러리 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/lottie-web/5.9.6/lottie.min.js"></script>

</head>
<body>
	<tiles:insertAttribute name="body"/>
</body>
</html>