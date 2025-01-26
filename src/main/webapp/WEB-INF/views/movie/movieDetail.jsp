<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">

$(document).ready( function() {
    js_rateChart(); // 원형차트 조회
    js_starRatingAjax(); // 별점 조회
    fn_myReviewAjax(); // 리뷰 조회
    fn_reviewListAjax(); // 리뷰 리스트 조회
});

/*--------------------------------------------------------
| 리뷰 조회
 --------------------------------------------------------*/
function fn_myReviewAjax(){
    let movieId = $("#movieDetailFrm input[name=movieId]").val();
    fn_ajaxRoadDiv("<c:url value='/review/myReviewAjax'/>", "movieId="+movieId, "reviewDiv");
}

/*--------------------------------------------------------
| 리뷰 등록/수정 모달
 --------------------------------------------------------*/
function reviewModal() {
    let formData = new FormData();
    formData.append("movieId", $("#movieDetailFrm input[name=movieId]").val());
    formData.append("title", $("#movieDetailFrm input[name=title]").val());
    formData.append("releaseYear", $("#movieDetailFrm input[name=releaseYear]").val());

    modal.openModal("<c:url value='/review/reviewModal'/>", formData, "medium");
}

/*--------------------------------------------------------
| 모든 리뷰 리스트
 --------------------------------------------------------*/
function fn_reviewListAjax(){
    let movieId = $("#movieDetailFrm input[name=movieId]").val();
    let limit = 5;
    let params = "movieId=" + movieId + "&limit=" + limit;

    fn_ajaxRoadDiv("<c:url value='/review/reviewListAjax'/>", params, "reviewListAjax");
}

/*--------------------------------------------------------
| 평점 차트
 --------------------------------------------------------*/
function js_rateChart(){
   let ctx = document.getElementById('chartAjax').getContext('2d');
   let percentage = (${movie.voteAverage / 5.0 * 100}).toFixed(0);
   let voteCount = $("input[name=voteCount]").val();
   let cntText = "<spring:message code='chart.text.count'/>";

   let percentageColor;
   if (percentage <= 30) {
       percentageColor = '#f44336'; // 빨간색
   } else if (percentage <= 70) {
       percentageColor = '#ffc107'; // 노란색
   } else {
       percentageColor = '#4caf50'; // 초록색
   }

   // 차트 배경색
   let backgroundColor = '#e0e0e0';
   if (percentage <= 30) {
       backgroundColor = '#ffebee';  // 빨간색일 때 배경
   } else if (percentage <= 70) {
       backgroundColor = '#fff8e1';  // 노란색일 때 배경
   } else {
       backgroundColor = '#e8f5e9';  // 초록색일 때 배경
   }

   let myChart = new Chart(ctx, {
       type: 'doughnut',
       data: {
           datasets: [{
               data: [percentage, 100 - percentage],
               backgroundColor: [percentageColor, 'transparent'],
               borderWidth: 0
           }]
       },
       options: {
           responsive: true,
           circumference: Math.PI * 2,
           rotation: -Math.PI / 2,
           plugins: {
               legend: {
                   display: false
               }
           },
           tooltips: {
               enabled: true,
               callbacks: {
                   label: function(tooltipItem, data) {
                       return cntText +" : "+ voteCount;
                   }
               }
           },
           cutoutPercentage: 90,
       },
       plugins: [{
          beforeDraw: function(chart) {
              const ctx = chart.ctx;
              const width = chart.width;
              const height = chart.height;
              const percentageFontSize = 25;
              const symbolFontSize = 20;
              const fontFamily = 'SUIT-Regular';
              const label = percentage + '%';

              ctx.save();

              // 가운데 배경색을 그리기
              ctx.fillStyle = backgroundColor;
              ctx.beginPath();
              ctx.arc(width / 2, height / 1.85, (height / 1.7) * 0.8, 0, Math.PI * 2);
              ctx.fill();

              // 숫자(percentage) 부분 폰트 크기와 색상 설정
              ctx.font = "bold "+percentageFontSize + "px " + fontFamily;
              ctx.fillStyle = percentageColor;
              ctx.textAlign = 'center';
              ctx.textBaseline = 'middle';
              ctx.fillText(percentage, width / 2.1, height / 1.47);

              // '%' 기호 폰트 크기와 위치 설정
              ctx.font = symbolFontSize + "px " + fontFamily;
              ctx.fillText('%', width / 1.7 + ctx.measureText(percentage).width / 2, height / 1.45);

              ctx.restore();
          }
       }]
   })
};


/*--------------------------------------------------------
| 별점 평가 Ajax
 --------------------------------------------------------*/
function js_starRatingAjax(){
    let movieId = $("#movieDetailFrm input[name=movieId]").val();

    fn_ajaxRoadDiv("<c:url value='/rating/myRatingAjax'/>", "movieId="+movieId, "myRatingAjax");
}

</script>

<form id="movieDetailFrm" name="movieDetailFrm">
<input type="hidden" name="movieId" value="<c:out value='${movie.movieId}'/>"/>
<input type="hidden" name="title" value="<c:out value='${movie.title}'/>"/>
<input type="hidden" name="releaseYear" value="<c:out value='${movie.releaseYear}'/>"/>
<div class="container p-0" style="max-width: 1680px;">
    <!--  상단 영화 DIV -->
    <div class="background-container">
        <img class="background-div" src="${movie.backdropPath}">
        <!-- 그라데이션 효과 -->
        <div class="gradient-overlay"></div>
        <div class="content-wrapper d-flex flex-column h-100 justify-content-end p-5">
            <h1 class="mb-4 fw-bold text-white">${movie.title}</h1>
            <div class="desc_detail">
                <div class="text-white">${movie.originalTitle} (${movie.releaseYear}, ${movie.productionCountries})</div>
                <div>
                    <span class="text-white">${movie.genreIds}</span>
                </div>
                <div class="text-white">${movie.runtime}</div>
            </div>
        </div>
    </div>
    <!-- 하단 영화 상세설명 DIV -->
    <div class="d-flex align-items-center justify-content-evenly pb-3" style="background-color: white; margin: 0px;">
        <!-- Left Section -->
        <div class="col-3 mt-3 left-section">
            <img class="poster-div" src="${movie.posterPath}">
        </div>
        <!-- Right Section -->
        <div class="col-9 mt-3 right-section">
            <div class="d-flex w-100 py-3 border-5" style="background-color: #f9f9f9; border: 1px solid #e7e7e7;">
                <div class="d-flex w-100 flex-column justify-content-around" >
                    <div class="d-flex flex-row" style="border: none;">
                        <div style="position: relative;" class="col-3 d-flex flex-column align-items-center justify-content-center">
                            <!-- Chart Ajax -->
                            <div class="text-center">
                                <canvas id="chartAjax" style="width: 150px; height: 150px;"></canvas>
                                <input type="hidden" name="voteCount" value="${movie.voteCount}">
                            </div>
                            <img style="position: absolute; top: 38px; width: 47px; height: 47px; border-radius: 50%"
                                src="/file/images/popcorn.png">
                            <!-- Star rating -->
                            <div id="myRatingAjax"></div>
                        </div>
                        <div class="col-8">
                            <div class="my-1">
                                <c:if test="${not empty movie.tagline}">
                                    <p class="h4 card-text mt-4 fw-bold">${movie.tagline}</p>
                                </c:if>
                                <p class="card-text pt-3 mb-3" style="font-size: 1.1rem; word-break:keep-all;">
                                    <c:if test="${empty movie.overview}">
                                        <spring:message code="movie.overview.none"/>
                                    </c:if>
                                    <c:if test="${not empty movie.overview}">
                                        ${movie.overview}
                                    </c:if>
                                </p>
                            </div>
                        </div>
                    </div>
                    <!-- 리뷰 Ajax -->
                    <div id="reviewDiv"></div>
                </div>
            </div>
        </div>
    </div>
    <!-- 상위 5개 리뷰 리스트 Ajax -->
    <div id="reviewListAjax"></div>
</div>
</form>