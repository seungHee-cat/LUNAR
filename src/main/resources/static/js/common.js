/* ********************************************************
 * Ajax Submit Form을 Ajax로 보낸다.
 * callback은 JSON 만 받는다.
 * jQuery가 필요하다
 * formId : 값이 존재하는 대상 form의 Id
 * url : 주소
 * callBack : 완료후 리턴함수, 파라미터로 수행결과 JSON을 전달한다.
 * isMultipart : 멀티파트(파일전송) 방식 사용 여부
 ******************************************************** */
function fn_ajaxSubmit(formId, url, callBack, isMultipart) {
    $('button').attr('disabled', true);

    js_loadingStart();

    // 멀티파트는 fn_ajaxFileSubmit 호출
    if (isMultipart === true) {
        fn_ajaxFileSubmit(formId, url, callBack);
        return false;
    }

    let srcFrm = $("#" + formId);
    let params = new FormData(srcFrm[0]);

    jQuery.ajax({
        url: url
        , type: "POST"
        , data: params
        , dataType: "json"
        , contentType: false
        , processData: false
        , success: function (data) {
            js_loadingEnd();
            callBack(data);
            $('button').attr('disabled', false);
        }, error: function (jqXHR, textStatus, errorThrown) {
            try {
                let json = JSON.parse(jqXHR.responseText);
                console.error(json);
            } catch (e) {
                console.error(e);
            }

            if (jqXHR.status !== 200 && jqXHR.status !== "200") {
                fn_toastShow("오류가 발생하였습니다.<br/>관리자에게 문의해주세요.");
            } else {
                fn_toastShow("잘못된 접근입니다.");
            }
            $('button').attr('disabled', false);
            js_loadingEnd();
        }
    });
}

/* ********************************************************
* 함수명	: fn_ajaxFileSubmit
* 설명	: 파일 Form Submit
* 인  자	: formId, url, callBack
* 사용법	:
******************************************************** */
function fn_ajaxFileSubmit(formId, url, callBack) {

    let uploadFileList = Object.keys(fileList);
    let uploadCtlList = Object.keys(fileCtlList);

    //첨부파일 총 용량 확인
    if (totalFileSize > maxUploadSize) {
        showAlert("전체 파일의 총 용량이 초과되었습니다.\n총 업로드 가능 용량 : " + maxUploadSize + " Mb", "error");
        return;
    }

    let form = $("#" + formId);
    let formData;

    //브라우저 확인
    let agent = navigator.userAgent.toLowerCase();

    //크롬브라우저 일경우
    if (agent.indexOf("chrome") !== -1) {
        formData = new FormData(form[0]);
    } else {
        formData = new FormData(form);
    }

    let atchFileIdNameList = new Array();

    for (let i = 0; i < uploadCtlList.length; i++) {
        if (uploadCtlList[i] !== '') {
            formData.append(fileCtlList[uploadCtlList[i]], fileList[uploadCtlList[i]]);

            if ($.inArray(fileCtlList[uploadCtlList[i]], atchFileIdNameList) < 0) {
                formData.append("atchFileIdNameList", fileCtlList[uploadCtlList[i]]);
                formData.append("atchFileIdValueList", $("#" + fileCtlList[uploadCtlList[i]]).val());

                //Server path정보 찾기
                $("input[name='paramAtchFileId']").each(function () {
                    if ($(this).val() == fileCtlList[uploadCtlList[i]]) {
                        formData.append("atchFilePathList", $(this).parent().find("#serverPath").val());
                        return false;
                    }
                })

                atchFileIdNameList.push(fileCtlList[uploadCtlList[i]]);
            }
        }
    }

    //삭제 파일 List 처리
    for (let i = 0; i < delAtchFileIdList.length; i++) {
        formData.append("delAtchFileIdList", delAtchFileIdList[i]);
        formData.append("delPageKeyIdList", delPageKeyIdList[i]);
        formData.append("delFileSnList", delFileSnList[i]);
    }

    let atchFileUrl = "";
    if (document.getElementById("was_start_path") == null)
        atchFileUrl = "/com/file/ComFileMergeAjax.do";
    else
        atchFileUrl = $("#was_start_path").val() + "/com/file/ComFileMergeAjax.do";

    $.ajax({
        url: atchFileUrl
        , type: "POST"
        , data: formData
        , dataType: "json"
        , enctype: 'multipart/form-data'
        , encoding: 'multipart/form-data'
        , processData: false
        , contentType: false
        , cache: false
        , success: function (result) {
            //생성된 첨부파일 Key 넣기
            for (let i = 0; i < atchFileIdNameList.length; i++) {
                $("#" + atchFileIdNameList[i]).val(result[atchFileIdNameList[i]]);
            }

            $.ajax({
                url: url
                , type: "POST"
                , data: form.serialize()
                , dataType: "json"
                , success: function (data) {
                    js_loadingEnd();
                    $('button').attr('disabled', false);

                    //첨부파일영역 삭제
                    $("#" + formId + " div[name='dropZone']").each(function () {
                        $(this).html('');
                    });

                    callBack(data);
                }, error: function (jqXHR, textStatus, errorThrown) {
                     try {
                        let json = JSON.parse(jqXHR.responseText);
                        console.error(json);
                    } catch (e) {
                        console.error(e);
                    }

                    if (jqXHR.status !== 200 && jqXHR.status !== "200") {
                        fn_toastShow("오류가 발생하였습니다.<br/>관리자에게 문의해주세요.");
                    } else {
                        fn_toastShow("잘못된 접근입니다.");
                    }
                    $('button').attr('disabled', false);
                    js_loadingEnd();
                }
            });
        }
    });
}

/* ********************************************************
* DESCRIPTION	:	Ajax 서버 정보 호출
* Parameter	    :	url, params, divName
* Return Value	:   data
******************************************************** */

function fn_ajaxView(url, params, divName) {
    $.ajax({
        url: url
        , type: "GET"
        , data: params
        , dataType: "html"
		, processData: false
    	, contentType: false
        , success: function (data) {
            $("#"+divName).empty();
            $("#"+divName).append( data );
        }, error: function() {
            fn_toastShow("오류가 발생하였습니다.<br/>관리자에게 문의해주세요.");
        }
    });
}


/* ********************************************************
* DESCRIPTION	:	Ajax 서버 정보 호출 (POST)
* Parameter	    :	formId, url, divName
* Return Value	:   data
******************************************************** */
function fn_ajaxFrmView(formId, url, divName) {
    let srcFrm = $("#" + formId);
    let params = new FormData(srcFrm[0]);

    $.ajax({
        url: url
        , type: "POST"
        , data: params
        , dataType: "html"
		, processData: false
    	, contentType: false
        , success: function (data) {
            $("#" + divName).empty();
            $("#" + divName).append(data);
        }, error: function () {
            fn_toastShow("오류가 발생하였습니다.<br/>관리자에게 문의해주세요.");
        }
    });
}

/* ********************************************************
* DESCRIPTION	:	Ajax 서버 정보 호출 (POST)
* Parameter	    :	formId, url, divName
* Return Value	:   data
******************************************************** */
function fn_ajaxFrmJson(formId, url, callBack) {
    let srcFrm = $("#" + formId);
    let params = new FormData(srcFrm[0]);

    $.ajax({
        url: url
        , type: "POST"
        , data: params
        , dataType: "json"
		, processData: false
    	, contentType: false
        , success: function (data) {
            callBack(data);
        }, error: function () {
            fn_toastShow("오류가 발생하였습니다.<br/>관리자에게 문의해주세요.");
        }
    });
}