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
*     숫자 관련 Util 시작
*
*===============================================*/

/* ********************************************************
* 함수명	: js_filterNum(str)
* 설명	: 문자열에서 ',' 제거
* 인  자	: String
* 사용법	: 1,234,567일 경우 1234567을 리턴
*
******************************************************** */
function js_filterNum(str) {
    re = /^\$|,/g;
    return str.replace(re, "");
}


/* ********************************************************
* 함수명	: js_checkNumber(str)
* 설명	: 문자열이 숫자인지 확인
* 인  자	: String
* 사용법	: 파라미터값이 숫자인지 판단하여 true, false return
*
******************************************************** */
function js_checkNumber(str) {
    var flag=true;
    if (str.length > 0) {
        for (i = 0; i < str.length; i++) {
            if (str.charAt(i) < '0' || str.charAt(i) > '9') {
                flag=false;
            }
        }
    }
    return flag;
}

/* ********************************************************
* 함수명	: js_checkCommaNumber(ele)
* 설명	: 숫자 정합성 확인(',' 제거 후 숫자 유효성검증)
* 인  자	: 숫자값을 포함하는 Object
* 사용법	: 파라미터값이 숫자인지 판단하여 true, false return
*
******************************************************** */
function js_checkCommaNumber(ele) {
    str = ele.value;
    str = js_filterNum(str); //콤마제거
    if(!js_checkNumber(str)) {
        ele.value=js_numberData(str, 'N', 'N');
        return false;
    }
    return true;
}

/* ********************************************************
* 함수명	: js_addCommaNumber(ele)
* 설명	: 숫자(정수) 정합성 확인 후 이상없을 시 숫자에 ','삽입하여 리턴
* 인  자	: 숫자값을 포함하는 Object
* 사용법	: 파라미터값이 숫자인지 판단하여 true, false return
*
******************************************************** */
function js_addCommaNumber(ele) {
    str = ele.value;
    str = js_filterNum(str);
    if(!js_checkNumber(str)) {
        str = js_numberData(str, 'N', 'N');
        ele.value = js_commaSplit(str);
        return false;
    } else {
        var numStr;
        if(str == "" || str == null)
            numStr = "";
        else
         numStr = parseInt(str);
        ele.value = js_commaSplit(numStr);
    }
    return true;
}

/* ********************************************************
* 함수명	: js_addCommaNumber(ele)
* 설명	: 숫자(정수) 정합성 확인 후 이상없을 시 숫자에 ','삽입하여 리턴
* 인  자	: 숫자값을 포함하는 Object
* 사용법	: 파라미터값이 숫자인지 판단하여 true, false return
*
******************************************************** */
function js_addNumber(ele) {
    str = ele.value;
    str = js_filterNum(str);
    if(!js_checkNumber(str)) {
        str = js_numberData(str, 'N', 'N');
        ele.value = str;
        return false;
    } else {
        var numStr;
        if(str == "" || str == null)
            numStr = "";
        else
         numStr = parseInt(str);
        ele.value = numStr;
    }
    return true;
}


/* ********************************************************
* 함수명	: js_checkFloat(str)
* 설명	: 숫자(실수) 정합성 확인
* 인  자	: String
* 사용법	: 파라미터값이 숫자인지 판단하여 true, false return
*
******************************************************** */
function js_checkFloat(str) {
    var flag=true;
    var hasDot = false;
    if (str.length > 0) {
        for (i = 0; i < str.length; i++) {
            if ( (str.charAt(i) < '0' || str.charAt(i) > '9') && str.charAt(i) != '.' && str.charAt(i) != '-') {
                flag=false;
                js_numberData(str, 'N', 'Y');
                break;
            } else if(hasDot && str.charAt(i) == '.') {
            	flag=false;
            	js_numberData(str, 'N', 'Y');
                break;
            }

            if(str.charAt(i) == '.') {
            	hasDot = true;
            }
        }
    }
    return flag;
}


/* ********************************************************
* 함수명	: js_addCommaFloat(ele)
* 설명	: 숫자(실수) 정합성 확인 후 이상없을 시 숫자에 ','삽입하여 리턴
* 인  자	: 숫자값을 포함하는 Object
* 사용법	: 파라미터값이 숫자인지 판단하여 true, false return
*
******************************************************** */
function js_addCommaFloat(ele) {
    str = ele.value;
    str = js_filterNum(str);
    if(!js_checkFloat(str)) {
        str = js_numberData(str, 'N', 'Y');
        ele.value = js_commaSplit(str);
        return false;
    } else {
        ele.value = js_commaSplit(str);
    }
    return true;
}

/* ********************************************************
* 함수명	: js_checkFloatLimit(ele, limitCntUnderPoint)
* 설명	: 숫자(실수) 정합성 확인(소수 특정 자리까지 확인) 후 이상없을 시 숫자에 ','삽입하여 리턴
* 인  자	: 숫자값을 포함하는 Object
* 사용법	: 파라미터값이 숫자인지 판단하여 true, false return
*
******************************************************** */
function js_checkFloatLimit(ele, limitCntUnderPoint) {

	 str = ele.value;
	 str = js_filterNum(str);
	 if(!js_checkFloat(str)) {
		 showAlert("숫자만 입력 가능합니다.", "warning");
		 str=js_numberData(str, 'N', 'Y');
		 ele.value = js_commaSplit(str);
		 return false;
	 } if(str.indexOf(".") > -1 && (limitCntUnderPoint || limitCntUnderPoint == 0 )) {
		 var arr = str.split(".");
		 if(arr[1].length > limitCntUnderPoint) {
			showAlert("소수점 이하 " + limitCntUnderPoint + "자리만 입력 가능합니다.", "warning");
	    	var valueStr = arr[0] + "." + arr[1].substr(0,limitCntUnderPoint);
	    	ele.value=js_commaSplit(valueStr);
	    	return false;
	    }
	 }
	 ele.value = js_commaSplit(str);
	 return true;


}

/* ********************************************************
* 함수명	: js_numberData(str, minusYn, floatYn)
* 설명	: 입력된 값에서 숫자만 추출
* 인  자	: 숫자값, 마이너스 여부, 실수여부
* 사용법	: 숫자 값
*
******************************************************** */
function js_numberData(str, minusYn, floatYn) {
    // 공백제거
    str = js_filterBlank(str);
    value = "";

    if(str.length > 0) {
        if(minusYn == 'Y' && floatYn == 'Y') {
            for ( inx=0; inx < str.length; inx++ ) {
                if (( str.charAt(inx) >= '0' && str.charAt(inx) <= '9') || str.charAt(inx) == '-' || str.charAt(inx) == '.' )
                    value = value + str.charAt(inx);
            }
        } else if(minusYn == 'N' && floatYn == 'Y') {
        	var hasDot = false;
            for (inx=0; inx < str.length; inx++) {
                if (( str.charAt(inx) >= '0' && str.charAt(inx) <= '9') || (!hasDot && str.charAt(inx) == '.')) {
                	value = value + str.charAt(inx);
                    if(str.charAt(inx) == '.') {
                    	hasDot = true;
                    }
                }
            }
        } else if(minusYn == 'Y' && floatYn == 'N' ) {
            for (inx=0; inx < str.length; inx++) {
                if (( str.charAt(inx) >= '0' && str.charAt(inx) <= '9') || str.charAt(inx) == '-')
                    value = value + str.charAt(inx);
            }
        } else {
            for (inx=0; inx < str.length; inx++) {
                if (( str.charAt(inx) >= '0' && str.charAt(inx) <= '9'))
                    value = value + str.charAt(inx);
            }
        }
    }
    return value;
}


/* ********************************************************
* 함수명	: js_commaSplit(srcNumber)
* 설명	: 입력된 값에 콤마 삽입
* 인  자	: 숫자값
* 사용법	: 숫자값(콤마 삽입)
*
******************************************************** */
function js_commaSplit(srcNumber)
{
    if(srcNumber.length <= 0) return '';

    var txtNumber = '' + srcNumber;

    var rxSplit = new RegExp('([0-9])([0-9][0-9][0-9][,.])');
    var arrNumber = txtNumber.split('.');
    arrNumber[0] += '.';
    do {
        arrNumber[0] = arrNumber[0].replace(rxSplit, '$1,$2');
    }
    while (rxSplit.test(arrNumber[0]));
    if (arrNumber.length > 1) {
        return arrNumber.join('');
    } else {
        return arrNumber[0].split('.')[0];
    }
}

/* ********************************************************
* 함수명	: js_checkTelNumber(ele)
* 설명	: 전화번호 체크 함수 (숫자와 '-' 허용)
* 인  자	: Object
******************************************************** */
function js_checkTelNumber(ele) {
	var str = ele.value;
	var flag=true;

	if (str.length > 0) {
		for (i = 0; i < str.length; i++) {
			if (str.charAt(i) < '0' || str.charAt(i) > '9') {
				if(str.charAt(i) == '-'){
					flag = true;
				} else {
					flag = false;
					ele.value = fn_NumberData(str, 'Y', 'N');
				}
			}
		}
	}
	return flag;
}

/* ********************************************************
* 숫자만 추출
******************************************************** */
function fn_NumberData(str, minusYn, floatYn) {
    // 공백제거
    str = fn_filterBlank(str);
    value = "";
    if(str.length > 0) {

        if(minusYn == 'Y' && floatYn == 'Y') {
            for ( inx=0; inx < str.length; inx++ ){
                if ( ( str.charAt(inx) >= '0' && str.charAt(inx) <= '9') || str.charAt(inx) == '-' || str.charAt(inx) == '.' )
                    value = value + str.charAt(inx);
            }
        }
        else if(minusYn == 'N' && floatYn == 'Y') {
        	var hasDot = false;
            for ( inx=0; inx < str.length; inx++ ){
                if ( ( str.charAt(inx) >= '0' && str.charAt(inx) <= '9') || (!hasDot && str.charAt(inx) == '.') )
                {
                	value = value + str.charAt(inx);
                    if(str.charAt(inx) == '.')
                    {
                    	hasDot = true;
                    }
                }
            }
        }
        else if(minusYn == 'Y' && floatYn == 'N' ) {
            for ( inx=0; inx < str.length; inx++ ){
                if ( ( str.charAt(inx) >= '0' && str.charAt(inx) <= '9') || str.charAt(inx) == '-' )
                    value = value + str.charAt(inx);
            }
        }
        else {
            for ( inx=0; inx < str.length; inx++ ){
                if ( ( str.charAt(inx) >= '0' && str.charAt(inx) <= '9') )
                    value = value + str.charAt(inx);
            }
        }

    }
    return value;
}

/* ********************************************************
* 공백제거
******************************************************** */
function fn_filterBlank(str)
{
    re = /(^\s*)|(\s*$)/g;
    return str.replace(re, "");
}

/* ********************************************************
* IP체크
******************************************************** */
function fn_checkIpNumber(obj) {
	var str = obj.value;
	var flag = true;

	if (str.length > 0) {
		for (i = 0; i < str.length; i++) {
			if (str.charAt(i) < '0' || str.charAt(i) > '9') {
				if(str.charAt(i) == '.'){
					flag = true;
				} else {
					showAlert("' 숫자 ' 또는 ' . '만 입력가능합니다. ", "warning", function() {
						$("#serIp").focus();
					});
					flag = false;
					obj.value = fn_NumberData(str, 'Y', 'N');
				}
			}
		}
	}
	return flag;
}
/*===============================================
*     숫자 관련 Util 종료
*===============================================*/
