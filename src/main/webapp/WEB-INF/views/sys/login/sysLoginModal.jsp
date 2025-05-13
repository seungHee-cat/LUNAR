<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">

$(document).ready(function() {

});

/*--------------------------------------------------------
| 로그인
 --------------------------------------------------------*/
function fn_loginAjax() {
    fn_ajaxFormSubmit("loginFrm", "<c:url value='/sys/login/loginAjax'/>", fn_loginCallback);
}

function fn_loginCallback(data) {
    if (data.ok) {
        modal.closeModalAndReload(data.message);
    } else {
        fn_showToastMessage(data.message);
    }
}

/*--------------------------------------------------------
| 회원가입 모달
 --------------------------------------------------------*/
 function registerModal() {
     modal.closeModal();

    $('#base-modal').on('hidden.bs.modal', function () {
        setTimeout(function () {
            let formData = new FormData();
            modal.openModal("/sys/registerModal", formData, "medium");
        }, 150);
    });
 }

</script>
<form name="loginFrm" id="loginFrm">
<div class="container">
    <div class="modal-header d-flex justify-content-between w-100">
        <h5 class="modal-title mx-auto">LUNAR</h5>
        <button type="button" class="btn-close" onclick="modal.closeModal();"></button>
    </div>
    <div class="modal-body">
        <div class="container">
            <div class="d-flex flex-column">
                <div class="form-floating mb-3">
                    <input class="form-control" id="usrId" name="usrId" type="text" placeholder="아이디를 입력해주세요." value="admin" />
                </div>
                <div class="form-floating mb-3">
                    <input class="form-control" id="usrPw" name="usrPw" type="password" placeholder="비밀번호를 입력해주세요." value="google1234!" />
                </div>
                <div class="small pointer" style="text-align: right;" onclick="registerModal();">
                    <spring:message code="usr.register.confirm"/>
                </div>
                <div class="d-flex align-items-center justify-content-between mt-4 mb-0">
                    <a class="btn btn-outline-primary w-100 justify-content-center" onclick="fn_loginAjax();">
                        <spring:message code="button.login"/>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
</form>