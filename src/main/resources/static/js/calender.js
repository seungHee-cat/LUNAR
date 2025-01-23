
/*--------------------------------------------------------
 * 년도(윤년)
 --------------------------------------------------------*/
function isLeapYear(year) {
    return (year % 4 == 0 && year % 100 != 0) || year % 400 == 0;
}

const dayOfWeek = ['일', '월', '화', '수', '목', '금', '토'];
let year, month, today, firstDay, lastDay, currentDay;
let table = '';
let curDay = '';
let curDayOfWeek = '';

/*--------------------------------------------------------
 * 캘린더 초기화 설정
 --------------------------------------------------------*/
function initialize() {
    const now = new Date();
    year = now.getFullYear();
    month = now.getMonth();
    today = now.getDate();
    currentDay = 1;

    renderCalender();
}

/*--------------------------------------------------------
 * 이전 달(Month) 선택
 --------------------------------------------------------*/
function prevMonth() {
    if (month == 0) {
        year--;
        month = 11;
    } else {
        month--;
    }
    renderCalender();
    updateMonthList();
}

/*--------------------------------------------------------
 * 다음 달(Month) 선택
 --------------------------------------------------------*/
function nextMonth() {
    if (month == 11) {
        year++;
        month = 0;
    } else {
        month++;
    }
    renderCalender();
    updateMonthList();
}

/*--------------------------------------------------------
 * 오늘 날짜로 돌아가기
 --------------------------------------------------------*/
function goToday() {
    const now = new Date();
    year = now.getFullYear();
    month = now.getMonth();
    today = now.getDate();

    renderCalender();
    updateMonthList();
}

document.querySelector('.today').addEventListener('click', function () {
    goToday();
});

/*--------------------------------------------------------
 * 캘린더 스타일 설정
 --------------------------------------------------------*/
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

/*--------------------------------------------------------
 * 캘린더 렌더링
 --------------------------------------------------------*/
function renderCalender() {
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
    const ratingList = window.initRatingList();

    for (let i = 0; i < ROW; i++) {
        table += `<tr>`;
        for (let j = 0; j < 7; j++) {
            if (i == 0 && j < firstDay.getDay()) {
                table += `<td></td>`;
            } else if (currentDay <= totalDays) {
                const currentDate = `${year}-${(month + 1 < 10 ? '0' : '') + (month + 1)}-${(currentDay < 10 ? '0' : '') + currentDay}`;

                const matchingRatings = Array.isArray(ratingList)
                    ? ratingList.filter(rating => {
                        const ratingDate = new Date(rating.wrtTime);
                        const formattedRatingDate = ratingDate.getFullYear() +
                            "-" +
                            String(ratingDate.getMonth() + 1).padStart(2, "0") +
                            "-" +
                            String(ratingDate.getDate()).padStart(2, "0");

                        return formattedRatingDate === currentDate;
                    })
                : [];

                table += `<td>`;
                const ratingPosterCnt = matchingRatings.length;

                if(ratingPosterCnt > 0) {
                    const ratingPosterPath = matchingRatings[0].posterPath;
                    let encodedId = matchingRatings[0].encodedId;
                    let movieId = matchingRatings[0].movieId;
                    let ratingMonth = matchingRatings[0].ratingMonth;

                    table += `<div class="ratingMovie">
                        <div class="ratingPoster" style="cursor: pointer;">
                            <div class="ratingPosterCnt">${ratingPosterCnt}</div>
                            <img src="${ratingPosterPath}" onclick="fn_calenderRatingList('${movieId}', '${encodedId}', '${ratingMonth}');">
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
    document.getElementById('calender').innerHTML = table;
}

initialize();
renderCalender();
