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
*     문자열 관련 Util 시작
*
*===============================================*/

/* ********************************************************
* 함수명	: js_delString(str, val)
* 설명	: 특정 문자 (val)을 제거
* 인  자	: String
* 사용법	: 2011 05-01일 경우 20110501을 리턴
*         
******************************************************** */
function js_delString(str, val) {

    if (str.length < 1) {
        return "";
    } else {
        var st = "";
        var sp = val;
        for (var i = 0; i < str.length; i++) {
            if (sp.indexOf(str.substring(i, i + 1)) == -1) {
                st += str.substring(i, i + 1);
            }
        }
        return st;
    }
}

/* ********************************************************
* 함수명	: js_insHyphen(obj)
* 설명	: 날짜에 '-' 자동 삽입
* 인  자	: String
* 사용법	: 20110501 일 경우 2011-05-01을 리턴
*         
******************************************************** */
function js_insHyphen(obj){
	
	var str = obj.value.replace(/[^0-9]/g, '');
	
	var tmp = '';
	if( str.length < 4){
		return;
	}else if(str.length < 7){
		tmp += str.substr(0, 3);
		tmp += '-';
		tmp += str.substr(3);
		obj.value = tmp;
	}else if(str.length < 11){
		tmp += str.substr(0, 3);
		tmp += '-';
		tmp += str.substr(3, 3);
		tmp += '-';
		tmp += str.substr(6);
		obj.value = tmp;
	}else{				
		tmp += str.substr(0, 3);
		tmp += '-';
		tmp += str.substr(3, 4);
		tmp += '-';
		tmp += str.substr(7);
		obj.value = tmp;
	}
}

/* ********************************************************
* 함수명	: js_delHyphen(str)
* 설명	: 문자열에서 '-' 삭제
* 인  자	: String
* 사용법	: 2011-05-01 일 경우 20110501을 리턴
*         
******************************************************** */
function js_delHyphen(str) {
	
    if (str.length < 1) {
        return "";
    } else {
        var st = "";
        var sp = "-";
        for (var i = 0; i < str.length; i++) {
            if (sp.indexOf(str.substring(i, i + 1)) == -1) {
                st += str.substring(i, i + 1);
            }
        }
        return st;
    }
}

/* ********************************************************
* 함수명	: js_delSlash(str)
* 설명	: 문자열에서 '/' 삭제
* 인  자	: String
* 사용법	: 2011/05/01 일 경우 20110501을 리턴
*         
******************************************************** */
function js_delSlash(str) {

    if (str.length < 1) {
        return "";
    } else {
        var st = "";
        var sp = "/";
        for (var i = 0; i < str.length; i++) {
            if (sp.indexOf(str.substring(i, i + 1)) == -1) {
                st += str.substring(i, i + 1);
            }
        }
        return st;
    }
}

/* ********************************************************
* 함수명	: js_filterBlank(str)
* 설명	: 문자열에서 ' ' 제거
* 인  자	: String
* 사용법	: 2011 05 01 일 경우 20110501을 리턴
*         
******************************************************** */
function js_filterBlank(str)
{
    re = /(^\s*)|(\s*$)/g;
    return str.replace(re, "");
}

/* ********************************************************
* 함수명	: js_imeMode(ele, gbn)
* 설명	: 한글영뭄모드 전환 
* 인  자	: String
* 사용법	: 2011 05 01 일 경우 20110501을 리턴
*         
******************************************************** */
function js_imeMode(ele, gbn){
    if(gbn = 2)
        ele.style.imeMode = "inactive";  	// 영문 모드
    else if(gbn=3)
        ele.style.imeMode =  "disabled";  	// 영문 모드만 가능
    else
        ele.style.imeMode = "active";  		// 한글 모드
}

/* ********************************************************
* 함수명	: js_imeMode(ele, gbn)
* 설명	: 한글영뭄모드 전환 arg1 : 앞자리, arg2 : 뒷자리 
* 인  자	: String
* 사용법	: 
*         
******************************************************** */
function js_isSocSecNum(arg1, arg2) {
    var num = 2;
    var sum = 0;

    for(var i = 0; i < arg1.length; i++)
        sum += parseInt(arg1.substr(i, 1)) * num++;

    for (var j = 0; j < arg2.length - 1; j++) {
        sum += parseInt(arg2.substr(j, 1)) * num++;
        if (num == 10) num = 2;
    }

    var count = 11 - sum % 11;
    if (count == 11) count = 1;
    if (count == 10) count = 0;
    if (count != parseInt(arg2.substr(6, 1))) return false;
    else return true;
}

/* ********************************************************
* 함수명	: js_imeMode(ele, gbn)
* 설명	: 사업자번호 검증 
* 인  자	: String
* 사용법	: 사업자번호 검증하여 true, false returen
*         
******************************************************** */
function js_checkbizId( bizId )  {
    // bizId는 숫자만 10자리로 해서 문자열로 넘긴다.
    var checkID = new Array(1, 3, 7, 1, 3, 7, 1, 3, 5, 1);
    var i, chkSum=0, c2, remander;

    for (i=0; i<=7; i++)
        chkSum += checkID[i] * bizId.charAt(i);

    c2 = "0" + (checkID[8] * bizId.charAt(8));
    c2 = c2.substring(c2.length - 2, c2.length);

    chkSum += Math.floor(c2.charAt(0)) + Math.floor(c2.charAt(1));

    remander = (10 - (chkSum % 10)) % 10 ;

    if (Math.floor(bizId.charAt(9)) == remander) return true;   // OK!
        return false;                                           // FALSE~!
}

/* ********************************************************
* 함수명	: js_checkSpecial(str)
* 설명	: 특수문자 필터링
* 인  자	: str
* 사용법	: 입력값의 특수문자 filtering 하여 값 return
*         
******************************************************** */
function js_checkSpecial(str) {
		
	return (str.trim().match(/[!^$%\"\'&\\]/g)) ? false : true;
	
}

/* ********************************************************
* 함수명	: js_isEmpty(str)
* 설명	: 빈값 체크 return Boolean
* 인  자	: str
* 사용법	: 입력값의 비어있는지 체크하여 값 return
*         
******************************************************** */
function js_isEmpty(str) {
	return (typeof str == null || str == undefined || str == '') ? true : false;
}

/* ********************************************************
* 함수명	: js_emptyProc(str)
* 설명	: 빈값 체크 return String
* 인  자	: str
* 사용법	: 입력값의 비어있는지 체크하여 값 return
*         
******************************************************** */
function js_emptyProc(str) {
	return (typeof str == null || str == undefined || str == '') ? '' : str;
}

/* ********************************************************
* 함수명	: js_byteCheck(param, size)
* 설명	: 빈값 체크 return String
* 인  자	: 문자, 숫자
* 사용법	: 엘리먼트와 제한할 byte크기를 받아 
* 			  해당 byte크기를 넘어서면 Alert창과 함께 해당 byte 길이로 값 셋팅
*         
******************************************************** */
function js_byteCheck(param, size) {
	var totalBytes = 0;
	var stdrIdx = 0;
	var tmpVal = false;
	
	for(var i=0; i<param.value.length; i++) {
		var tmpChar = param.value.charCodeAt(i);
		(tmpChar > 127) ? totalBytes += 3 : totalBytes++;
		
		if (totalBytes == size) {
			stdrIdx = i;
		} else if (totalBytes > size && !tmpVal) {
			stdrIdx = i-1;
			tmpVal = true;
		}
	}
	
	if (totalBytes > size) {
		showAlert("한글은 " + Math.floor(size/3) +"글자, 영문은 " + size + "글자 내로 입력하시기 바랍니다.", 'warning');
		$(param).val(param.value.substring(0, stdrIdx+1));
	}
}

/*===============================================
*     문자열 관련 Util 종료
*===============================================*/

