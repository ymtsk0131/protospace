$(function(){

  $('.like-area').on('click', function(){
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