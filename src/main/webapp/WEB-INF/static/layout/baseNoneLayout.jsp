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
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/old/admin.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/old/comments.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/old/common.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/old/footer.css'/>" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/old/header.css'/>" />
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
	
</head>
<body>
	<tiles:insertAttribute name="body"/>
</body>
</html>