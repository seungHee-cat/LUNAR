const btn = document.querySelector('#btn');
btn.addEventListener('click', function(){
	document.querySelector('.settingModal').classList.remove('setting_hide');
})

let userComments = [];
document.addEventListener('DOMContentLoaded', function() {
	let xhr = new XMLHttpRequest();
    xhr.open('GET', './getUserComment.do', true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            userComments = JSON.parse(xhr.responseText);
            console.log(userComments);
            renderCalendar(userComments);
        } else{
            console.log('Error: ' + xhr.status);
        }
    };
    xhr.send();
});
function isLeapYear(year) {
    return (year % 4 == 0 && year % 100 != 0) || year % 400 == 0;
}
const dayOfWeek = ['일', '월', '화', '수', '목', '금', '토'];
const fullNameOfWeek = [
    'SUNDAY',
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
];

let year, month, today, firstDay, lastDay, currentDay;
let table = '';
let curDay = '';
let curDayOfWeek = '';

function initialize() {
    const now = new Date();
    year = now.getFullYear();
    month = now.getMonth();
    today = now.getDate();
    currentDay = 1;

    renderCalendar();
}

function prevMonth() {
    if (month == 0) {
        year--;
        month = 11;
    } else {
        month--;
    }
    renderCalendar(userComments);
    updateMonthList();
}
function nextMonth() {
    if (month == 11) {
        year++;
        month = 0;
    } else {
        month++;
    }
    renderCalendar(userComments);
    updateMonthList();
}
function goToday() {
    const now = new Date();
    year = now.getFullYear();
    month = now.getMonth();
    today = now.getDate();

    renderCalendar(userComments);
    updateMonthList();
}
document.querySelector('.today').addEventListener('click', function () {
    goToday();
});
function updateMonthList() {
    const monthList = document.getElementById('monthList');
    const months = monthList.getElementsByTagName('li');

    for (let i = 0; i < months.length; i++) {
        months[i].style.fontWeight = 'normal';
        if (i == month) {
            months[month].style.color = 'rgb(46, 205, 111)';
            months[month].style.fontWeight = 'bold';
        } else {
            months[i].style.color = 'black';
        }
    }
}
function renderCalendar(userComments) {
    const now = new Date();
    firstDay = new Date(year, month, 1);
    currentDay = 1;

    if (month == 1) {
        if (isLeapYear(year)) {
            lastDay = new Date(year, month, 29);
        } else {
            lastDay = new Date(year, month, 28);
        }
    } else if (month == 3 || month == 5 || month == 8 || month == 10) {
        lastDay = new Date(year, month, 30);
    } else {
        lastDay = new Date(year, month, 31);
    }

    let curYear = year + '.';
    let curMonth = month + 1;
    document.querySelector('.curYear').innerHTML = curYear;
    document.querySelector('.curMonth').innerHTML = curMonth;

    const monthList = document.getElementById('monthList');
    const months = monthList.getElementsByTagName('li');

    for (let i = 0; i < months.length; i++) {
        months[i].style.fontWeight = 'normal';
    }
    months[month].style.color = 'rgb(46, 205, 111)';
    months[month].style.fontWeight = 'bold';

    table = `<table>`;
    table += `<tr>`;
    for (let i = 0; i < 7; i++) {
        table += `<th>${dayOfWeek[i]}</th>`;
    }
    table += `</tr>`;

    const firstWeekDays = 7 - firstDay.getDay();
    const totalDays = lastDay.getDate();
    const remainingDays = totalDays - firstWeekDays;
    const ROW = Math.ceil(remainingDays / 7) + 1;

    for (let i = 0; i < ROW; i++) {
    table += `<tr>`;
    for (let j = 0; j < 7; j++) {
        if (i == 0 && j < firstDay.getDay()) {
            table += `<td></td>`;
        } else if (currentDay <= totalDays) {
            let cellStyle = '';
            if (j == 0) {
                cellStyle = 'color: red;';
            } else if (j == 6) {
                cellStyle = 'color: blue;';
            }

            const currentDate = `${year}-${(month + 1).toString().padStart(2, '0')}-${currentDay.toString().padStart(2, '0')}`;
            const matchingComments = Array.isArray(userComments)
                ? userComments.filter(comment => comment.write_time === currentDate)
                : [];

            table += `<td style="${cellStyle}">`;
            const commentPosterCnt = matchingComments.length;

            if(commentPosterCnt > 0) {
                const commentPosterPath = matchingComments[0].poster_path;

                table += `<div class="reviewedMovie">
                    <div class="commentPoster">
                    	<div class="commentPosterCnt">${commentPosterCnt}</div>
                        <img src="${commentPosterPath}" alt="movie">
                    </div>
                </div>`;
            } else {
                table += `${currentDay}`;
            }
            table += `</td>`;
            currentDay++;
        } else {
            table += `<td></td>`;
        }
    }
    table += `</tr>`;
}
    table += `</table>`;
    document.getElementById('calendar').innerHTML = table;
}
initialize();
renderCalendar();
