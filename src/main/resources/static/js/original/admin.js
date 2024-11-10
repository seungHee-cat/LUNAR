function showMoviesTab(){
	window.location.href = `admin_main.do`;
}
function showUsersTab(){
	window.location.href = `admin_user.do`;
}
function showRatingsTab(){
	window.location.href = `admin_rating.do`;
}
function showCommentsTab(){
	window.location.href = `admin_comments.do`;
}
function showReplysTab(){
	window.location.href = `admin_reply.do`;
}

function deleteUserConfirm(userId){
	alert("유저 삭제를 진행합니다. 정말로 삭제하시겠습니까?");
	const confirmMsg = confirm("유저를 삭제하시겠습니까?");
	
	if (confirmMsg) {
        window.location.href = `deleteUser.do?id=${userId}`;
    } else {
        alert("삭제가 취소되었습니다.");
    }
}

function deleteRatingConfirm(ratingId){
	let confirmMsg = confirm("평점을 삭제하시겠습니까?");

    if (confirmMsg) {
        window.location.href = `deleteRating.do?rating_id=${ratingId}`;
    } else {
        return false;
    }
}

function deleteCommentConfirm(commentId){
	let confirmMsg = confirm("코멘트를 삭제하시겠습니까?");

    if (confirmMsg) {
        window.location.href = `deleteCommentByAdmin.do?comment_id=${commentId}`;
    } else {
        return false;
    }
}

function deleteReplyConfirm(replyId){
	let confirmMsg = confirm("코멘트를 삭제하시겠습니까?");

    if (confirmMsg) {
        window.location.href = `deleteReplyByAdmin.do?reply_id=${replyId}`;
    } else {
        return false;
    }
}
