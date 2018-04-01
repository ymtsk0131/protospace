$(function(){

  $(document).on('click', '.like-area', function(){
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
      $('.like-count').text(data.count);
    })
    .fail(function(response){

    })
  });
});