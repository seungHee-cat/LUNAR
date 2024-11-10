$('#login_close').click(function () {
	if($('#loginId').val() == ''){
		alert('아이디를 입력해주세요.');
		$('#loginId').focus();
		
	}else if($('#loginPw').val() == ''){
		alert('비밀번호를 입력해주세요.');
		$('#loginPw').focus();
		
	}else{
		const user_id = $('#loginId').val();
		const pw = $('#loginPw').val();
		const user = {
            "user_id": user_id,
            "password": pw
        };
		$.ajax({
			type : "post",
			url : "loginCheck.do",
			headers: { 'Content-Type': 'application/json' },
            data: JSON.stringify(user),
            dataType: 'text',
			success : function(result){
				if(result == 'none'){
					alert('아이디 또는 비밀번호가 잘못되었습니다.');
					$('#loginId').focus();
				}else if(result == 'index.do'){
					window.location.href = result;
					$('#loginId').text('');
                	$('#loginPw').text('');
                	$('.loginModal').addClass('login_hide');
				}else if(result == 'admin_main.do'){
					window.location.href = result;
					$('#loginId').text('');
                	$('#loginPw').text('');
                	$('.loginModal').addClass('login_hide');
				}
			},
			error : function(error){
				console.log(error);
			}
		});
	}
});

const getIdCheck = RegExp(/^(?!.*admin)[a-zA-Z0-9]{5,15}$/);
const getPwCheck = RegExp(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{10,40}$/);
const getEmailCheck = RegExp(/^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/);

let chk1 = false, chk2= false, chk3 = false;

// ID 검증
$('#regId').keyup(function(){
	if($(this).val() == ''){
		$('#idCheck').text('아이디를 입력해주세요.');
		chk1 = false;
	}else if(!getIdCheck.test($(this).val())){
		$('#idCheck').text('대·소문자, 숫자를 포함한 5~15글자로 입력해주세요.')
		chk1 = false;
	}else{
		const id = $(this).val();
		$.ajax({
			type : "post",
			url : "idCheck.do",
			headers : {'Content-Type' : 'application/json'},
			dataType : 'text',
			data : id,
			success : function(result){
				if(result === 'available'){
					console.log(result);
					$('#idCheck').text('사용 가능한 아이디입니다.');
					chk1 = true;
				}else{
					$('#idCheck').text('이미 사용중인 아이디입니다.');
					chk1 = false;
				}
				checkAllConditions();
			},
			error : function(status, error){
				console.log(status, error);
			}
		})
	}
});

// PW 검증
$('#regPw').keyup(function(){
    const password = $(this).val();
    
    if(password.length === 0) {
        $('#pwCheck').text('비밀번호를 입력해주세요.');
        chk2 = false;
    } else if (!getPwCheck.test(password)) {
        $('#pwCheck').text('10~40글자 사이로 영문, 숫자, 특수문자를 1개 이상 포함해주세요.');
        chk2 = false;
    } else {
        $('#pwCheck').text('사용 가능한 비밀번호입니다.');
        chk2 = true;
    }
    checkAllConditions();
});

// Email 검증
$('#regEmail').keyup(function(){
	if($(this).val() == ''){
		$('#emailCheck').text('이메일을 입력해주세요.');
		chk3 = false;
	}else if(!getEmailCheck.test($(this).val())){
		$('#emailCheck').text('올바른 이메일 형태로 입력해주세요.');
		chk3 = false;
	}else{
		const email = $(this).val();
		$.ajax({
			type : "post",
			url : "emailCheck.do",
			headers : {'Content-Type' : 'application/json'},
			dataType : 'text',
			data : email,
			success : function(result){
				if(result === 'available'){
					console.log(result);
					$('#emailCheck').text('사용 가능한 이메일입니다.');
					chk3 = true;
				}else{
					$('#emailCheck').text('이미 사용중인 이메일입니다.');
					chk3 = false;
				}
				checkAllConditions();
			},
			error : function(status, error){
				console.log(status, error);
			}
		})
	}
});

function checkAllConditions() {
    console.log('chk1 상태 : ' + chk1);
    console.log('chk2 상태 : ' + chk2);
    console.log('chk3 상태 : ' + chk3);
}

$('#register_close').click(function () {
	if (chk1 && chk2 && chk3) {
		checkAllConditions();
		
        const id = $('#regId').val();
        const pw = $('#regPw').val();
        const email = $('#regEmail').val();
        const user = {
            "id": user_id,
            "password": pw,
            "email": email,
        };
        $.ajax({
            url: 'register.do',
            type: 'post',
            headers: { 'Content-Type': 'application/json' },
            data: JSON.stringify(user),
            dataType: 'text',
            success: function (result) {
                alert('회원가입이 완료되었습니다.');
                $('#regId').val('');
                $('#regPw').val('');
                $('#regEmail').val('');
                $('#idCheck').text('');
                $('#pwCheck').text('');
                $('#emailCheck').text('');
                chk1 = false, chk2 = false, chk3 = false;
                $('.registerModal').addClass('register_hide');
            },
            error: function (error) {
                console.log(error);
            },
        });
	}else if(chk1 == false){
		alert('입력된 아이디를 확인해주세요.');
		$('#regId').focus();
	}else if(chk2 == false){
		alert('입력된 비밀번호를 확인해주세요.');
		$('#regPw').focus();
	}else if(chk3 == false){
		alert('입력된 이메일을 확인해주세요.');
		$('#regEmail').focus();
	}
});