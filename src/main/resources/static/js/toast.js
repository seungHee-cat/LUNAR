/* ********************************************************
* 함수명	: fn_toastShow(html)
* 설명	: 인자로 넘겨받은 문자열을 토스트 메시지로 보여줌
* 인  자	: html
*
******************************************************** */
function fn_toastShow(str) {
    let tst = $('#normal-toast');
    tst.find('.toast-body').html(str); // 토스트 메시지 세팅
    tst.toast('show'); // 토스트 표시
}

/* ********************************************************
* 함수명	: fn_toastShowReload(html, function())
* 설명	: 인자로 넘겨받은 문자열을 토스트 메시지로 보여준 후 콜백 함수 실행
* 인  자	: html, function()
*
******************************************************** */
function fn_toastShowReload(str, callback) {
    let tst = $('#normal-toast');
    tst.find('.toast-body').html(str); // 토스트 메시지 세팅
    tst.toast('show'); // 토스트 표시

    callback();
}