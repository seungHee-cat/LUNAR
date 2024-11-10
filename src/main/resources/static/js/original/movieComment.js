const replyLists = document.querySelectorAll('.replyList');
const replyButtons = document.querySelectorAll('.viewReply');

replyButtons.forEach((button, index) => {
    button.addEventListener('click', function() {
        let replyList = replyLists[index];
        let reReplyContainer = replyList.querySelector('.re_reply_container');
        reReplyContainer.classList.toggle('re_reply_hide');
    });
});
function modifyReply(){
	document.querySelector('.replyModifyModal').classList.remove('replyModifyModal_hide');
}

function deleteReply(e){
	e.preventDefault();
	
	if(confirm("정말 삭제하시겠습니까?")){
		const url = document.querySelector("#replyRemove a").getAttribute("href");
		window.location.href=url;
	}
}
function deleteReReply(link){
	if(confirm("정말 삭제하시겠습니까?")){
		const url = link.getAttribute("href");
		window.location.href=url;
		return true;
	}else{
		return false;
	}
}
const replyRemove = document.querySelector('#replyRemove');
if (replyRemove) {
    replyRemove.addEventListener("click", deleteReply);
}

document.querySelector('.reply_btn').addEventListener('click', function () {
    document.querySelector('.replyModal').classList.remove('replyModal_hide');
});

if(document.querySelector('#replyModify')){
	document.querySelector('#replyModify').addEventListener('click', function () {
	    document.querySelector('.replyModifyModal').classList.remove('replyModifyModal_hide');
	});
}

document.querySelector('.replyModal_white-bg').addEventListener('click', function (event) {
    event.stopPropagation();
});
document.querySelector('.replyModifyModal_white-bg').addEventListener('click', function (event) {
    event.stopPropagation();
});
document.querySelector('.replyModal_black-bg').addEventListener('click', function () {
    document.querySelector('.replyModal').classList.add('replyModal_hide');
});
document.querySelector('.replyModifyModal_black-bg').addEventListener('click', function () {
    document.querySelector('.replyModifyModal').classList.add('replyModifyModal_hide');
});
document.querySelector('#replyModal_close').addEventListener('click', function () {
    document.querySelector('.replyModal').classList.add('replyModal_hide');
});
document.querySelector('#replyModifyModal_close').addEventListener('click', function () {
    document.querySelector('.replyModifyModal').classList.add('replyModifyModal_hide');
});

const text_1 = document.querySelector('#text_1');
let charCount_1 = document.querySelector('.charCount_1');
const text_2 = document.querySelector('#text_2');
let charCount_2 = document.querySelector('.charCount_2');

text_1.addEventListener('keyup', function () {
    let charCount = text_1.value.length;

    charCount_1.textContent = charCount;
});

text_2.addEventListener('keyup', function () {
    let charCount = text_2.value.length;

    charCount_2.textContent = charCount;
});
