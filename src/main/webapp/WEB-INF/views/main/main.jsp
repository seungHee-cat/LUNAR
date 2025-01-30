<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">

$(document).ready( function() {
    let logoutMsg = "${logoutMsg}";
     if(logoutMsg)
        fn_showToastMessage(logoutMsg);

    fn_movieListAjax(); // 영화 목록 조회
});

/*--------------------------------------------------------
| 영화 목록 조회
 --------------------------------------------------------*/
function fn_movieListAjax() {
    fn_ajaxRoadDiv("<c:url value='/movie/movieListAjax'/>", null, "movieListAjax");
}

</script>

<div style="height: 90px;"></div>
<form id="movieFrm" name="movieFrm">
    <div class="container-xl mb-5" >
        <div class="movieList" name="movieList">
            <!-- 영화 목록 Ajax 조회 -->
            <div id="movieListAjax"></div>
        </div>
    </div>
</form>


