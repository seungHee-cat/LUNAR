let serverRating = $("input[name='rating']").val();
console.log("jsp에서 hidden으로 보낸 serverRating: " + serverRating);
let initialRating = !serverRating ? 0 : parseFloat(serverRating);
let rateFlag = false; // 초기 별점 체크
	
$('.half-star-ratings').rateYo({
	rating: initialRating,
    numStars: 5,
    precision: 2,
    halfStar: true,
    starWidth: "45px",
    ratedFill: "#E74C3C",
    onChange: function (rating) {
        console.log('별점 변경: ' + rating);
        const formattedRating = rating % 1 === 0 ? rating.toFixed(1) : rating;
        let movie_id = $("input[name='movie_id']").val();
        
        let ajaxUrl = rateFlag ? 'updateStar.do' : 'insertStar.do';

        $.ajax({
            url: ajaxUrl,
            type: 'POST',
            data: {
                rating: formattedRating,
                movie_id: movie_id
            },
            dataType: "text",
            success: function () {
                console.log(ajaxUrl + '성공');
                rateFlag = true;
            },
            error: function (error) {
                console.error('에러 발생 : ', error);
            }
        });
    }
});