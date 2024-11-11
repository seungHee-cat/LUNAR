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

function fn_login() {
    fn_ajaxSubmit("loginFrm", "<c:url value='/sys/login/loginAjax'/>", fn_loginCallback, false);
}

function fn_loginCallback(data) {
    /* 로그인 성공 시 돌아올 페이지 지정하는 거인듯 */
    if(data.ok) {
        location.href = "";
    } else {
        fn_toastShow(data.message);
    }
}
</script>
<body style="background-color: #212529">
<form name="loginFrm" id="loginFrm">
	<div id="layoutAuthentication">
        <div id="layoutAuthentication_content">
            <main>
                <div class="container">
                    <div class="row justify-content-center" style="display: flex; flex-direction: column; align-items: center;">
                        <div class="loginLogo"></div>
                        <div style="width: 526px;">
                            <div class="card shadow-lg border-0 rounded-lg mt-5">
                                <div class="card-body">
                                    <form>
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="loginUsrNm" name="loginUsrNm" type="text" placeholder="Username" value="test" />
                                            <label for="loginUsrNm">Username</label>
                                        </div>
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="loginUsrPw" name="loginUsrPw" type="password" placeholder="Password" value="1234" />
                                            <label for="loginUsrPw">Password</label>
                                        </div>
                                        <div class="d-flex align-items-center justify-content-between mt-4 mb-0">
                                            <a class="btn btn-primary" onclick="fn_login();">Login</a>
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