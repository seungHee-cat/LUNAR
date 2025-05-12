<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript" src="<c:url value='/js/card.slide.js'/>"></script>

$(document).ready( function() {

});

<form id="newsListFrm" name="newsListFrm">
<div class="container-xl p-5">
    <div class="m-5">
        <h4 class="fw-bold">공지사항</h4>
    </div>
    <table class="w-100 text-center bg-white">
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>날짜</th>
                <th>조회수</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td>예시 게시글 제목입니다</td>
                <td>2025-05-12</td>
                <td>123</td>
            </tr>
            <tr>
                <td>2</td>
                <td>두 번째 글 제목</td>
                <td>2025-05-11</td>
                <td>98</td>
            </tr>
        </tbody>
    </table>
</div>
</form>
