<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">

/*--------------------------------------------------------
| 언어 변경
 --------------------------------------------------------*/
function fn_changeLang(lang){
    location.href="/changeLang?lang="+lang;
}

</script>

<div class="modal-header">
    <div class="flex-grow-1 text-center" style="padding-left: 30px; font-size: 1.3rem;">
        <spring:message code="main.lang.text"/>
    </div>
    <div class="text-end">
        <button type="button" class="btn-close" onclick="modal.closeModal();"></button>
    </div>
</div>
<div class="modal-body text-center">
    <ul class="search-ul" style="font-size: 1.2rem;" >
        <li onclick="fn_changeLang('ko');"><spring:message code="main.lang.ko"/></li>
        <li onclick="fn_changeLang('en');"><spring:message code="main.lang.en"/></li>
    </ul>
</div>