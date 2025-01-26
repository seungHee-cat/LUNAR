<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
let isIdValid = false;
let isPwValid = false;

$(document).ready(function() {
    /* 회원가입 아이디 유효성 검사 */
    $('#usrId').keyup(function(){
        const getIdCheck = RegExp(/^(?!.*admin)[a-zA-Z0-9]{5,15}$/);

        /* 회원가입 ID 메세지 */
        let idMessage = "<spring:message code='usr.register.id'/>";
        let idCheckMessage = "<spring:message code='usr.register.idCheck'/>";
        let availableIdMessage = "<spring:message code='usr.register.availableId'/>";
        let duplicateIdMessage = "<spring:message code='usr.register.duplicateId'/>";

        if($(this).val() == ''){
            $('#idCheck').text(idMessage);
            isIdValid = false;
        }else if(!getIdCheck.test($(this).val())){
            $('#idCheck').text(idCheckMessage)
            isIdValid = false;
        } else {
            $.ajax({
                type : "post",
                url : "/sys/usr/idCheck",
                headers : {'Content-Type' : 'application/json'},
                dataType : 'text',
                data : $('#usrId').val(),
                success : function(result){
                    if(result === 'available'){
                        $('#idCheck').text(availableIdMessage);
                        isIdValid = true;
                        fn_chkValidation();
                    }else{
                        $('#idCheck').text(duplicateIdMessage);
                        isIdValid = false;
                    }
                },
                error : function(status, error){
                    isIdValid = false;
                }
            });
        }
        fn_chkValidation();
    });

    /* 회원가입 비밀번호 유효성 검사 */
    $('#usrPw').keyup(function(){
        const getPwCheck = RegExp(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{10,15}$/);

        /* 회원가입 PW 메세지 */
        let pwMessage = "<spring:message code='usr.register.pw'/>";
        let pwCheckMessage = "<spring:message code='usr.register.pwCheck'/>";
        let availablePwMessage = "<spring:message code='usr.register.availablePw'/>";

        if($(this).val() == ''){
            $('#pwCheck').text(pwMessage);
            isPwValid = false;
        }else if(!getPwCheck.test($(this).val())){
            $('#pwCheck').text(pwCheckMessage);
            isPwValid = false;
        }else{
            $('#pwCheck').text(availablePwMessage);
            isPwValid = true;
            fn_chkValidation();
        }
        fn_chkValidation();
    });

    /* 회원가입 버튼 클릭 이벤트 */
    $('#registerButton').click(function (event) {
        event.preventDefault();

        if (!isIdValid) {
            $('#usrId').focus();
            return;
        }
        if (!isPwValid) {
            $('#usrPw').focus();
            return;
        }
        fn_registerAjax();
    });

});

/*--------------------------------------------------------
| 회원가입 유효성 전체 체크
 --------------------------------------------------------*/
function fn_chkValidation(){
    if (isIdValid && isPwValid) {
        $('#registerButton').prop('disabled', false);
    } else {
        $('#registerButton').prop('disabled', true);
    }
}

/*--------------------------------------------------------
| 회원가입 진행
 --------------------------------------------------------*/
function fn_registerAjax() {
    fn_ajaxFormSubmit("registerFrm", "<c:url value='/sys/register/registerAjax'/>", fn_registerCallback);
}

function fn_registerCallback(data) {
    if(data.ok) {
        fn_showToastMessage(data.message);
        location.href = "/";
    } else {
        fn_showToastMessage(data.message);
    }
}
</script>

<form name="registerFrm" id="registerFrm">
<div class="container">
    <div class="modal-header d-flex justify-content-between w-100">
        <h5 class="modal-title mx-auto"><spring:message code="button.register"/></h5>
        <button class="btn-close" type="button" onclick="modal.closeModal();"></button>
    </div>
    <div class="modal-body">
        <div class="container">
            <div class="d-flex flex-column">
                <div class="loginLogo"></div>
                <div class="form-floating mb-3">
                    <input class="form-control" id="usrId" name="usrId" type="text" placeholder="<spring:message code='usr.register.id'/>"  minlength="5" maxlength="15" required/>
                    <div id="idCheck"></div>
                </div>
                <div class="form-floating mb-3">
                    <input class="form-control" id="usrPw" name="usrPw" type="password" placeholder="<spring:message code='usr.register.pw'/>" minlength="10" maxlength="15" required/>
                    <div id="pwCheck"></div>
                </div>
                <div class="d-flex align-items-center justify-content-between mt-4 mb-0">
                    <button class="btn btn-outline-secondary w-100 justify-content-center" id="registerButton" disabled><spring:message code="button.register"/></button>
                </div>
            </div>
        </div>
    </div>
</div>
</form>