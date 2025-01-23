/* ********************************************************
* 함수명	: fn_showToastMessage(string)
* 설명	: 인자로 넘겨받은 문자열을 토스트 메시지로 보여줌
******************************************************** */
function fn_showToastMessage(string) {
    let toast = $('#base-toast');
    toast.find('.toast-body').html(string); // 토스트 메시지 세팅
    toast.toast('show'); // 토스트 표시
}