<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">

/*--------------------------------------------------------
| 로그아웃
 --------------------------------------------------------*/
function fn_logout() {
    parent.location.href = "<c:url value='/sys/login/logout'/>"
}

</script>

<div class="modal-header justify-content-end">
    <button class="btn-close text-end" type="button" onclick="modal.closeModal();"></button>
</div>
<div class="modal-body text-center">
    <spring:message code="usr.logout.confirm"/>
</div>
<div class="modal-footer">
    <button class="btn btn-sm btn-primary me-2" type="button" onclick="fn_logout();"></i>&nbsp;<spring:message code="button.conf"/></button>
    <button class="btn btn-sm btn-danger me-2" type="button" onclick="modal.closeModal();"></i>&nbsp;<spring:message code="button.close"/></button>
</div>