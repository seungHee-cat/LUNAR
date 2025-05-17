<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="project.kr.sys.login.entity.LoginSession" %>

<script type="text/javascript">

$(document).ready( function() {

});

/*--------------------------------------------------------
| 게시글 상세 페이지 이동
 --------------------------------------------------------*/
function fn_boardDetail(boardId) {
    location.href = "<c:url value='/board/boardDetail'/>" + "?boardId=" + boardId;
}

</script>
<div class="">
    <table class="w-100 text-center bg-white">
        <colgroup>
            <col style="width: 10%;" />   <!-- 번호: 좁게 -->
            <col style="width: 15%;" />   <!-- 분류: 좁게 -->
            <col style="width: 55%;" />   <!-- 제목: 넓게 -->
            <col style="width: 20%;" />   <!-- 날짜: 중간 -->
        </colgroup>
        <thead>
            <tr>
                <th><spring:message code="common.board.number"/></th>
                <th><spring:message code="common.board.category"/></th>
                <th><spring:message code="common.board.title"/></th>
                <th><spring:message code="common.board.date"/></th>
            </tr>
        </thead>
        <tbody>
            <c:set var="startNum" value="${totalCnt - (curPage - 1) * size}" />
            <c:forEach var="board" items="${boardList }" varStatus="loop">
                <tr class="pointer" style="height: 50px; border-bottom: 0.8px solid #eeeeee;"
                    onclick="fn_boardDetail(${board.boardId})">
                    <td>${startNum - loop.index}</td>
                    <td>
                        <c:choose>
                            <c:when test="${board.tagNm eq '기능개선'}">
                                <span class="badge bg-success px-3 py-2" style="font-size: 0.9rem; border-radius: 1rem;">
                                    ${board.tagNm}
                                </span>
                            </c:when>
                            <c:when test="${board.tagNm eq 'UI개선'}">
                                <span class="badge bg-info text-dark px-3 py-2" style="font-size: 0.9rem; border-radius: 1rem;">
                                    ${board.tagNm}
                                </span>
                            </c:when>
                            <c:when test="${board.tagNm eq '공지사항'}">
                                <span class="badge bg-warning text-dark px-3 py-2" style="font-size: 0.9rem; border-radius: 1rem;">
                                    ${board.tagNm}
                                </span>
                            </c:when>
                        </c:choose>
                    </td>
                    <td>${board.title}</td>
                    <td>
                        <fmt:formatDate value="${board.wrtTime}" pattern="yyyy-MM-dd"/>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <nav aria-label="Page navigation" class="mt-4">
      <ul class="pagination justify-content-center">
        <li class="page-item ${curPage == 1 ? 'disabled' : ''}">
          <button type="button" class="page-link" onclick="fn_boardListAjax(${curPage - 1})" tabindex="-1" aria-disabled="${curPage == 1}">
            <spring:message code="button.prev"/>
          </button>
        </li>
        <c:forEach begin="1" end="${totalPages}" var="page">
          <li class="page-item ${page == curPage ? 'active' : ''}">
            <button type="button" class="page-link" onclick="fn_boardListAjax(${page})">
              ${page}
            </button>
          </li>
        </c:forEach>
        <li class="page-item ${curPage == totalPages ? 'disabled' : ''}">
          <button type="button" class="page-link" onclick="fn_boardListAjax(${curPage + 1})" aria-disabled="${curPage == totalPages}">
            <spring:message code="button.next"/>
          </button>
        </li>
      </ul>
    </nav>
</div>
