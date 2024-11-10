// 검색 keyup 이벤트
$('#searchKeyword').on("keyup", function (){
	let searchKeyword = $(this).val();
	let searchUl = $('.search_ul');
	
	if (searchKeyword === '') {
        searchUl.addClass('search_hide');
        return;
    }

    $.ajax({
        type: "get",
        url: "getSearchMovieTitle.do",
        data: {"searchKeyword": searchKeyword},
        dataType: "json",
        success: function(data) {
        	searchUl.removeClass('search_hide');
            let html = '';
            let movies = Array.isArray(data) ? data : [data];
            
            $.each(movies, function (index, movie) {
            	html += '<li class="search-movie" data-movie-id="' + movie.movie_id + '">' + movie.title + '</li>';
            });

            searchUl.html(html);
        },
        error: function(error) {
            console.log(error);
            searchUl.addClass('search_hide');
        }
    });
});

$('.search_ul').on("click", ".search-movie", function () {
    let selectedMovieId = $(this).data('movie-id');
    console.log('Selected Movie ID:', selectedMovieId);
    if (selectedMovieId !== undefined) {
        window.location.href = 'content.do?movie_id=' + selectedMovieId;
    }
});

$('#searchKeyword').on("change", function (){
    $('.ajaxData').html('');
});

// 검색 버튼 클릭, 엔터 쳤을 때
$('#search_btn').on("click", function () {
    searchBtnFunc();
});

$('#searchKeyword').on("keyup", function(e){
	if(e.key === 'Enter'){
		searchBtnFunc();
	}
})

function searchBtnFunc(){
	let searchKeyword = $('#searchKeyword').val();
	
	if (searchKeyword === '') {
        return;
    }

    $.ajax({
        type: "get",
        url: "getSearchMovieTitle.do",
        data: {"searchKeyword": searchKeyword},
        dataType: "json",
        success: function(data) {
            let movies = Array.isArray(data) ? data : [data];
            let html = '';
            let searchUl = $('.search_ul');
            
            $.each(movies, function (index, movie) {
            	html += '<li class="search_movie" data_movie_id="' + movie.movie_id + '">' + movie.title + '</li>';
            });

            searchUl.html(html);
            window.location.href = 'search.do?searchKeyword='+searchKeyword;
        },
        error: function(error) {
            console.log(error);
        }
    });
}
