<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">

$(document).ready(function() {
     // $('body').append('<div class="modal-backdrop fade show"></div>');
});

/*--------------------------------------------------------
| 회원탈퇴 진행
 --------------------------------------------------------*/
function withdrawAccount(){
    const usrPw = document.getElementById('usrPw').value;
    const confirmCheckbox = document.getElementById('confirmCheckbox');
    let checkVal = false;
    let checkboxMessage = "<spring:message code='usr.withdraw.checkbox'/>";

    if (!confirmCheckbox.checked) {
        $("#confirmCheckboxMsg").text(checkboxMessage);
        return;
    }else{
        $("#confirmCheckboxMsg").text('');
    }

    // 비밀번호 체크 후 회원탈퇴 진행
    if (confirmCheckbox.checked && usrPw) {
        fn_checkPassword(function(isPasswordValid) {
            if (isPasswordValid) {
                checkVal = true;
                // 비밀번호 체크 후 회원탈퇴 진행
                fn_ajaxFormSubmit("withdrawForm", "<c:url value='/sys/usr/withdrawAccount'/>", fn_withdrawCallback);
            }
        });
    } else {
        event.stopPropagation();
    }
}

function fn_withdrawCallback(data){
    if (data.ok) {
        modal.closeModalAndReload(data.message);
    } else {
        fn_showToastMessage(data.message);
    }
}

/*--------------------------------------------------------
| 회원탈퇴 비밀번호 확인
 --------------------------------------------------------*/
function fn_checkPassword(callback){
    let checkboxMessage = "<spring:message code='usr.profile.chkPassword'/>";

    $.ajax({
        type : "post",
        url : "/sys/usr/checkPassword",
        headers : {'Content-Type' : 'application/json'},
        data : $('#usrPw').val(),
        success : function(result){
            if(result === 'password match'){
                console.log('password match!');
                callback(true);
            }else{
                fn_showToastMessage(checkboxMessage);
                callback(false);
            }
        },
        error : function(status, error){
            callback(false);
        }
    });
}

</script>
<form id="withdrawForm" novalidate>
<div class="modal-header">
    <h5 class="modal-title" id="profileModalLabel"><spring:message code="button.withdraw"/></h5>
    <button type="button" class="btn-close" onclick="modal.closeModal();"></button>
</div>
<div class="modal-body">
    <div class="mb-3">
        <div class="d-flex align-items-center justify-content-between">
            <label for="usrPw" class="form-label"><spring:message code="usr.profile.curPassword"/></label>
            <input type="password" id="usrPw" name="usrPw" class="form-control" style="width: 80%;" required>
        </div>
        <div class="invalid-feedback"><spring:message code="usr.profile.password"/></div>
    </div>
    <div class="form-check mb-3">
        <input class="form-check-input" type="checkbox" value="" id="confirmCheckbox" required>
        <label class="form-check-label" for="confirmCheckbox">
          <spring:message code="usr.withdraw.final"/>
        </label>
        <div id="confirmCheckboxMsg" class="text-danger"></div>
    </div>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-danger" onclick="withdrawAccount(event);">
        <spring:message code="button.conf"/>
    </button>
</div>
</form>