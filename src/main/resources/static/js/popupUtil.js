/**
 *
 */

// 중복생성 방지
if((typeof popupUtil) == 'undefined' || !popupUtil)
{
    popupUtil = {};
    /* ********************************************************
    * 함수명	: openNewPopup(url, formData, size)
    * 설명	: 모달 오픈 및 인자로 넘겨받은 정보로 서버에 내용 요청(size가 있을경우 모달 사이즈 조정)
    * 인  자	: url, formData, size("small"/"large"/"extraLarge")
    *
    ******************************************************** */
    popupUtil.openNewPopup = function(url, formData, size)
    {
        let popup = new bootstrap.Modal($("#modalScrollable"));
        popup.show();

        // 모달 오픈 이벤트 리스너
        $("#modalScrollable").one("shown.bs.modal",function(){
            // 모달 내용 가져오기
            $.ajax({
                url: url
                , type: "POST"
                , data: formData
                , dataType: "html"
                , processData: false
                , contentType: false
                , success: function (data) {
                    $("#modalScrollable").find(".modal-content").html(data);
                    // 사이즈 조절
                    switch (size) {
                        case "small":
                            $("#modalScrollable").removeClass("modal-lg").removeClass("modal-xl").addClass("modal-sm");
                        break
                        case "large":
                            $("#modalScrollable").removeClass("modal-sm").removeClass("modal-xl").addClass("modal-lg");
                        break
                        case "extraLarge":
                            $("#modalScrollable").removeClass("modal-sm").removeClass("modal-lg").addClass("modal-xl");
                        break
                        default:
                            $("#modalScrollable").removeClass("modal-sm").removeClass("modal-lg").removeClass("modal-xl");
                        break
                    }
                }, error: function() {
                    fn_toastShow("오류가 발생하였습니다.<br/>관리자에게 문의해주세요.");
                }
            });
        });
    };

    popupUtil.moveToPopup2 = function(url, formData, size)
    {
        let originPopup = bootstrap.Modal.getOrCreateInstance($("#modalScrollable"));
        let popup = new bootstrap.Modal($("#modalScrollable2"));
        originPopup.hide();
        popup.show();

        // 모달 오픈 이벤트 리스너
        $("#modalScrollable2").one("shown.bs.modal",function(){
            // 모달 내용 가져오기
            $.ajax({
                url: url
                , type: "POST"
                , data: formData
                , dataType: "html"
                , processData: false
                , contentType: false
                , success: function (data) {
                    $("#modalScrollable2").find(".modal-content").html(data);
                    // 사이즈 조절
                    switch (size) {
                        case "small":
                            $("#modalScrollable2").removeClass("modal-lg").removeClass("modal-xl").addClass("modal-sm");
                        break
                        case "large":
                            $("#modalScrollable2").removeClass("modal-sm").removeClass("modal-xl").addClass("modal-lg");
                        break
                        case "extraLarge":
                            $("#modalScrollable2").removeClass("modal-sm").removeClass("modal-lg").addClass("modal-xl");
                        break
                        default:
                            $("#modalScrollable2").removeClass("modal-sm").removeClass("modal-lg").removeClass("modal-xl");
                        break
                    }
                }, error: function() {
                    fn_toastShow("오류가 발생하였습니다.<br/>관리자에게 문의해주세요.");
                }
            });
        });
    };

    popupUtil.moveToOriginPop = function()
    {
        let originPopup = bootstrap.Modal.getOrCreateInstance($("#modalScrollable"));
        let popup = bootstrap.Modal.getOrCreateInstance($("#modalScrollable2"));
        popup.hide();
        originPopup.show();

        // 모달 오픈 이벤트 리스너
        // $("#modalScrollable").one("shown.bs.modal",function(){
        //     // 모달 내용 가져오기
        //     $.ajax({
        //         url: url
        //         , type: "POST"
        //         , data: formData
        //         , dataType: "html"
        //         , processData: false
        //         , contentType: false
        //         , success: function (data) {
        //             $("#modalScrollable").find(".modal-content").html(data);
        //             // 사이즈 조절
        //             switch (size) {
        //                 case "small":
        //                     $("#modalScrollable").removeClass("modal-lg").removeClass("modal-xl").addClass("modal-sm");
        //                 break
        //                 case "large":
        //                     $("#modalScrollable").removeClass("modal-sm").removeClass("modal-xl").addClass("modal-lg");
        //                 break
        //                 case "extraLarge":
        //                     $("#modalScrollable").removeClass("modal-sm").removeClass("modal-lg").addClass("modal-xl");
        //                 break
        //                 default:
        //                     $("#modalScrollable").removeClass("modal-sm").removeClass("modal-lg").removeClass("modal-xl");
        //                 break
        //             }
        //         }, error: function() {
        //             fn_toastShow("오류가 발생하였습니다.<br/>관리자에게 문의해주세요.");
        //         }
        //     });
        // });
    };

    /* ********************************************************
    * 함수명	: closeNewPopup()
    * 설명	: 모달 닫기
    * 인  자	: X
    *
    ******************************************************** */
    popupUtil.closeNewPopup = function()
    {
        // 모달 닫기
        let popup = bootstrap.Modal.getOrCreateInstance($("#modalScrollable"));
        let popup2 = bootstrap.Modal.getOrCreateInstance($("#modalScrollable2"));
        popup.hide();
        popup2.hide();

        // 모달 내용 지우기
        $("#modalScrollable").find(".modal-content").html("");
        $("#modalScrollable2").find(".modal-content").html("");
    };

    /* ********************************************************
    * 함수명	: closeNewPopupWithToast(str)
    * 설명	: 모달 닫은 후 토스트 표시
    * 인  자	: str
    *
    ******************************************************** */
    popupUtil.closeNewPopupWithToast = function(str)
    {
        // 모달 닫기
        popupUtil.closeNewPopup();

        // 토스트 표시
        fn_toastShow(str);
    };

    /* ********************************************************
    * 함수명	: closeNewPopupWithToast(str, function())
    * 설명	: 모달 닫은 후 토스트 표시 및 콜백 실행
    * 인  자	: str, function()
    *
    ******************************************************** */
    popupUtil.closeNewPopupWithToastAndReload = function(str, callback)
    {
        // 모달 닫기
        popupUtil.closeNewPopup();

        // 토스트 표시 및 콜백 실행
        fn_toastShowReload(str, callback);
    };
}