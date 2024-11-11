<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="project.kr.sys.login.entity.LoginSession" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Leaf</title>

	<!--
	********************************************************************
			공통 CSS load 시작
	********************************************************************
	-->

	<!-- ================== Bootstrap CSS Start ================== -->
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/bootstrap/styles.css'/>" />
    <!-- ================== Bootstrap CSS End =================== -->

	<link rel="stylesheet" type="text/css" href="<c:url value='/css/jquery-ui/jquery-ui.min.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/animate/animate.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/font-awesome/all.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/font-awesome/fontawesome.css'/>" />

    <!-- ================== Old styles for test ================== -->
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/old/common.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/old/header.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/old/footer.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/old/admin.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/old/comments.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/old/common.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/old/index.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/old/movieComment.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/old/myComment.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/old/myPage.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/old/myRating.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/old/search.css'/>" />

    <!-- ================== Plug in Util CSS Start ================== -->
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/plugin/bootstrap-datepicker.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/plugin/bootstrap-datepicker3.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/plugin/daterangepicker.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/plugin/select2.css'/>" />
    <!-- ================== Plug in Util CSS End =================== -->

    <!-- ================== Chart CSS Start ================== -->
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/chart/Chart.min.css'/>" />
    <!-- ================== Chart CSS End =================== -->

    <!-- ================== 데이터 테이블 CSS Start ================== -->
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/dataTables/dataTables.bootstrap.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/dataTables/responsive.bootstrap.css'/>" />
	<!-- ================== 데이터 테이블 CSS End =================== -->

	<!-- ================== 첨부파일 업로드 CSS Start ================== -->
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/fileupload/fileUpload.css'/>" />
	<!-- ================== 첨부파일 업로드 CSS End ================== -->


	<!--
	********************************************************************
			공통 JS load 시작
	********************************************************************
	-->
	<!-- ================== Jquery 관련 Start ================== -->
	<script type="text/javascript" src="<c:url value='/js/jquery-3.7.1.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/jquery.dataTables.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery-ui.js'/>"></script>
	<!-- ================== Jquery 관련 End ================== -->

	<!-- ================== BootStrap 관련 Start ================== -->
	<script type="text/javascript" src="<c:url value='/js/bootstrap.bundle.js'/>"></script>
	<!-- ================== BootStrap 관련 End ================== -->

	<!-- ================== function 관련 Start ================== -->
    <script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
    <!-- ================== function 관련 End ================== -->

	<!-- ================== 팝업 관련 Start ================== -->
	<script type="text/javascript" src="<c:url value='/js/popupUtil.js'/>"></script>
	<!-- ================== 팝업 관련 End ================== -->

    <!-- ================== 토스트 메시지 관련 Start ================== -->
	<script type="text/javascript" src="<c:url value='/js/toast.js'/>"></script>
	<!-- ================== 토스트 메시지 관련 End ================== -->

    <!-- ================== 차트 관련 Start ================== -->
	<script type="text/javascript" src="<c:url value='/js/Chart.bundle.min.js'/>"></script>
	<!-- ================== 차트 관련 End ================== -->

	<!-- ================== Form Util JS Start ================== -->
	<script type="text/javascript" src="<c:url value='/js/string.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/number.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/date.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/form.js'/>"></script>
	<!-- ================== Form Util JS Start ================== -->

    <!-- Lightpicker -->
    <script src="https://cdn.jsdelivr.net/npm/litepicker/dist/litepicker.js"></script>
</head>
<script type="text/javascript">
</script>
<body class="bg-light drawer-toggled">
    <form id="topFrm" name="topFrm">
        <input type="hidden" name="dbId" value="<c:out value='${sessionScope.dbId}'/>"/>
        <input type="hidden" name="dbNm" value="<c:out value='${sessionScope.dbNm}'/>"/>
    </form>
    <!-- Top app bar navigation menu -->
    <nav class="navbar bg-body-tertiary">
      <div class="container-fluid">
        <a class="navbar-brand">Navbar</a>
        <form class="d-flex" role="search">
          <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
          <button class="btn btn-outline-success" type="submit">Search</button>
        </form>
      </div>
    </nav>
    <!-- layout wrapper -->
    <div>
        ================ BaseLayout content START ================ <br/>
        ================ BaseLayout content END ================  <br/>
    </div>
    <!-- footer -->
	<tiles:insertAttribute name="body"/>
</body>
</html>

<%--토스트 메시지--%>
<div class="z-index-toast position-fixed top-50 start-50 translate-middle-x p-3">
    <div id="normal-toast" class="toast align-items-center text-white fw-bolder bg-dark" role="alert" aria-live="polite" aria-atomic="true" data-bs-delay="1300">
        <div class="d-flex justify-content-center">
			<div class="toast-body"></div>
<%--            <button class="btn-close btn-close-white me-2 m-auto" type="button" data-bs-dismiss="toast" aria-label="Close"></button>--%>
        </div>
    </div>
</div>

<%--모달--%>
<div class="modal fade" id="modalScrollable" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content"></div>
    </div>
</div>

<div class="modal fade" id="modalScrollable2" data-bs-backdrop="static" data-bs-keyboard="true" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content"></div>
    </div>
</div>

<%--스피너--%>
<div class="spinner-overlay text-center" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.6); display: block; z-index: 1099; visibility: hidden;">
    <div class="spinner-border text-primary" role="status" style="z-index: 1100; visibility: hidden; width: 3rem; height: 3rem; margin-top: 22.5%;">
      <span class="visually-hidden">Loading...</span>
    </div>
</div>



























