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
* ======================================================================
*/

/*===============================================
*
*     Form 관련 Util 시작
*
*===============================================*/

/* ********************************************************
* 함수명	: js_uriString(url, param)
* 설명	: url에서 특정 parameter값의 value를 추출
* 인  자	: url, param
* 사용법	: url파라메터에서 param의 값 return
*
******************************************************** */
function js_uriString(url, param) {
    var QuerySplit = url.split('?');
    var ResultQuer = QuerySplit[1] ? QuerySplit[1].split('&') : '';

    for (var i = 0; i < ResultQuer.length; i++)  {
        var keyval = ResultQuer[i].split('=');
        if (param == keyval[0]) return keyval[1];
    }
    return "";
}

/* ********************************************************
* 함수명	: js_checkByteLength(str, limitBytes)
* 설명	: 입력문자의 최대 Byte초과 여부
* 인  자	: str, limitBytes
* 사용법	: 입력문자의 Byte길이를 측정하여 최대 허용치 초과여부 return
*
******************************************************** */
function js_checkByteLength(str, limitBytes) {
	var byteLen = 0;
	for(i=0; i<str.length; i++) {
		if(str.charCodeAt(i) > 255 ){ byteLen += 3; }else{ byteLen ++; }
		if(byteLen > limitBytes){ return false; }
	}

    try {
    	var x = document.getElementById('remLen');
    	x.innerHTML = byteLen+"/4096 Byte &nbsp;";
	} catch (e) {byteLen = 0;}

	return true;
}

/* ********************************************************
* 함수명	: js_cutString(str, limitBytes)
* 설명	: 입력문자의 최대 Byte초과시 문자열을 cutting하여 return
* 인  자	: str, limitBytes
* 사용법	: 입력문자의 Byte길이를 측정하여 최대 허용치 문자열 return
*
******************************************************** */
function js_cutString(str, limitBytes) {
	var byteLen = 0;
	for(i=0; i<str.length; i++) {
		if(str.charCodeAt(i) > 255) { byteLen += 3; }else{ byteLen ++; }
		if(byteLen > limitBytes) { return str.substring(0, i); }
	}
	return str;
}

/* ********************************************************
* 함수명	: js_checkInputLength(obj, limitBytes, fieldName)
* 설명	: 입력문자의 byte체크 후 최대 입력값 cutting하여 표시
* 인  자	: str, limitBytes
* 사용법	: 입력문자의 Byte길이를 측정하여 최대 허용치 문자열을 object에 표시
*
******************************************************** */
function js_chkLen(obj, limitBytes, fieldName) {
    if(js_checkByteLength(obj.value, limitBytes) == false) {
        var KrLen = limitBytes/3;
        var EnLen = limitBytes;
        showAlert(fieldName + "은(는) 최대 (한글 "+ Math.floor(KrLen)+"자, 영문 "+EnLen+"자) 까지 입력 가능합니다.", "");
        obj.value = js_cutString(obj.value, limitBytes);
    }
}


/* ********************************************************
* 함수명	: js_checkInputLength(obj, limitBytes, fieldName)
* 설명	: 입력된 패스워드의 유효성 확인
* 인  자	: str, limitBytes
* 사용법	: 비밀번호는 대소문자/숫자/특수문자 중 2가지이상 조합하여 8자리 이상, 16자리 이하로 입력검증
*
******************************************************** */
function js_checkPassword(str) {
    var pass = str;

    var result = 0;
    var inRange = false;
    var inNum = false;
    var inEng = false;
    var inSChar = false;


    // 8자리 이상, 20자리 미만
    if((pass.length>=8) && (pass.length<= 16)) {
        inRange = true;
    }

    // 숫자 포함 체크
    for(var i=0; i<pass.length; i++) {
        if( ((pass.charCodeAt(i)>=48) && (pass.charCodeAt(i)<=57))) {
            inNum = true;
            break;
        }
    }

    // 영문 대소문자 포함 체크
    for(var i=0; i<pass.length; i++) {
        if( ((pass.charCodeAt(i)>=65) && (pass.charCodeAt(i)<=90))
                || ((pass.charCodeAt(i)>=97) && (pass.charCodeAt(i)<=122))) {
            inEng = true;
            break;
        }
    }

    // 특수문자 포함 체크
    for(var i=0; i<pass.length; i++) {
        if( ((pass.charCodeAt(i)>=33) && (pass.charCodeAt(i)<=47))
                || ((pass.charCodeAt(i)>=58) && (pass.charCodeAt(i)<=64))
                || ((pass.charCodeAt(i)>=91) && (pass.charCodeAt(i)<=96))) {
            inSChar = true;
            break;
        }
    }

    var joinNum = 0;
    if(inNum) joinNum++;
    if(inEng) joinNum++;
    if(inSChar) joinNum++;

    if( !inRange || joinNum < 2){
        //alert("비밀번호는 대소문자/숫자/특수문자 중 2가지이상 조합하여 8자리 이상, 16자리 이하로 입력하여 주시기 바랍니다.");
        //str.focus();
        return false;
    }

    return true;
}


/* ********************************************************
* 함수명	: js_menuClick(menuNo, url, param, gbn)
* 설명	: Top, Left 메뉴 클릭
* 인  자	: menuNo, url, param, gbn
* 사용법	: 메뉴번호, url, 파라메터, top/left 구분
*
******************************************************** */
function js_menuClick(menuNo, url, param, gbn) {
	if(typeof(gbn) == "undefined") gbn = "";

	var formInsertStr = "";
	var QuerySplit = url.split('?');
	var ResultQuer = QuerySplit[1] ? QuerySplit[1].split('&') : '';

	for (var i = 0; i < ResultQuer.length; i++) {
		if(ResultQuer[i] != "") {
			var keyval = ResultQuer[i].split('=');
			if(keyval.length <= 1)
				keyval[1] = "";

			formInsertStr = formInsertStr + "<input type='hidden' name='" + keyval[0] + "' value='" + keyval[1] + "'/>";
		}
	}

	QuerySplit = param.split('?');
	ResultQuer = QuerySplit[1] ? QuerySplit[1].split('&') : '';

	for (i = 0; i < ResultQuer.length; i++) {
		if(ResultQuer[i] != "") {
			var keyval = ResultQuer[i].split('=');
			if(keyval.length <= 1)
				keyval[1] = "";

			formInsertStr = formInsertStr + "<input type='hidden' name='" + keyval[0] + "' value='" + keyval[1] + "'/>";
		}
	}

	$("#frmLayout").html(formInsertStr);
	$("#frmLayout").attr("method", "post");
	$("#frmLayout").attr("action", url);
	$("#frmLayout").submit();
}

/* ********************************************************
* 함수명	: js_initDataTable(tableId)
* 설명	: Jquery Datatable 초기화
* 인  자	: tableId
* 사용법	: tableId로 받은 datatable 초기화
*
******************************************************** */
function js_initDataTable(tableId, columns, ordering) {

	var columnDataList = new Array();
	var columnDefList = new Array();
	var noFixed = false;

	if(columns == null || columns.length == 0) return;
	var firstVisibleIdx = -1;

	for(var i = 0; i < columns.length; i++) {
		//Set ColumnData
		var columnData = new Object();
		columnData.data = columns[i].data;
		columnData.defaultContent = '';
		columnDataList.push(columnData);

		var columnDef = new Object();
		columnDef.targets = i;

		if(typeof(columns[i].type) != 'undefined' && columns[i].type.indexOf("input") >= 0) {
			columnDef.searchable = 0;
			columnDef.orderable = false;

			if(columns[i].type == "input[text]") {
				columnDef.render = function(data, type, row, meta) {
					return '<input type="text" class="form-control input_all90" value="'+data+'"/>';
				}
			} else if(columns[i].type == "input[number]") {
				columnDef.render = function(data, type, row, meta) {
					return '<input type="text" class="form-control number input_all90 text-right" value="'+data+'"/>';
				}
			} else if(columns[i].type == "input[amt]") {
				columnDef.render = function(data, type, row, meta) {
					return '<input type="text" class="form-control amt input_all90 text-right" value="'+data+'"/>';
				}
			} else if(columns[i].type == "input[date]") {
				columnDef.render = function(data, type, row, meta) {
                    if(typeof(data) == 'undefined')
					    return "";
					return '<input type="text" class="form-control datepicker input_90" readonly value="'+data+'"/>';
				}
			} else if(columns[i].type == "input[month]") {
				columnDef.render = function(data, type, row, meta) {
					return '<input type="text" class="form-control monthpicker input_90" readonly value="'+data+'"/>';
				}
			} else if(columns[i].type == "input[btnDel]") {
				columnDef.render = function(data, type, row, meta) {
					return "<button type='button' class='btn btn-danger'><i class='fa fa-times'></i>&nbsp;삭제</button>"
				}
			} else if(columns[i].type == "input[btnUpdate]") {
				columnDef.render = function(data, type, row, meta) {
					return "<button type='button' class='btn btn-primary'><i class='fa fa-check'></i>&nbsp;수정</button>"
				}
			} else if(columns[i].type == "input[btnDetail]") {
				columnDef.render = function(data, type, row, meta) {
					return "<button type='button' class='btn btn-primary'><i class='fa fa-info'></i></button>"
				}
			} else if(columns[i].type == "input[checkbox]") {
				columnDef.render = function(data, type, row, meta) {
					return '<input type="checkbox" name="checkedIds" value="'+data+'"/>';
				}
			} else if(columns[i].type == "input[hidden]") {
				columnDef.render = function(data, type, row, meta) {
					return '<input type="hidden" name="dataTableIds" value="'+data+'"/>';
				}
			} else if(columns[i].type == "input[index]") {
				noFixed = true;
				columnDef.render = function(data, type, row, meta) {
					return meta.row + 1;
				}
			}
		} else if(typeof(columns[i].type) != 'undefined' && columns[i].type.indexOf("data") >= 0) {
            if(columns[i].type === "data[date]") {
                columnDef.render = function(data, type, row, meta) {
                    if(typeof(data) === 'undefined' || data === null)
					    return "";
                    return js_format(data);
                }
            }
            else if(columns[i].type === "data[cnt]") {
                columnDef.render = function(data, type, row, meta) {
					data = data + " 건";
                    return data;
                }
            }
        } else {
			if(firstVisibleIdx == -1 && columns[i].align != "")
				firstVisibleIdx = i;
		}

		if(columns[i].align == "") {
			columnDef.visible = false;
		} else if(typeof(columns[i].align) == "undefined" || columns[i].align == "center") {
			columnDef.className = "text-center";
		} else if(columns[i].align == "right") {
			columnDef.className = "text-right";
		} else if(columns[i].align == "title") {
			columnDef.render = function(data, type, row) {
				if(typeof(data) == 'undefined')
					return "";
				return "<div class=\"titleDiv\" title=\""+data+"\"><div class=\"flexCell\">"+data+"</div></div>";
			}
		} else if(columns[i].align == "left") {
			columnDef.className = "text-left";
		}

		// 목록 타이틀 추가
		if(typeof(columns[i].titleCol) != "undefined") {
			var userId1 = columns[i].titleCol;

			columnDef.render = function(data, type, row) {
				if(typeof(data) == 'undefined')
					return "";
				return "<div class='tooltip_div' onmouseover=\"fn_viewToolTip(this,'"+row[userId1]+"', event);\" onmouseout=\"fn_hideToolTip();\">"+data+"</div>";
			}
		}
		if(typeof(columns[i].titleCol2) != "undefined") {
			var userId2 = columns[i].titleCol2;

			columnDef.render = function(data, type, row) {
				if(typeof(data) == 'undefined')
					return "";
				return "<div class='tooltip_div' onmouseover=\"fn_viewToolTip(this,'"+row[userId2]+"', event);\" onmouseout=\"fn_hideToolTip();\">"+data+"</div>";
			}
		}
		if(typeof(columns[i].titleCol3) != "undefined") {
			var userId3 = columns[i].titleCol3;

			columnDef.render = function(data, type, row) {
				if(typeof(data) == 'undefined')
					return "";
				return "<div class='tooltip_div' onmouseover=\"fn_viewToolTip(this,'"+row[userId3]+"', event);\" onmouseout=\"fn_hideToolTip();\">"+data+"</div>";
			}
		}

		columnDefList.push(columnDef);
	}
	
	$("#" + tableId).DataTable({
		  searching : false
		, deferRender: true
		, columns : columnDataList
		, columnDefs : columnDefList
		, paging : true
		, info : true
		, ordering : ordering
		, responsive : false
		, language : {
			  emptyTable : "데이터가 존재하지 않습니다."
			, lengthMenu : "페이지당   _MENU_   개씩 보기"
			, info : "현재 _START_-_END_ / _TOTAL_건"
			, infoEmpty : "데이터 없음"
			, infoFiltered : "_MAX_건의 데이터에서 필터링됨 )"
			, zeroRecords : "일치하는 데이터가 없습니다."
			, loadingRecords : "로딩중..."
			, processing : "잠시만 기다려 주세요..."
			, paginate : {
				  next : "다음"
				, previous : "이전"
			}
		}
		, "createdRow" : function (row, data, index) {
			if (Object.keys(data).indexOf('lngTrDoc') != '-1') {
				if (data.lngTrDoc == 'ddd') {
					$(row).children().eq(5).html('<i class="fa fa-file" style="cursor: pointer;"></i>')
				}
			}
		}
		, autoWidth : false
	});

	/*if(noFixed) {
		t.on('order.dt search.dt', function () {
			t.column(0, {search:'applied', order:'applied'}).nodes().each(function (cell, i) {
				cell.innerHTML = i + 1;
			});
		}).draw();
	}*/

	$("#" + tableId + " thead th").removeClass("text-right");
	$("#" + tableId + " thead th").removeClass("text-title");
	$("#" + tableId + " thead th").removeClass("text-left");
	$("#" + tableId + " thead th").addClass("text-center");

	//Tooltip 넣기
	$("#" + tableId + " tbody").on('mousemove', 'td', function() {
		 if($(this).hasClass('text-title')) {
			 $(this).attr("title", $(this).text());
		 }
	 });

	return $("#" + tableId).dataTable();
}

/* ********************************************************
* 함수명	: js_initDataTableScroll(tableId)
* 설명	: Jquery Datatable 초기화, 세로스크롤 생성 후 datatable header를 고정한다.
* 인  자	: tableId
* 사용법	: tableId로 받은 datatable 초기화
*
******************************************************** */
function js_initDataTableScroll(tableId, columns, paging, ordering, bodyHeight) {
	
	var columnDataList = new Array();
	var columnDefList = new Array();
	var noFixed = false;

	if(columns == null || columns.length == 0) return;
	var firstVisibleIdx = -1;

	for(var i = 0; i < columns.length; i++) {
		//Set ColumnData
		var columnData = new Object();
		columnData.data = columns[i].data;
		columnData.defaultContent = '';
		columnDataList.push(columnData);

		var columnDef = new Object();
		columnDef.targets = i;

		if(typeof(columns[i].type) != 'undefined' && columns[i].type.indexOf("input") >= 0) {

			columnDef.searchable = 0;
			columnDef.orderable = false;

			if(columns[i].type == "input[text]") {
				columnDef.render = function(data, type, row, meta) {
					return '<input type="text" class="form-control input_all90" value="'+data+'"/>';
				}
			} else if(columns[i].type == "input[number]") {
				columnDef.render = function(data, type, row, meta) {
					return '<input type="text" class="form-control number input_all90 text-right" value="'+data+'"/>';
				}
			} else if(columns[i].type == "input[amt]") {
				columnDef.render = function(data, type, row, meta) {
					return '<input type="text" class="form-control amt input_all90 text-right" value="'+data+'"/>';
				}
			} else if(columns[i].type == "input[date]") {
				columnDef.render = function(data, type, row, meta) {
					return '<input type="text" class="form-control datepicker input_90" readonly value="'+data+'"/>';
				}
			} else if(columns[i].type == "input[month]") {
				columnDef.render = function(data, type, row, meta) {
					return '<input type="text" class="form-control monthpicker input_90" readonly value="'+data+'"/>';
				}
			} else if(columns[i].type == "input[btnDel]") {
				columnDef.render = function(data, type, row, meta) {
					return "<button type='button' class='btn btn-danger'><i class='fa fa-times'></i>&nbsp;삭제</button>"
				}
			} else if(columns[i].type == "input[btnUpdate]") {
				columnDef.render = function(data, type, row, meta) {
					return "<button type='button' class='btn btn-primary'><i class='fa fa-check'></i>&nbsp;수정</button>"
				}
			} else if(columns[i].type == "input[btnDetail]") {
				columnDef.render = function(data, type, row, meta) {
					return "<button type='button' class='btn btn-primary'><i class='fa fa-info'></i></button>"
				}
			} else if(columns[i].type == "input[checkbox]") {
				columnDef.render = function(data, type, row, meta) {
					return '<input type="checkbox" name="checkedIds" value="'+data+'"/>';
				}
			} else if(columns[i].type == "input[hidden]") {
				columnDef.render = function(data, type, row, meta) {
					return '<input type="hidden" name="dataTableIds" value="'+data+'"/>';
				}
			} else if(columns[i].type == "input[index]") {
				noFixed = true;
				columnDef.render = function(data, type, row, meta) {
					return meta.row + 1;
				}
			}
		} else if(typeof(columns[i].type) != 'undefined' && columns[i].type.indexOf("data") >= 0) {
            if(columns[i].type === "data[date]") {
                columnDef.render = function(data, type, row, meta) {
                    if(typeof(data) === 'undefined' || data === null)
					    return "";
                    return js_format(data);
                }
            }
            else if(columns[i].type === "data[cnt]") {
                columnDef.render = function(data, type, row, meta) {
					data = data + " 건";
                    return data;
                }
            }
        } else {
			if(firstVisibleIdx == -1 && columns[i].align != "")
				firstVisibleIdx = i;
		}

		if(columns[i].align == "") {
			columnDef.visible = false;
		} else if(typeof(columns[i].align) == "undefined" || columns[i].align == "center") {
			columnDef.className = "text-center";
		} else if(columns[i].align == "right") {
			columnDef.className = "text-right";
		} else if(columns[i].align == "title") {
			columnDef.render = function(data, type, row) {
				if(typeof(data) == 'undefined')
					return "";
				return "<div class=\"titleDiv\" title=\""+data+"\"><div class=\"flexCell\">"+data+"</div></div>";
			}
		} else if(columns[i].align == "left") {
			columnDef.className = "text-left";
		}

		// 목록 타이틀 추가
		if(typeof(columns[i].titleCol) != "undefined") {
			var userId1 = columns[i].titleCol;

			columnDef.render = function(data, type, row) {
				if(typeof(data) == 'undefined')
					return "";
				return "<div class='tooltip_div' onmouseover=\"fn_viewToolTip(this,'"+row[userId1]+"', event);\" onmouseout=\"fn_hideToolTip();\">"+data+"</div>";
			}
		}
		if(typeof(columns[i].titleCol2) != "undefined") {
			var userId2 = columns[i].titleCol2;

			columnDef.render = function(data, type, row) {
				if(typeof(data) == 'undefined')
					return "";
				return "<div class='tooltip_div' onmouseover=\"fn_viewToolTip(this,'"+row[userId2]+"', event);\" onmouseout=\"fn_hideToolTip();\">"+data+"</div>";
			}
		}
		if(typeof(columns[i].titleCol3) != "undefined") {
			var userId3 = columns[i].titleCol3;

			columnDef.render = function(data, type, row) {
				if(typeof(data) == 'undefined')
					return "";
				return "<div class='tooltip_div' onmouseover=\"fn_viewToolTip(this,'"+row[userId3]+"', event);\" onmouseout=\"fn_hideToolTip();\">"+data+"</div>";
			}
		}

		columnDefList.push(columnDef);
	}

	var t = $("#" + tableId).DataTable({
		  searching : false
		, columns : columnDataList
		, columnDefs : columnDefList
		, paging : paging
		, info : true
		, ordering : ordering
		, responsive : false
		, language : {
			  emptyTable : "데이터가 존재하지 않습니다."
			, lengthMenu : "페이지당   _MENU_   개씩 보기"
			, info : "현재 _START_-_END_ / _TOTAL_건"
			, infoEmpty : "데이터 없음"
			, infoFiltered : "_MAX_건의 데이터에서 필터링됨 )"
			, zeroRecords : "일치하는 데이터가 없습니다."
			, loadingRecords : "로딩중..."
			, processing : "잠시만 기다려 주세요..."
			, paginate : {
				  next : "다음"
				, previous : "이전"
			}
		}
		, scrollY : bodyHeight
		, scrollX : "100%"
		, scrollCollapse : true
	});

//	if(noFixed) {
//		t.on('order.dt search.dt', function () {
//			t.column(0, {search:'applied', order:'applied'}).nodes().each(function (cell, i) {
//				cell.innerHTML = i + 1;
//			});
//		}).draw();
//	}

	$("#" + tableId).closest("div").parent().find("th").removeClass("text-right");
	$("#" + tableId).closest("div").parent().find("th").removeClass("text-title");
	$("#" + tableId).closest("div").parent().find("th").removeClass("text-left");
	$("#" + tableId).closest("div").parent().find("th").addClass("text-center");

	//Tooltip 넣기
	$("#" + tableId + " tbody").on('mousemove', 'td', function() {
		 if($(this).hasClass('text-title')) {
			 $(this).attr("title", $(this).text());
		 }
	 });

	return $("#" + tableId).dataTable();
}

/* ********************************************************
* 함수명	: js_initNoPagingDataTable(tableId)
* 설명	: Jquery Datatable 초기화
* 인  자	: tableId
* 사용법	: tableId로 받은 datatable 초기화
*
******************************************************** */
function js_initNoPagingDataTable(tableId, columns, ordering, prmHeight) {
	
	var columnDataList = new Array();
	var columnDefList = new Array();
	var noFixed = false;

	if(columns == null || columns.length == 0) return;
	var firstVisibleIdx = -1;

	for(var i = 0; i < columns.length; i++) {
		//Set ColumnData
		var columnData = new Object();
		columnData.data = columns[i].data;
		columnData.defaultContent = '';
		columnDataList.push(columnData);

		var columnDef = new Object();
		columnDef.targets = i;

		if(typeof(columns[i].type) != 'undefined' && columns[i].type.indexOf("input") >= 0) {

			columnDef.searchable = 0;
			columnDef.orderable = false;

			if(columns[i].type == "input[text]") {
				columnDef.render = function(data, type, row, meta) {
					return '<input type="text" class="form-control input_all90" value="'+data+'"/>';
				}
			} else if(columns[i].type == "input[number]") {
				columnDef.render = function(data, type, row, meta) {
					return '<input type="text" class="form-control number input_all90 text-right" value="'+data+'"/>';
				}
			} else if(columns[i].type == "input[amt]") {
				columnDef.render = function(data, type, row, meta) {
					return '<input type="text" class="form-control amt input_all90 text-right" value="'+data+'"/>';
				}
			} else if(columns[i].type == "input[date]") {
				columnDef.render = function(data, type, row, meta) {
					return '<input type="text" class="form-control datepicker input_90" readonly value="'+data+'"/>';
				}
			} else if(columns[i].type == "input[month]") {
				columnDef.render = function(data, type, row, meta) {
					return '<input type="text" class="form-control monthpicker input_90" readonly value="'+data+'"/>';
				}
			} else if(columns[i].type == "input[btnDetail]") {
				columnDef.render = function(data, type, row, meta) {
					return "<button type='button' class='btn btn-primary'><i class='fa fa-info'></i></button>"
				}
			} else if(columns[i].type == "input[checkbox]") {
				columnDef.render = function(data, type, row, meta) {
					return '<input type="checkbox" name="checkedIds" value="'+data+'"/>';
				}
			} else if(columns[i].type == "input[hidden]") {
				columnDef.render = function(data, type, row, meta) {
					return '<input type="hidden" name="dataTableIds" value="'+data+'"/>';
				}
			} else if(columns[i].type == "input[cmCd]") {
				columnDef.render = function(data, type, row, meta) {
					return '<input type="hidden" name="cmCdValues" value="'+data+'"/>'+data;
				}
			} else if(columns[i].type == "input[cmCdNm]") {
				columnDef.render = function(data, type, row, meta) {
					return '<input type="hidden" name="cmCdNmValues" value="'+data+'"/>'+data
				}
			} else if(columns[i].type == "input[index]") {
				noFixed = true;
				columnDef.render = function(data, type, row, meta) {
					return meta.row + 1;
				}
			}
		} else if(typeof(columns[i].type) != 'undefined' && columns[i].type.indexOf("data") >= 0) {
	        if(columns[i].type === "data[date]") {
	            columnDef.render = function(data, type, row, meta) {
                    if(typeof(data) === 'undefined' || data === null)
					    return "";
	                return js_format(data);
	            }
	        }
	        else if(columns[i].type === "data[cnt]") {
	            columnDef.render = function(data, type, row, meta) {
					data = data + " 건";
	                return data;
	            }
	        }
		} else {
			if(firstVisibleIdx == -1 && columns[i].align != "")
				firstVisibleIdx = i;
		}

		if(columns[i].align == "") {
			columnDef.visible = false;
		} else if(typeof(columns[i].align) == "undefined" || columns[i].align == "center") {
			columnDef.className = "text-center";
		} else if(columns[i].align == "right") {
			columnDef.className = "text-right";
		} else if(columns[i].align == "title") {
			columnDef.render = function(data, type, row) {
				if(typeof(data) == 'undefined')
					return "";
				return "<div class=\"titleDiv\" title=\""+data+"\"><div class=\"flexCell\">"+data+"</div></div>";
			}
		} else if(columns[i].align == "left") {
			columnDef.className = "text-left";
		}

		// 목록 타이틀 추가
		if(typeof(columns[i].titleCol) != "undefined") {
			var userId1 = columns[i].titleCol;

			columnDef.render = function(data, type, row) {
				if(typeof(data) == 'undefined')
					return "";
				return "<div class='tooltip_div' onmouseover=\"fn_viewToolTip(this,'"+row[userId1]+"', event);\" onmouseout=\"fn_hideToolTip();\">"+data+"</div>";
			}
		}
		if(typeof(columns[i].titleCol2) != "undefined") {
			var userId2 = columns[i].titleCol2;

			columnDef.render = function(data, type, row) {
				if(typeof(data) == 'undefined')
					return "";
				return "<div class='tooltip_div' onmouseover=\"fn_viewToolTip(this,'"+row[userId2]+"', event);\" onmouseout=\"fn_hideToolTip();\">"+data+"</div>";
			}
		}
		if(typeof(columns[i].titleCol3) != "undefined") {
			var userId3 = columns[i].titleCol3;

			columnDef.render = function(data, type, row) {
				if(typeof(data) == 'undefined')
					return "";
				return "<div class='tooltip_div' onmouseover=\"fn_viewToolTip(this,'"+row[userId3]+"', event);\" onmouseout=\"fn_hideToolTip();\">"+data+"</div>";
			}
		}

		columnDefList.push(columnDef);
	}


	var t = $("#" + tableId).DataTable({
		  searching : false
		, columns : columnDataList
		, columnDefs : columnDefList
		, paging : false
		, info : true
		, ordering : ordering
		, responsive : false
		, language : {
			  emptyTable : "데이터가 존재하지 않습니다."
			, lengthMenu : "페이지당   _MENU_   개씩 보기"
			, info : "현재 _START_-_END_ / _TOTAL_건"
			, infoEmpty : "데이터 없음"
			, infoFiltered : "_MAX_건의 데이터에서 필터링됨 )"
			, zeroRecords : "일치하는 데이터가 없습니다."
			, loadingRecords : "로딩중..."
			, processing : "잠시만 기다려 주세요..."
			, paginate : {
				  next : "다음"
				, previous : "이전"
			}
		}
        , scrollY: prmHeight
        , scroller: true
		, "createdRow" : function (row, data, index) {
			if (Object.keys(data).indexOf('lngTrDoc') != '-1') {
				if (data.lngTrDoc == 'ddd') {
					$(row).children().eq(5).html('<i class="fa fa-file" style="cursor: pointer;"></i>')
				}
			}
		}
		, autoWidth : false
	});

//	if(noFixed) {
//		t.on('order.dt search.dt', function () {
//			t.column(0, {search:'applied', order:'applied'}).nodes().each(function (cell, i) {
//				cell.innerHTML = i + 1;
//			});
//		}).draw();
//	}

	$("#" + tableId + " thead th").removeClass("text-right");
	$("#" + tableId + " thead th").removeClass("text-title");
	$("#" + tableId + " thead th").removeClass("text-left");
	$("#" + tableId + " thead th").addClass("text-center");

	//Tooltip 넣기
	$("#" + tableId + " tbody").on('mousemove', 'td', function() {
		 if($(this).hasClass('text-title')) {
			 $(this).attr("title", $(this).text());
		 }
	 });

	return $("#" + tableId).dataTable();
}

/* ********************************************************
 * datepicker를 초기화한다.
 * datepicker 클래스에  datepicker를 적용한다.
 * datepicker 클래스가 적용된 엘리먼트의 뒤쪽에 달력 및 휴지통 아이콘을 추가한다.
 * jQuery가 필요하다.
 ******************************************************** */
function js_initDatePicker(pattern) {
	var currentYear = (new Date()).getFullYear();
	var startYear = currentYear-100;
	var endYear = currentYear+50;
	var yearRange = ""+startYear+":"+endYear+"";

	$( ".datepicker" ).datepicker({
		language : 'ko',
		format : pattern,
		autoclose : true,
		zIndexOffset: 10000
	});
	
	$( ".datepicker" ).addClass("input_inline_block");
	$( ".datepicker" ).addClass("input_100");
	$( ".datepicker" ).addClass("text-center");
	$( ".datepicker" ).attr("placeholder", "YYYY-MM-DD");
	$( ".datepicker" ).attr("maxlength", 10);
	
	
	// 아이콘생성
	$( ".datepicker" ).each(function() {
		
		var thisDatePicker = $(this);
		// 캘린더 아이콘 (인풋바로옆에 있는가?)
		var calenderIcon = thisDatePicker.next("i.btn_datepicker");
	
		if(!calenderIcon.length) {
			// 캘린더 아이콘이 없으면 만든다.
			calenderIcon = $("<i></i>");
	
			calenderIcon.addClass("fa fa-calendar-alt btn_datepicker input_inline_block ");
			calenderIcon.css({"font-size":"19px", "line-height": "19px", "vertical-align": "middle", "margin" : "5px", "cursor" : "pointer"});

			calenderIcon.on("click",function() {
				thisDatePicker.datepicker( "show" );
			});
			// 인풋 바로옆에 만든다.
			thisDatePicker.after(calenderIcon);
			calenderIcon = thisDatePicker.next("i.btn_datepicker");
		
			 //날짜관련 이벤트 생성
			$( ".datepicker" ).keypress(function(event) {
				js_autoYMDHyphen('D', event, this);
			});
			$( ".datepicker" ).keyup(function(event) {
				js_autoYMDHyphen('D', event, this);
			});
			$( ".datepicker" ).focusout(function(event) {
				js_ymdChk('D', this);
			});
			
		}
		// 삭제아이콘  (캘린더 아이콘 바로옆에 있는가?)
		var delIcon = calenderIcon.next("i.btn_dateReset");
		if(!delIcon.length) {
			// 삭제아이콘이 없으면 만든다.
			delIcon = $("<i></i>");
			delIcon.addClass("fa fa-trash btn_dateReset");
			delIcon.css({"font-size":"19px", "line-height": "19px", "vertical-align": "middle", "margin" : "5px", "cursor" : "pointer"});
			delIcon.on("click",function() {
				thisDatePicker.val("");
			});
			// 캘린더 아이콘 바로옆에 만든다.
			calenderIcon.after(delIcon);
		}
		
		// 입력칸 비활성화인 경우 아이콘 숨김처리
		if($(this).prop("readonly") == true) {
			$(this).next("i.btn_datepicker").hide();
			$(this).next().next("i.btn_dateReset").hide();
		}
	});

}


/* ********************************************************
 * monthpicker를 초기화한다.
 * monthpicker 클래스에  monthpicker를 적용한다.
 * monthpicker 클래스가 적용된 엘리먼트는 라이브러리에서 자동으로 달력아이콘을 추가하며
 * 뒤쪽에 휴지통 아이콘을 추가한다.
 * jQuery가 필요하다.
 ******************************************************** */
var selectYear = "";
function js_initMonthPicker(pattern) {
	var currentYear = (new Date()).getFullYear();
	var startYear = currentYear-10;
	var options = {
		  startYear: startYear
		, finalYear: currentYear+10
		, openOnFocus : false
		, pattern: pattern
		, year: selectYear
		, monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
	};
	$('.monthpicker').monthpicker(options);

	$(".monthpicker").addClass("input_inline_block");
	$(".monthpicker").addClass("input_100");
	$(".monthpicker").addClass("text-center");
	$(".monthpicker").attr("placeholder", "YYYY-MM");
	$(".monthpicker").attr("maxlength", 7);

	// 아이콘생성
	$(".monthpicker").each(function() {
		var thisMonthpicker = $(this);
		// 캘린더 아이콘 (인풋바로옆에 있는가?)
		var calenderIcon = thisMonthpicker.next("i.btn_monthpicker");

		if(!calenderIcon.length ) {
			// 캘린더 아이콘이 없으면 만든다.
			calenderIcon = $("<i></i>");
			calenderIcon.addClass("fa fa-calendar-alt btn_monthpicker");
			calenderIcon.css({"font-size":"19px", "line-height": "19px", "vertical-align": "middle", "margin" : "5px", "cursor" : "pointer"});
			calenderIcon.on("click",function() {
				thisMonthpicker.monthpicker( "show" );
			});
			// 인풋 바로옆에 만든다.
			thisMonthpicker.after(calenderIcon);
			calenderIcon = thisMonthpicker.next("i.btn_monthpicker");

			//날짜관련 이벤트 생성
			$(".monthpicker").keypress(function(event) {
				js_autoYMDHyphen('M', event, this);
			});
			$(".monthpicker").keyup(function(event) {
				js_autoYMDHyphen('M', event, this);
			});
			$(".monthpicker").focusout(function(event) {
				js_ymdChk('M', this);
			});
		}

		if(!thisMonthpicker.hasClass("notClearable")) {
			// 삭제아이콘  (캘린더 아이콘 바로옆에 있는가?)
			var delIcon = calenderIcon.next("i.btn_monthReset");

			if(!delIcon.length) {
				// 삭제아이콘이 없으면 만든다.
				delIcon = $("<i></i>");
				delIcon.addClass("fa fa-trash btn_monthReset");
				delIcon.css({"font-size":"19px", "line-height": "19px", "vertical-align": "middle", "margin" : "5px", "cursor" : "pointer"});
				delIcon.on("click",function() {
					thisMonthpicker.val("").trigger("change");
				});
				// 캘린더 아이콘 바로옆에 만든다.
				calenderIcon.after(delIcon);
			}
		}
		
		// 입력칸 비활성화인 경우 아이콘 숨김처리
		if($(this).prop("readonly") == true) {
			$(this).next("i.btn_monthpicker").hide();
			$(this).next().next("i.btn_monthReset").hide();
		}
	});
}

function js_initDateRangePicker(id, cbFunc, drops) {

	if (js_isEmpty(drops)) {
		drops = 'down';
	}

	$('#' + id).daterangepicker({
		opens: 'right',
		drops: drops,
		startDate: moment(),
		endDate: moment(),
		minDate: '2000-01-01',
		maxDate: '2099-12-31',
		locale: {
			format: 'YYYY-MM-DD',
			separator: ' - ',
			applyLabel: '확인',
			cancelLabel: '취소',
			daysOfWeek: [
				'일',
				'월',
				'화',
				'수',
				'목',
				'금',
				'토'
			],
			monthNames: [
				'1월',
				'2월',
				'3월',
				'4월',
				'5월',
				'6월',
				'7월',
				'8월',
				'9월',
				'10월',
				'11월',
				'12월'
			]
		}
	}, function (start, end) {
		$('#' + id + ' input').val(start.format('YYYY-MM-DD') + ' ~ ' + end.format('YYYY-MM-DD'));
		cbFunc(start.format('YYYY-MM-DD'), end.format('YYYY-MM-DD'));
	});
}

/* ********************************************************
 *  공통 경고창 표시(Alert 대체)
 *  타이틀, 메세지, 경고 유형을 받아서 표시
 *  경고유형 : info, success, warning, error 중 택1
 ******************************************************** */
function showAlert(message, type, confirmFunc) {
	//중간 small text 생략
	swal(message, " ", type, {button : "확인"})
		.then(function(isConfirm) {
		if(confirmFunc != null){
			$(location).attr("href", confirmFunc(isConfirm));
		}
	});
}

/* ********************************************************
 *  공통 확인 메세지창(Confirm 대체)
 *  타이틀, 메세지, 버튼 클릭 시 Retrun받을 function명
 *  return function에 isConfirm(type : boolean)을 포함하여 Return
 ******************************************************** */
function showConfirm(message, confirmFunc) {
	swal({
		title : message
		, text : " "
		, icon : "info"
		, buttons : {
			confirm : {
				  text : "확인"
				, value : true
				, className : "btn btn-success"
				, visible : true
			}
			, cancel : {
				text : "취소"
				, value : false
				, className : "btn btn-default"
				, visible : true
			}
		}
	}).then(function(isConfirm) {
		$(location).attr("href", confirmFunc(isConfirm));
	});
}

/* ********************************************************
 * Ajax Submit Form을 Ajax로 보낸다.
 * callback은 JSON 만 받는다.
 * jQuery가 필요하다
 * formId : 값이 존재하는 대상 form의 Id
 * url : 주소
 * callBack : 완료후 리턴함수, 파라미터로 수행결과 JSON을 전달한다.
 *  !! => 만일 isCrossDomain이 true일경우 리턴값이 Json이 아니라면 callBack을 호출하지 않는다.
 * isMultipart : 멀티파트(파일전송) 방식 사용 여부
 * isCrossDomain : 다른 도메인으로 전송이 필요할경우 true로 입력한다. 이경우 리턴값이 Json이 아니라면 callBack을 호출하지 않는다.
 ******************************************************** */
function ajaxSubmit(formId, url, callBack, isMultipart) {
	$('button').attr('disabled', true);

	js_loadingStart();

   // 멀티파트는 ajaxFileSubmit 호출
    if(isMultipart == true) {
        ajaxFileSubmit(formId, url, callBack);
        return false;
    }

	var srcFrm = $("#" + formId);

	if(srcFrm.length == 0) {
		return false;
	}
	var params = srcFrm.serialize();
	var method = 'POST';

	jQuery.ajax({
		  url: url
		, type : method
		, data: params
		, dataType   : "json"
		, success : function( data ) {
			if(callBack) {
				js_loadingEnd();
				callBack(data);
				$('button').attr('disabled', false);
			}
		}
		, error : function( jqXHR, textStatus, errorThrown ) {
			if(jqXHR.status != 200 && jqXHR.status != "200") {
				showAlert( '서버 데이터를 가져오지 못했습니다. 다시 확인하여 주십시오.', 'error' );
			} else {
				showAlert( '잘못된 권한으로의 접근입니다.', 'error' );
			}
			$('button').attr('disabled', false);
			js_loadingEnd();
		}
	});
}

/*********************************************************
 * 처리중...layer 시작 처리 함수
 *********************************************************/
function js_loadingStart() {
	// //화면을 가리는 레이어를 보여준다 (0.5초동안 30%의 농도의 투명도)
	// $(".backLayer").fadeTo(0, 1);
    //
	// //팝업 레이어 보이게
	// var loadingDivObj = $("#loadingDiv");
    //
	// loadingDivObj.fadeIn(0);
    //
	// $('body, html').css('overflow', 'hidden');

    // spinner 보이기
    $(".spinner-border").css('visibility', 'visible');
    $(".spinner-overlay").css('visibility', 'visible');
}



/*********************************************************
 * 처리중...layer 종료 처리 함수
 *********************************************************/
function js_loadingEnd() {
	// $("#loadingDiv").fadeOut(0);
	// $(".backLayer").fadeOut(0);
	//
	// // title 툴팁 적용
	// $(".titleDiv").tooltip();
	// $('body, html').css('overflow', 'auto');

    // spinner 숨기기
    $(".spinner-border").css('visibility', 'hidden');
    $(".spinner-overlay").css('visibility', 'hidden');
}

/* ********************************************************
* 함수명	: js_dupCheck(tableId)
* 설명		: 화면특정 필드의 데이터값 중복성 확인
* 인  자	:
* 사용법	:
******************************************************** */
function js_dupCheck(chkTable, chkColList, chkNmList) {
	if(chkColList.length != chkNmList.length) {
		showAlert("중복검토 필드와 값의 수가 일치하지 않습니다.", "warning");
		return false;
	}

	$("#divDupCheck").html('');
	//테이블정보
    $("#divDupCheck").append("<input type='hidden' name='checkTable' value='"+chkTable+"'/> ");

    for(var i = 0; i < chkColList.length; i++) {
    	//체크 컬럼정보
        $("#divDupCheck").append("<input type='hidden' name='checkColList' value='"+chkColList[i]+"'/> ");
        //체크 정보 값
        $("#divDupCheck").append("<input type='hidden' name='checkNmList' value='"+$("#" + chkNmList[i]).val()+"'/> ");
    }

    var url = "";
    if(document.getElementById("was_start_path") == null)
        url = "/com/dupChck/ComDupChckAjax.do";
    else
    	url = $("#was_start_path").val() + "/com/dupChck/ComDupChckAjax.do";

    var dupRslt = false;
    //중복체크
	$.ajax({
		type : 'POST'
		, url : url
		, data: $("#dupCheckForm").serialize()
		, dataType: "json"
		, async : false
		, success : function(data) {
			if(data.result == '1') {
				dupRslt = (data.dupRslt == "1") ? true : false;
			} else {
				showAlert("중복검토 수행 중 오류가 발생 하였습니다.", "error");
				return;
			}
		}
	});
	return dupRslt;
}

/* ********************************************************
* 함수명	: js_dateChck(fromId, toId)
* 설명		: 시작일과 종료일 체크
* 인  자	:
* 사용법	: 시작일과 종료일에 해당하는 ID를 넘긴다.
* 			  리턴 값 boolean
******************************************************** */
function js_dateChck(from, to) {
	var returnVal = true;

	if (js_isEmpty($("#"+from).val()) && js_isEmpty($("#"+to).val())) {
		returnVal = true;
	} else if (!js_isEmpty($("#"+from).val()) && !js_isEmpty($("#"+to).val())) {
		var calcVal = moment($("#"+to).val(), 'YYYY-MM-DD').diff($("#"+from).val(), 'days');

		if (calcVal < 0) {
			$("#"+to).val('');
			returnVal = false;
			showAlert('종료일이 시작일보다 작을 수 없습니다.', 'error', function() {
				$("#"+to).focus();
			});
		}
	} else {
		var msg = '';

		if (js_isEmpty($("#"+from).val())) msg = '시작일';
		if (js_isEmpty($("#"+to).val())) msg = '종료일';

		showAlert(msg +'을 입력하여 주시기 바랍니다.', 'error', function () {
			(msg == '시작일') ? $("#"+from).focus() : $("#"+to).focus();
		});
		returnVal = false;
	}

	return returnVal;
}

/* ********************************************************
* 함수명	: js_yearChck(fromId, toId)
* 설명		: 시작년도 종료년도 체크
* 인  자	:
* 사용법	: 시작년도 종료년도 해당하는 ID를 넘긴다.
* 			  리턴 값 boolean
******************************************************** */
function js_yearChck(from, to) {
	var returnVal = true;

	if(!js_isEmpty($("#"+from).val())) {
		if(Number($("#"+from).val()) < 1900) {
			showAlert('잘못된 시작년도 입니다.', 'warning');
			$("#"+from).val('');
			return false;
		}
	}

	if(!js_isEmpty($("#"+to).val())) {
		if(Number($("#"+to).val()) < 1900) {
			showAlert('잘못된 종료년도 입니다.', 'warning');
			$("#"+to).val('');
			return false;
		}
	}

	if (js_isEmpty($("#"+from).val()) || js_isEmpty($("#"+to).val())) {
		returnVal = true;
	} else if (!js_isEmpty($("#"+from).val()) && !js_isEmpty($("#"+to).val())) {
		var fromYear = Number($("#"+from).val());
		var endYear = Number($("#"+to).val());
		if(fromYear > endYear) {
			showAlert('시작년도가 종료년도보다 클 수 없습니다.', 'warning');
			$("#"+to).val('');
			return false;
		}
	}

	return returnVal;
}

/* ********************************************************
* 함수명	: js_drawChart
* 설명		: 차트 그리기
* 인  자	: type, data, title, cbFunc
* 사용법	: type: bar(막대), pie(파이), line(라인) 3개를 넣을 수 있다.
* 			  data: 객체를 배열에 담아야 한다.
* 			 		객체는 labelId(분류ID), labelNm(분류명), cnt(수치) 3개의 데이터를 가지고 있어야 한다.
* 			 title: 상단 타이틀을 입력한다.(ex 장비대여 분출현황)
* 			cbFunc: 차트를 클릭했을 시 이벤트 처리할 함수(콜백으로 분류ID를 넘겨줌)
******************************************************** */
function js_drawChart(type, data, title, cbFunc) {

	// 분류명 셋팅
	var labels = data.reduce(function (pre, cur) {
		pre.push(cur.labelNm);
		return pre;
	}, []);

	// 색상 셋팅
	var color = Chart.helpers.color;
	var colorNames = Object.keys(window.chartColors);

	var dataArr = [];
	var idArr = [];
	var chartData = {};
	var optionData = {};
	var colorData = [];

	// 데이터 셋팅
	for (var i = 0; i < data.length; i++) {
		dataArr.push(data[i].cnt);
		idArr.push(data[i].labelId);
		if (type == 'pie') {
			colorData.push(color(window.chartColors[colorNames[i % colorNames.length]]).alpha(0.5).rgbString());
		} else {
			colorData = color(window.chartColors[colorNames[0 % colorNames.length]]).alpha(0.5).rgbString();
		}
	}

	// 차트 데이터 및 옵션 중복 처리
	chartData.labels = labels;
	chartData.datasets = [];
	chartData.datasets.push({
		label: '집계',
		backgroundColor: colorData,
		data: dataArr,
		labelId: idArr
	});

	optionData.responsive = true; // 크기 자동
	optionData.maintainAspectRatio = false; // 캔버스 상위 엘리먼트 높이에 따라 비율에 맞게 표시
	optionData.title = {
		display: true,
		text: title
	};

	// 차트 클릭이벤트
	optionData.onClick = function(e, item) {
		if (item[0]) {
			cbFunc(item[0]._chart.data.datasets[0].labelId[item[0]._index]);
		}
	}

	if (type != 'pie') {
		optionData.scales = {
			yAxes: [{
				ticks: {
					beginAtZero: true // Y축 0부터
				}
			}]
		};
	}

	switch(type) {
		case 'bar': // 막대
			optionData.legend = {
				position: 'top'
			};
			break;
		case 'pie': // 파이
			break;
		case 'line': // 라인
			chartData.datasets[0].borderColor = colorData;
			chartData.datasets[0].fill = true;

			optionData.tooltips = {
				mode: 'index',
				intersect: false,
			};
			optionData.hover = {
				mode: 'nearest',
				intersect: true
			};
			break;
		case 'straightLine': // 라인
			type = 'line';
			chartData.datasets[0].borderColor = colorData;
			chartData.datasets[0].fill = true;
			chartData.datasets[0].lineTension = 0;

			optionData.tooltips = {
				mode: 'index',
				intersect: false,
			};
			optionData.hover = {
				mode: 'nearest',
				intersect: true
			};
			break;
	}

	var config = {
		type: type,
		data: chartData,
		options: optionData
	}

	var ctx = document.getElementById('canvas').getContext('2d');
	window.myChart = new Chart(ctx, config);
}