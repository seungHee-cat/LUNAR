const boxofficeSlide = 300.5; // 박스오피스 최대 이동 비율
const otherSlide = 500.5; // 나머지 최대 이동 비율
const step = 100.5; // 한 번 이동할 때의 비율

function updateSliderPosition(movieType, index) {
  let wrapper;

  if (movieType === 'boxoffice') {
    wrapper = document.querySelector('.boxoffice-card-slider');

  } else if (movieType === 'netflix'){
    wrapper = document.querySelector('.netflix-card-slider');

  } else if (movieType === 'watcha'){
    wrapper = document.querySelector('.watcha-card-slider');
  }
  wrapper.style.transform = `translateX(-${index * step}%)`;

}

/* boxoffice */
let boxofficeIndex = 0;
const boxofficeWrapper = document.querySelector('.boxoffice-card-slider');
const boxofficePrevBtn = document.querySelector('.boxoffice-prev-btn');
const boxofficeNextBtn = document.querySelector('.boxoffice-next-btn');

boxofficePrevBtn.addEventListener('click', function() {
  if (boxofficeIndex > 0) {
      boxofficeIndex--;
      updateSliderPosition('boxoffice', boxofficeIndex);
  }
});

boxofficeNextBtn.addEventListener('click', function() {
  if (boxofficeIndex * step < boxofficeSlide) {
      boxofficeIndex++;
      updateSliderPosition('boxoffice', boxofficeIndex);
  }
});

/* netflix */
let netflixIndex = 0;
const netflixCardsWrapper = document.querySelector('.netflix-card-slider');
const netflixPrevBtn = document.querySelector('.netflix-prev-btn');
const netflixNextBtn = document.querySelector('.netflix-next-btn');

netflixPrevBtn.addEventListener('click', function() {
  if (netflixIndex > 0) {
      netflixIndex--;
      updateSliderPosition('netflix', netflixIndex);
  }
});

netflixNextBtn.addEventListener('click', function() {
  if (netflixIndex * step < otherSlide) {
      netflixIndex++;
      updateSliderPosition('netflix', netflixIndex);
  }
});

/* watcha */
let watchaIndex = 0;
const watchaCardsWrapper = document.querySelector('.watcha-card-slider');
const watchaPrevBtn = document.querySelector('.watcha-prev-btn');
const watchaNextBtn = document.querySelector('.watcha-next-btn');

watchaPrevBtn.addEventListener('click', function() {
  if (watchaIndex > 0) {
      watchaIndex--;
      updateSliderPosition('watcha', watchaIndex);
  }
});

watchaNextBtn.addEventListener('click', function() {
  if (watchaIndex * step < otherSlide) {
      watchaIndex++;
      updateSliderPosition('watcha', watchaIndex);
  }
});
