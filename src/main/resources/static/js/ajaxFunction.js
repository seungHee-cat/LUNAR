/* -------------------------------------------------------
 * name : fn_ajaxFormSubmit
 * description : ajax 전송 값을 서버에 보내고 콜백 함수를 처리한다.
------------------------------------------------------- */
function fn_ajaxFormSubmit(formId, url, callBack) {
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
                fn_showToastMessage("An error has occurred.<br/>Please contact the administrator.");
            } else {
                fn_showToastMessage("Invalid access.");
            }
            $('button').attr('disabled', false);
        }
    });
}

/* -------------------------------------------------------
 * name : fn_ajaxRoadDiv
 * description : ajax 전송 값을 서버에 보내고 divName에 출력한다.
------------------------------------------------------- */

function fn_ajaxRoadDiv(url, params, divName) {
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
        }, error: function(data) {
            fn_showToastMessage("An error has occurred.<br/>Please contact the administrator.");
        }
    });
}

/* -------------------------------------------------------
 * name : fn_ajaxSearchView
 * description : ajax 전송 값을 통해 영화 검색 정보를 출력한다.
------------------------------------------------------- */
function fn_ajaxSearchView(formId, url, divName) {
    let srcFrm = $("#" + formId);
    let params = srcFrm.serialize();
    let searchDiv = $("#" + divName);
    let searchUl = searchDiv.find(".search-ul");

    $.ajax({
        url: url
        , type: "GET"
        , data: params
        , dataType: "json"
        , success: function (data) {
            let html = '';
            if(data.length > 0){
                html += '<li class="pt-3" id="relatedSearch">Related search terms</li>';
                $.each(data, function (index, movie) {
                    html += '<li class="search-movie" data-movie-id="' + movie.movieId + '">' + movie.title + '</li>';
                });
            }
            searchUl.html(html);
            searchUl.removeClass('search-hide');

        }, error: function () {
            searchUl.addClass('search-hide');
            fn_showToastMessage("An error has occurred.<br/>Please contact the administrator.");
        }
    });
}
