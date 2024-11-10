/*
* TG Solution 공통 Util Fuction
*
* FILE:	util.js
* VERSION:	1.0
* AUTHOR:	TG Solution 본부
*
* NOTE: This version is not tested thoroughly!
*
* Copyright (c) 2019, TG
* All rights reserved.
*
* << 개정이력(Modification Information) >>
*
*        수정일           수정자        	        수정내용
*  --------------    --------    ---------------------------
*  2019-03-13      유현종        최초 생성
*
*
* ======================================================================
*
*


/*===============================================
*
*     날짜 관련 Util 시작
*
*===============================================*/



/* ********************************************************
* 함수명	: js_today()
* 설명	: 오늘일자 가져오기
* 인  자	:
* 사용법	: 오늘일자(YYYY-MM-DD) 리턴
******************************************************** */
function js_today() {
    var today = new Date();
    var year = today.getFullYear();
    var mon = today.getMonth()+1;
    var sday = today.getDate();
    today = year +"-"+ (mon<10 ? "0"+""+mon : mon) +"-"+ (sday<10 ? "0"+""+sday : sday) ;

    return today;
}

/* ********************************************************
* 함수명	: js_hour()
* 설명	: 현재시간 가져오기
* 인  자	:
* 사용법	: 현재시간 (00) 리턴
******************************************************** */
function js_hour() {
	var today = new Date();
	var hour = today.getHours();

    if(hour < 10) hour = "0" + hour;

	return hour;
}

/* ********************************************************
* 함수명	: js_minutes()
* 설명	: 현재분 가져오기
* 인  자	:
* 사용법	: 현재분 (00) 리턴
******************************************************** */
function js_minutes() {
	var today = new Date();
	var minutes = today.getMinutes();

    if(minutes < 10) minutes = "0" + minutes;

    return minutes;
}

/* ********************************************************
* 함수명	: js_todayTime()
* 설명	: 오늘일시 가져오기
* 인  자	:
* 사용법	: 오늘일자(YYYY-MM-DD 24HH:MM:SS) 리턴
******************************************************** */
function js_todayTime()
{
    var today = new Date();
    //년
    var year = today.getYear();
    //월
    var month = today.getMonth()+1;
    if(month < 10) month = "0" + month;
    //일
    var day = today.getDate();
    if(day < 10) day = "0" + day;
    //시간
    var hour = today.getHours();
    if(hour < 10) hour = "0" + hour;
    //분
    var minutes = today.getMinutes();
    if(minutes < 10) minutes = "0" + minutes;
    //초
    var seconds = today.getSeconds();
    if(seconds < 10) seconds = "0" + seconds;

    var vDate = year;
    vDate = vDate + "/" + month;
    vDate = vDate + "/" + day;
    vDate = vDate + " " + hour;
    vDate = vDate + ":" + minutes;
    vDate = vDate + ":" + seconds;

    return vDate;
}


/* ********************************************************
* 함수명	: js_checkDate(ele)
* 설명	: 날짜 유효성 검증
* 인  자	: object
* 사용법	: 날짜 검증하여 true, false return
******************************************************** */
function js_checkDate(ele) {

    if(event.keyCode == 8 || event.keyCode == 46 ) // 백스페이스, 델키
        return true;
    if(event.keyCode >= 37 && event.keyCode < 41 ) // 방향키
        return true;

    var str = ele.value;

    str = js_delHyphen(str);	// /제거

    if(!js_checkFloat(str)) {
        showAlert("숫자만 입력 가능합니다.", "error");
        ele.value = "";
        return false;
    } else {
        if(event.keyCode != 8 ) {
            if (GetMsgLen(str) <= 4) ele.value = str ;
            if (GetMsgLen(str) == 5) ele.value = str.substring(0,4) + "-" + str.substring(4,5) ;
            if (GetMsgLen(str) == 6) {
                if(!js_yymmValid(str)) {
                    showAlert("유효하지 않은 연월입니다.", "error");
                    ele.value = "";
                } else {
                    ele.value = str.substring(0,4) + "-" + str.substring(4,6) ;
                }
            }

            if (GetMsgLen(str) == 7) ele.value = str.substring(0,4) + "-" + str.substring(4,6) + "-" + str.substring(6,7) ;
            if (GetMsgLen(str) == 8) {
                if(!js_dateValid(str)) {
                    showAlert("유효하지 않은 날짜입니다.", "error");
                    ele.value = "";
                } else {
                    ele.value = str.substring(0,4) + "-" + str.substring(4,6) + "-" + str.substring(6,8) ;
                }
            }
        }
    }
    return true;
}

/* ********************************************************
* 함수명	: js_yymmValid(iYymm)
* 설명	: 날짜 유효성 검증(년월)
* 인  자	: iYymm
* 사용법	: 날짜 검증하여 true, false return
******************************************************** */
function js_dateValid(iDate) {
    iDate = js_delHyphen(iDate);

    if( iDate.length != 8) {
        return false;
    }

    oDate = new Date();
    oDate.setFullYear(iDate.substring(0,4),iDate.substring(4,6)-1,iDate.substring(6) );

    var yy = iDate.substring(0,4);
    var mm = iDate.substring(4,6);
    if( mm.substring(0,1) == "0") mm = mm.substring(1);
    else mm;

    var dd = iDate.substring(6);
    if( dd.substring(0,1) == "0") dd = dd.substring(1);
    else dd;

    oMm = "";
    oMm = oDate.getMonth()+1;

    if(oDate.getFullYear() != parseInt(yy) || oMm != parseInt(mm) || oDate.getDate() != parseInt(dd) ) {
        return false;
    }

    return true;
}

/* ********************************************************
* 함수명	: js_yymmValid(iYymm)
* 설명	: 날짜 유효성 검증(년월)
* 인  자	: iYymm
* 사용법	: 날짜 검증하여 true, false return
******************************************************** */
function js_yymmValid(iYymm)
{
    iYymm = js_delHyphen(iYymm);

    if( iYymm.length != 6) {
        return false;
    }

    oDate = new Date();
    oDate.setFullYear(iYymm.substring(0,4), iYymm.substring(4,6)-1, 1);

    var yy = iYymm.substring(0,4);
    var mm = iYymm.substring(4,6);

    if( mm.substring(0,1) == "0")
        mm = mm.substring(1);
    else
        mm;

    oMm = "";
    oMm = oDate.getMonth()+1;
    if(oDate.getFullYear() != parseInt(yy) || oMm != parseInt(mm)) {
        return false;
    }

    return true;
}

/* ********************************************************
* 함수명	: fn_dateValid(iDate)
* 설명	: 날짜 유효성 검증(년월)
* 인  자	: iYymm
* 사용법	: 날짜 검증하여 true, false return
******************************************************** */
function fn_dateValid(iDate)
{
    iDate = fn_delHyphen(iDate);
    iDate = fn_delSlash(iDate);

    if( iDate.length != 8) {
        return false;
    }

    oDate = new Date();
    oDate.setFullYear(iDate.substring(0,4),iDate.substring(4,6)-1,iDate.substring(6));

    var yy = iDate.substring(0,4);
    var mm = iDate.substring(4,6);
    if( mm.substring(0,1) == "0")
        mm = mm.substring(1);
    else
        mm;

    var dd = iDate.substring(6);
    if( dd.substring(0,1) == "0")
        dd = dd.substring(1);
    else
        dd;

    oMm = "";
    oMm = oDate.getMonth()+1;

    if(oDate.getFullYear() != parseInt(yy)
            || oMm != parseInt(mm)
            || oDate.getDate() != parseInt(dd) ) {
        return false;
    }

    return true;
}

/* ********************************************************
* 함수명	: js_format()
* 설명	: 전달된 날짜 포맷팅
* 인  자	: dateString
* 사용법	: 오늘일자(YYYY-MM-DD) 리턴
******************************************************** */
function js_format(dateString) {
        var date = new Date(dateString);
        let month = date.getMonth() + 1;
        let day = date.getDate();
        let hour = date.getHours();
        let minute = date.getMinutes();
        let second = date.getSeconds();

        month = month >= 10 ? month : '0' + month;
        day = day >= 10 ? day : '0' + day;
        hour = hour >= 10 ? hour : '0' + hour;
        minute = minute >= 10 ? minute : '0' + minute;
        second = second >= 10 ? second : '0' + second;

        return date.getFullYear() + '-' + month + '-' + day + ' ' + hour + ':' + minute + ':' + second;
}

// /* ********************************************************
// * 함수명	: js_dateFormat(date, type)
// * 설명	: 날짜 정보 생성 (type :
// * 인  자	: date, type
// * 사용법	: 날짜 검증하여 type값의 형태로 return
// ******************************************************** */
// function js_dateFormat(date , type) {
//     date = js_delHyphen(date);
//     var ck;
//     var rtstr = "";
//     var j = 0;
//     for(var i = 0; i < type.length; i++) {
//         if(type.substring(i,i+1) == 'x') {
//             rtstr += date.substring(j,j+1);
//         } else {
//             j--;
//             rtstr += type.substring(i,i+1);
//         }
//         j++;
//     }
//     return rtstr;
// }

/* ********************************************************
* 함수명	: js_getDayInterval(time1, time2)
* 설명	: 두 Time이 며칠 차이나는지 구함
* 인  자	: time1, time2
* 사용법	:  1) getDayInterval('20050501','20050401');   ==>  '-29'  일
* 				2) getDayInterval('20050501','20050506');   ==>  '6'  일
******************************************************** */
function js_getDayInterval(time1,time2) {

   var date1 = js_toTimeObject(time1);
   var date2 = js_toTimeObject(time2);
   var day   = 1000 * 3600 * 24; //24시간

   return parseInt((date2 - date1) / day, 10) + 1;
}

/* ********************************************************
* 함수명	: js_toTimeObject(time)
* 설명	: Time 스트링을 자바스크립트 Date 객체로 변환  parameter time: Time 형식의 String
* 인  자	: time
* 사용법	: Time 스트링을 자바스크립트 Date 객체로 변환
*
******************************************************** */
function js_toTimeObject(time) {
	  // Time 스트링을 자바스크립트 Date 객체로 변환  parameter time: Time 형식의 String
	  var year  = time.substr(0,4);
	  var month = time.substr(4,2) - 1; // 1월=0,12월=11
	  var day   = time.substr(6,2);
	  var hour  = time.substr(8,2);
	  var min   = time.substr(10,2);
	  return new Date(year,month,day,hour,min);
}

/* ********************************************************
* 함수명	: js_beforeOneWeek()
* 설명	: 지난 1주일 이전 일자 가져오기
* 인  자	:
* 사용법	: 지난 1주일 이전 일자(YYYY-MM-DD) 리턴
******************************************************** */
function js_beforeOneWeek() {
	var nowDate = new Date();
	var weekDate = nowDate.getTime() - (7 * 24 * 60 * 60 * 1000);
	nowDate.setTime(weekDate);

	var weekYear = nowDate.getFullYear();
	var weekMonth = nowDate.getMonth() + 1;
	var weekDay = nowDate.getDate();

	var resultDay = weekYear + "-" + (weekMonth < 10 ? "0" + weekMonth : weekMonth) + "-" + (weekDay < 10 ? "0" + weekDay : weekDay);

	return resultDay;
}

/* ********************************************************
* 함수명	: js_beforeTwoWeek()
* 설명	: 지난 2주일 이전 일자 가져오기
* 인  자	:
* 사용법	: 지난 2주일 이전 일자(YYYY-MM-DD) 리턴
******************************************************** */
function js_beforeTwoWeek() {
	var nowDate = new Date();
	var weekDate = nowDate.getTime() - (14 * 24 * 60 * 60 * 1000);
	nowDate.setTime(weekDate);

	var weekYear = nowDate.getFullYear();
	var weekMonth = nowDate.getMonth() + 1;
	var weekDay = nowDate.getDate();

	var resultDay = weekYear + "-" + (weekMonth < 10 ? "0" + weekMonth : weekMonth) + "-" + (weekDay < 10 ? "0" + weekDay : weekDay);

	return resultDay;
}

/* ********************************************************
* 함수명	: js_beforeOneMonth()
* 설명	: 지난 1달 이전 일자 가져오기
* 인  자	:
* 사용법	: 지난 1달 이전 일자(YYYY-MM-DD) 리턴
******************************************************** */
function js_beforeOneMonth() {
	var nowDate = new Date();
	var monthDate = nowDate.getTime() - (30 * 24 * 60 * 60 * 1000);
	nowDate.setTime(monthDate);

	var monthYear = nowDate.getFullYear();
	var monthMonth = nowDate.getMonth() + 1;
	var monthDay = nowDate.getDate();

	var resultDay = monthYear + "-" + (monthMonth < 10 ? "0" + monthMonth : monthMonth) + "-" + (monthDay < 10 ? "0" + monthDay : monthDay);

	return resultDay;
}

/* ********************************************************
* 함수명	: js_beforeOneMonth()
* 설명	: 지난 6달 이전 일자 가져오기
* 인  자	:
* 사용법	: 지난 6달 이전 일자(YYYY-MM-DD) 리턴
******************************************************** */
function js_beforeSixMonth() {
	var nowDate = new Date();
	var monthDate = nowDate.getTime() - (180 * 24 * 60 * 60 * 1000);
	nowDate.setTime(monthDate);

	var monthYear = nowDate.getFullYear();
	var monthMonth = nowDate.getMonth() + 1;
	var monthDay = nowDate.getDate();

	var resultDay = monthYear + "-" + (monthMonth < 10 ? "0" + monthMonth : monthMonth) + "-" + (monthDay < 10 ? "0" + monthDay : monthDay);

	return resultDay;
}

/* ********************************************************
* 함수명	: js_beforeOneMonth()
* 설명	: 지난 1년 이전 일자 가져오기
* 인  자	:
* 사용법	: 지난 1년 이전 일자(YYYY-MM-DD) 리턴
******************************************************** */
function js_beforeOneYear() {
	var nowDate = new Date();
	var monthDate = nowDate.getTime() - (365 * 24 * 60 * 60 * 1000);
	nowDate.setTime(monthDate);

	var monthYear = nowDate.getFullYear();
	var monthMonth = nowDate.getMonth() + 1;
	var monthDay = nowDate.getDate();

	var resultDay = monthYear + "-" + (monthMonth < 10 ? "0" + monthMonth : monthMonth) + "-" + (monthDay < 10 ? "0" + monthDay : monthDay);

	return resultDay;
}

/* ********************************************************
 * 함수명	: js_afterOneMonth()
 * 설명	: 1달 이후 일자 가져오기
 * 인  자	:
 * 사용법	: 1달 이후 일자(YYYY-MM-DD) 리턴
 ******************************************************** */
function js_afterOneMonth() {
	var nowDate = new Date();
	var monthDate = nowDate.getTime() + (30 * 24 * 60 * 60 * 1000);
	nowDate.setTime(monthDate);

	var monthYear = nowDate.getFullYear();
	var monthMonth = nowDate.getMonth() + 1;
	var monthDay = nowDate.getDate();

	var resultDay = monthYear + "-" + (monthMonth < 10 ? "0" + monthMonth : monthMonth) + "-" + (monthDay < 10 ? "0" + monthDay : monthDay);

	return resultDay;
}

/* ********************************************************
* 날짜 년,월,일별 하이픈(-) 자동 삽입
******************************************************** */
function js_autoYMDHyphen( ty, e, oThis ) {
	var num_arr = [
		96, 97, 98, 99, 100, 101, 102, 103, 104, 105,
		48, 49, 50, 51, 52, 53, 54, 55, 56, 57
		];

	var key_code = ( e.which ) ? e.which : e.keyCode;

	js_checkDate(oThis);

	if( num_arr.indexOf( Number( key_code ) ) != -1 ) {
		var len = oThis.value.length;
		if(ty != 'Y'){
			if( len == 4 ) oThis.value += "-";
		}
		if(ty != 'M'){
			if( len == 7 ) oThis.value += "-";
		}
	}
}

/* ********************************************************
* DESCRIPTION	:	date check
* Return Value	:   ''
******************************************************** */
function js_ymdChk(ty, $obj){
	var datePattern = '';
	if(ty == 'D'){
		datePattern = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/;
	}else if(ty == 'M'){
		datePattern = /^(19|20)\d{2}-(0[1-9]|1[012])$/;
	}else if(ty == 'Y'){
		datePattern = /^(19|20)\d{2}$/;
	}
	var bool = false;
	if($obj.value == undefined){
		$obj.value = $obj.val();
		bool = true;
	}
	if(!datePattern.test($obj.value)){
		$($obj).val('').trigger("change");
		if(bool) $obj.val('');
		return false;
	}
	return true;
}


/* ********************************************************
* 메세지 길이 제한
*  0-127 1byte, 128~ 2byte
******************************************************** */
function GetMsgLen(sMsg) {
    var count = 0
    for ( var i = 0; i < sMsg.length; i++) {
        if (sMsg.charCodeAt(i) > 127) {
            count += 2
        } else {
            count++
        }
    }
    return count
}

/* ********************************************************
 * 시작일 종료일 비교
 * param : 시작날짜, 종료날짜, 경고창에 표시할 메시지
 * 사용법 : 시작할때 param 입력해서 호출
 ******************************************************** */
function js_dateChk(bgnDateVal, endDateVal, msg) {

	var bgnArray = bgnDateVal.split("-");
	var endArray = endDateVal.split("-");

	var bdate = new Date(bgnArray[0], bgnArray[1], bgnArray[2]);
	var edate = new Date(endArray[0], endArray[1], endArray[2]);

	if (bdate.getTime() > edate.getTime()) {
		showAlert(msg, "warning");
		return false;
	}

	return true;
}

/* ********************************************************
 * 날짜검색 유효성체크
 * param : 시작날짜 오브젝트ID, 종료날짜 오브젝트ID, 경고창에 표시할 메시지
 * 사용법 : 시작할때 param 입력해서 호출
 ******************************************************** */
function js_schDateCheck(bgnId, endId, msg) {
	$(".datepicker").on('change', function() {
		if($("#"+bgnId).val() != '' && $("#"+endId).val() != '') {
			if($("#"+bgnId).val() > $("#"+endId).val()) {
				showAlert(msg, "warning");
				$("#"+bgnId).val('');
				$("#"+endId).val('');
			}
		}
	})
}

/* ********************************************************
 * 날짜검색 유효성체크
 * param : 시작날짜 오브젝트ID, 종료날짜 오브젝트ID, 경고창에 표시할 메시지
 * 사용법 : 시작할때 param 입력해서 호출
 ******************************************************** */
function js_schMonthCheck(bgnId, endId, msg) {
	$(".monthpicker").on('change', function() {
		if($("#"+bgnId).val() != '' && $("#"+endId).val() != '') {
			if($("#"+bgnId).val() > $("#"+endId).val()) {
				showAlert(msg, "warning");
				$("#"+bgnId).val('');
				$("#"+endId).val('');
			}
		}
	})
}

/* ********************************************************
 * 날짜검색 유효성체크
 * param : 시작날짜 오브젝트ID, 종료날짜 오브젝트ID, 경고창에 표시할 메시지
 * 사용법 : 시작할때 param 입력해서 호출
 ******************************************************** */
function js_schYearCheck(bgnId, endId, msg) {
	$(".yearpicker").on('change', function() {
		if($("#"+bgnId).val() != '' && $("#"+endId).val() != '') {
			if($("#"+bgnId).val() > $("#"+endId).val()) {
				showAlert(msg, "warning");
				$("#"+bgnId).val('');
				$("#"+endId).val('');
			}
		}
	})
}

/* ********************************************************
 * 날짜검색 1주일, 2주일, 1개월 버튼 클릭 이벤트
 * param : 시작날짜 오브젝트ID, 종료날짜 오브젝트ID, 조회기간(oneWeek : 1주일, twoWeek : 2주일, oneMonth : 1개월)
 * 사용법 : 시작할때 param 입력해서 호출
 ******************************************************** */
function js_setDate(bgnId, endId, period) {
	if(period == "today") {
		$("#" + bgnId).val(js_today());
	} else if(period == "oneWeek") {
		$("#" + bgnId).val(js_beforeOneWeek());
	} else if(period == "twoWeek") {
		$("#" + bgnId).val(js_beforeTwoWeek());
	} else if(period == "oneMonth") {
		$("#" + bgnId).val(js_beforeOneMonth());
	} else if(period == "sixMonth") {
		$("#" + bgnId).val(js_beforeSixMonth());
	} else if(period == "oneYear") {
		$("#" + bgnId).val(js_beforeOneYear());
	}
	$("#" + endId).val(js_today());
}