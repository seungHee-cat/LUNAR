const showBoxes = document.querySelectorAll('.showBox');
const screenH = window.innerHeight / 2;

const isElementInViewport = (element) => {
  const rect = element.getBoundingClientRect();
  return rect.top < screenH && rect.bottom > 0;
};

const showElement = (element, index) => {
  if (index < 4 || isElementInViewport(element)) {
    element.classList.add('on');
  }
};

const handleScroll = () => {
  const scrollY = window.scrollY;
  
  showBoxes.forEach((box, index) => {
    showElement(box, index);
  });
};
window.addEventListener('scroll', handleScroll);

showBoxes.forEach((box, index) => {
  showElement(box, index);
});


// 댓글
document.querySelectorAll('.review_comment').forEach(function (btn) {
    btn.addEventListener('click', function () {
        let commentId = this.getAttribute('data-commentId');
        let replyLists = document.querySelector('.replyLists[data-commentId="' + commentId + '"]');
        
        if (replyLists) {
            replyLists.classList.toggle('hide');
        }
    });
});
	
// 대댓글 
document.querySelectorAll('.viewReply').forEach(function (button) {
    button.addEventListener('click', function () {
        let replyId = this.getAttribute('data-commentId');
        let reReplySections = document.querySelectorAll('.re_reply_section[data-commentId="' + replyId + '"]');
        
        reReplySections.forEach(function (reReplySection) {
            reReplySection.classList.toggle('re_reply_hide');
        });
    });
});


// dropdown
let isMenuOpen = false;

function toggleDropdown() {
    let dropdown = document.getElementById('myDropdown');
    dropdown.classList.toggle('show-dropdown');

    let dropdownIcon = document.getElementsByClassName('expand-icon')[0];
    dropdownIcon.textContent = isMenuOpen ? 'expand_more' : 'keyboard_arrow_up';
    isMenuOpen = !isMenuOpen;
}
window.onclick = function (event) {
    if (!event.target.matches('.dropdown-btn')) {
        let dropdowns = document.getElementsByClassName('dropdown_content');
        let dropdownIcon = document.getElementsByClassName('expand-icon')[0];

        for (let i = 0; i < dropdowns.length; i++) {
            let openDropdown = dropdowns[i];
            if (openDropdown.classList.contains('show-dropdown')) {
                openDropdown.classList.remove('show-dropdown');
                dropdownIcon.textContent = 'expand_more';
                isMenuOpen = false;
            }
        }
    }
};





