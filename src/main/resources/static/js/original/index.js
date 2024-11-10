document.addEventListener('click', function () {
    document.querySelector('.search_ul').classList.add('search_hide');
});

const lists = document.querySelectorAll('.lists');
const leftBtns = document.querySelectorAll('.leftBtns');
const rightBtns = document.querySelectorAll('.rightBtns');
const buttons = document.querySelectorAll('.buttons');

lists.forEach(function (list, index) {
    const leftBtn = leftBtns[index];
    const rightBtn = rightBtns[index];
    const button = buttons[index];

    list.addEventListener('mouseover', function () {
        if (rightBtn.style.display !== 'none') {
            rightBtn.style.display = 'block';
            button.style.justifyContent = 'flex-end';
        }
    });
    rightBtn.addEventListener('click', function (event) {
        event.stopPropagation();

        rightBtn.style.display = 'none';
        leftBtn.style.display = 'block';
        button.style.justifyContent = 'flex-start';
        list.style.transition = 'margin-left 0.5s ease';
        list.style.marginLeft = '-100%';
    });

    leftBtn.addEventListener('click', function () {
        leftBtn.style.display = 'none';
        rightBtn.style.display = 'block';
        button.style.justifyContent = 'flex-end';
        list.style.marginLeft = '0';
    });
});
