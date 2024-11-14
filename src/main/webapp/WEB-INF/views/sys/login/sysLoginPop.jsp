<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
/*********************************************************
 * 로그인
 *********************************************************/
$(document).ready( function() {
	let logoutMsg = "${logoutMsg}";
    if(logoutMsg)
        fn_toastShow(logoutMsg);
});

function fn_loginAjax() {
    fn_ajaxSubmit("loginFrm", "<c:url value='/sys/login/loginAjax'/>", fn_loginCallback, false);
}

function fn_loginCallback(data) {
    if(data.ok) {
        location.href = "/main";
    } else {
        fn_toastShow(data.message);
    }
}
</script>
<body>
<form name="loginFrm" id="loginFrm">
    <div id="layoutAuthentication">
        <div id="layoutAuthentication_content">
            <main>
                <div class="container">
                    <div class="modal-header d-flex justify-content-between w-100">
                        <h5 class="modal-title mx-auto">Leaf</h5>  <!-- mx-auto: 수평 중앙 정렬 -->
                        <button class="btn btn-transparent btn-sm p-0 border-0" type="button" onclick="popupUtil.closeNewPopup();">
                            <i class="fa fa-window-close fa-2x"></i>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container">
                            <div class="row justify-content-center" style="display: flex; flex-direction: column; align-items: center;">
                                <div class="loginLogo"></div>
                                <div>
                                    <form>
                                        <div class="form-floating mb-3">
                                            <input class="form-control w-100" id="loginUsrId" name="loginUsrId" type="text" placeholder="아이디를 입력해주세요." value="test" />
                                        </div>
                                        <div class="form-floating mb-3">
                                            <input class="form-control w-100" id="loginUsrPw" name="loginUsrPw" type="password" placeholder="비밀번호를 입력해주세요." value="1234" />
                                        </div>
                                        <div class="small" style="text-align: right;"><a href="#">Need an account? Sign up!</a></div>
                                        <div class="d-flex align-items-center justify-content-between mt-4 mb-0">
                                            <a class="btn btn-outline-secondary w-100 justify-content-center" onclick="fn_loginAjax();">Login</a>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
</form>

<%--토스트 메시지--%>
<div class="z-index-toast position-fixed bottom-0 start-50 translate-middle-x p-1">
    <div class="toast align-items-center text-white bg-primary" role="alert" aria-live="polite" aria-atomic="true" data-bs-delay="1300">
        <div class="d-flex">
            <div class="toast-body"></div>
            <button class="btn-close btn-close-white me-2 m-auto" type="button" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>
</body>