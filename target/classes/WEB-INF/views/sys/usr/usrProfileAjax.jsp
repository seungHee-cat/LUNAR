<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="project.kr.sys.login.entity.LoginSession" %>

<script type="text/javascript">

// 회원정보 이메일 유효성 검사
$('#email').keyup(function(){
    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

    // 이메일 메세지
    let emailChkMessage = "<spring:message code='usr.profile.emailChk'/>";
    let availableEmailMessage = "<spring:message code='usr.profile.availableEmail'/>";

    // 비어있어도 수정 허용 (이메일 필수 X)
    if ($(this).val() == '') {
        isEmailValid = true;
        fn_chkvalidation();
    } else if(!emailRegex.test($(this).val())){
        $('#emailChk').text(emailChkMessage)
        isEmailValid = false;
        fn_chkValidation();
    } else {
        $('#emailChk').text(availableEmailMessage);
        isEmailValid = true;
        fn_chkValidation();
    }
});

/*--------------------------------------------------------
| 프로필 삭제 모달
 --------------------------------------------------------*/
function deleteImgModal() {
    // 설정 모달 닫고 프로필 삭제 모달 열기
    modal.closeModal();

    $('#base-modal').on('hidden.bs.modal', function () {
        setTimeout(function () {
            let formData = new FormData();
            formData.append("usrImg", $("input[name=usrImg]").val());
            modal.openModal("<c:url value='/sys/usr/deleteImgModal'/>", formData, "small");
        }, 150);
    });
}

</script>
<input type="hidden" name="usrImg" value="${usr.usrImg}" >
<div class="mb-4">
    <div class="d-flex">
        <div style="position: relative;" class="w-50 text-center">
            <c:if test="${usr.usrImg != null && not empty usr.usrImg}">
                <img style="width: 80px; height: 80px; border-radius: 50%"
                    src="/img/usr/${usr.usrImg}">
            </c:if>
            <c:if test="${usr.usrImg == null || empty usr.usrImg}">
                <div class="text-center">
                    <i style="font-size: 3rem;" class="fa fa-user-circle"></i>
                </div>
            </c:if>
            <div style="position: absolute; bottom: 0">
                <button type="button" class="float-end border-0 bg-transparent" onclick="deleteImgModal();">
                    <i class="fa fa-trash-o" style="font-size: 1.7rem;"></i>
                </button>
            </div>
        </div>
        <div>
            <!-- 프로필 사진 변경 -->
            <input type="file" name="file" class="form-control info_btn" accept=".jpg, .gif, .png">
            <div style="font-size: 0.8rem; color: #8d8d8d;"><spring:message code="usr.profile.fileSize"/></div>
        </div>
    </div>
</div>
<!-- 하단 아이디, 닉네임, 이메일, 자기소개 -->
<div class="d-flex mb-3">
    <div class="mx-2">
        <label for="usrId" class="form-label"><spring:message code="select.option.id"/></label>
        <input type="text" class="form-control" id="usrId" name="usrId" value="${loginSession.loginUsrId}" readonly>
    </div>
    <div class="mx-2">
        <label for="nickname" class="form-label"><spring:message code="select.option.nickname"/></label>
        <input type="text" class="form-control" id="usrNm" name="usrNm" value="${usr.usrNm}" maxlength="8">
    </div>
</div>
<div class="mb-3">
</div>
<div class="mb-3 mx-2">
    <label for="email" class="form-label"><spring:message code="select.option.email"/></label>
    <input type="email" class="form-control" id="email" name="email" value="${usr.email}">
    <div id="emailChk" style="font-size: 0.9rem;" class="py-1"></div>
</div>
<div class="mb-3 mx-2">
    <label for="usrDesc" class="form-label"><spring:message code="select.option.desc"/></label>
    <textarea class="form-control" id="usrDesc" name="usrDesc" rows="3">${usr.usrDesc}</textarea>
</div>