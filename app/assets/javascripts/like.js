$(function(){

  $(document).on('click', '.like-area', function(){
  // $('.like-area').on('click', function(){
    if($(this).hasClass('disable')){
      return;
    }
    var url = document.URL + '/likes';

    $.ajax({
      url: url,
      type: 'POST',
      dataType: 'json'
    })
    .done(function(data){

    })
    .fail(function(response){

    })
  });
});