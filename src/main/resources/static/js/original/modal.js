function loginFunc(){
	document.querySelector('.loginModal').classList.remove('login_hide');
}

function registerFunc(){
	document.querySelector('.registerModal').classList.remove('register_hide');
}
document.querySelector('.profile_img').addEventListener('click', function() {
    document.querySelector('.profile_menu').classList.toggle('profile_hide');
});

document.querySelector('#login_btn').addEventListener('click', function () {
    document.querySelector('.loginModal').classList.remove('login_hide');
    document.querySelector('.registerModal').classList.add('register_hide');
});

document.querySelector('#register_btn').addEventListener('click', function () {
    document.querySelector('.registerModal').classList.remove('register_hide');
    document.querySelector('.loginModal').classList.add('login_hide');
});

document.querySelector('.settings').addEventListener('click', function () {
    document.querySelector('.settingModal').classList.remove('setting_hide');
});

document.querySelector('#setting_close').addEventListener('click', function () {
    document.querySelector('.settingModal').classList.add('setting_hide');
});

document.querySelector('.login_white-bg').addEventListener('click', function (event) {
    event.stopPropagation();
});
document.querySelector('.register_white-bg').addEventListener('click', function (event) {
    event.stopPropagation();
});
document.querySelector('.setting_white-bg').addEventListener('click', function (event) {
    event.stopPropagation();
});

document.querySelector('.login_black-bg').addEventListener('click', function () {
    document.querySelector('.loginModal').classList.add('login_hide');
});
document.querySelector('.register_black-bg').addEventListener('click', function () {
    document.querySelector('.registerModal').classList.add('register_hide');
});
document.querySelector('.setting_black-bg').addEventListener('click', function () {
    document.querySelector('.settingModal').classList.add('setting_hide');
});
