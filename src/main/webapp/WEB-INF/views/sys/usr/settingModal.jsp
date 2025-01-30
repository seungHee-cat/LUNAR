<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">

$(document).ready(function() {
    fn_usrProfileAjax(); // 프로필 조회
    let isEmailValid = false;
});

/*--------------------------------------------------------
| 프로필 조회
 --------------------------------------------------------*/
 function fn_usrProfileAjax(){
    fn_ajaxRoadDiv("<c:url value='/sys/usr/usrProfileAjax'/>", null, "usrProfileDiv");
 }

/*--------------------------------------------------------
| 이메일 유효성 체크
 --------------------------------------------------------*/
function fn_chkValidation(){
    if (isEmailValid) {
        $('#usrModifySave').prop('disabled', false);
    } else {
        $('#usrModifySave').prop('disabled', true);
    }
}

/*--------------------------------------------------------
| 프로필 수정
 --------------------------------------------------------*/
function fn_usrModifyAjax(event) {
    event.preventDefault(); // 새로고침 방지(모달 닫힘 방지)
    fn_ajaxFormSubmit("settingFrm", "<c:url value='/sys/usr/updateUsrProfileAjax'/>", fn_usrModifyCallback);
}

function fn_usrModifyCallback(data) {
    if(data.ok){
        fn_usrProfileAjax(); // 프로필 조회
        fn_dropdownAjax(); // 사진/드롭다운 조회
        fn_showToastMessage(data.message);
    }else{
        fn_showToastMessage(data.message);
    }
}

/*--------------------------------------------------------
| 회원탈퇴 모달
 --------------------------------------------------------*/
function withdrawModal() {
    // 설정 모달 닫고 회원탈퇴 모달 열기
    modal.closeModal();

    $('#base-modal').on('hidden.bs.modal', function () {
        setTimeout(function () {
            let formData = new FormData();
            modal.openModal("/sys/usr/withdrawModal", formData, "medium");
        }, 150);
    });
}

</script>
<form name="settingFrm" id="settingFrm" enctype="multipart/form-data">
<div class="modal-header">
    <h5 class="modal-title" id="profileModalLabel"><spring:message code="button.profileEdit"/></h5>
    <button type="button" class="btn-close" onclick="modal.closeModal();"></button>
</div>
<div class="modal-body">
    <div class="row">
        <!-- 왼쪽 메뉴 -->
        <div class="col-md-3 border-end">
            <ul class="nav flex-column nav-pills" id="profileTab" role="tablist">
                <li class="nav-item">
                    <button class="nav-link active" id="edit-profile-tab" data-bs-toggle="pill" data-bs-target="#edit-profile" type="button" role="tab" aria-controls="edit-profile" aria-selected="true">
                        <spring:message code="button.profile"/>
                    </button>
                </li>
                <li class="nav-item">
                    <button class="nav-link" id="delete-account-tab" data-bs-toggle="pill" data-bs-target="#delete-account" type="button" role="tab" aria-controls="delete-account" aria-selected="false">
                        <spring:message code="button.withdraw"/>
                    </button>
                </li>
            </ul>
        </div>
        <!-- 오른쪽 탭 컨텐츠 -->
        <div class="col-md-9">
            <div class="tab-content" id="profileTabContent">
                <div class="tab-pane show active" id="edit-profile" role="tabpanel" aria-labelledby="edit-profile-tab">
                    <div class="fw-bold mb-3" style="font-size: 1.3rem;"><spring:message code="button.profileModify"/></div>
                    <!-- 프로필 조회 -->
                    <div id="usrProfileDiv"></div>
                </div>
                <!-- 회원탈퇴 탭 -->
                <div class="tab-pane" id="delete-account" role="tabpanel" aria-labelledby="delete-account-tab">
                    <p>
                        <spring:message code="usr.withdraw.confirm"/><br/><spring:message code="common.continue.info"/>
                    </p>
                    <button type="button" class="btn btn-danger mb-2 float-end" onclick="withdrawModal();">
                        <spring:message code="button.withdraw"/>
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <button class="btn btn-primary" id="usrModifySave" onclick="fn_usrModifyAjax(event);">
            <spring:message code="button.save"/>
        </button>
    </div>
</div>
</form>