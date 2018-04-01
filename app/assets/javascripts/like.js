$(function(){

  $(document).off('click', '.like-area');
  $(document).on('click', '.like-area', function(){
    if($(this).hasClass('disable')){
      return;
    }

    var url = "";
    var like_method = "";

    if($(this).children('.like-true').size() !== 0) {
      url = document.URL + '/likes/';
      url += $(".like-true").attr('id');
      like_method = "DELETE";
    } else {
      url = document.URL + '/likes';
      like_method = "POST";
    }

    $.ajax({
      url: url,
      type: like_method,
      dataType: 'json'
    })
    .done(function(data){
      $('.like-count').text(data.count);

      if(like_method == "POST") {
        $(".like-false").addClass('like-true');
        $(".like-false").attr('id', data.like_id);
        $(".like-false").removeClass('like-false');
        $(".img-like").attr('src', "/assets/icon_heart_true.svg");
      } else {
        $(".like-true").addClass('like-false');
        $(".like-true").removeClass('like-true');
        $(".img-like").attr('src', "/assets/icon_heart_false.svg");
      }
    })
    .fail(function(response){

    })
  });
});
