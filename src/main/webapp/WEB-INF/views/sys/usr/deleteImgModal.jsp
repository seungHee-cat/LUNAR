<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">

/*--------------------------------------------------------
| 프로필 사진 삭제
 --------------------------------------------------------*/
function fn_deleteImgAjax() {
    fn_ajaxFormSubmit("commentDelFrm", "<c:url value='/sys/usr/deleteImgAjax'/>", fn_ImgDelCallback);

}

function fn_ImgDelCallback(data) {
    if (data.ok) {
        modal.closeModalWithToast(data.message);
        fn_dropdownAjax(); // 사진/드롭다운 조회
        fn_usrProfileAjax(); // 프로필 조회
    } else {
        fn_showToastMessage(data.message);
    }
}

</script>

<form id="imgDelFrm" name="imgDelFrm">
<input type="hidden" name="usrImg" value="${SysUsrVO.usrImg}">
<div class="modal-header justify-content-end">
    <button class="btn-close text-end" type="button" onclick="modal.closeModal();"></button>
</div>
<div class="modal-body text-center">
    <spring:message code="usr.profile.img"/>
</div>
<div class="modal-footer">
    <button class="btn btn-sm btn-primary me-2" type="button" onclick="fn_deleteImgAjax();"></i>&nbsp;<spring:message code="button.conf"/></button>
    <button class="btn btn-sm btn-danger me-2" type="button" onclick="modal.closeModal();"></i>&nbsp;<spring:message code="button.close"/></button>
</div>
</form>