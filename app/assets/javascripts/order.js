$(function(){

  function buildHTML(prototype){

    var html = `<div class="col-sm-4 col-md-3 proto-content">
                  <div class="thumbnail">
                    <a href="/prototypes/${ prototype.prototype_id }"><img src="/uploads/captured_image/content/${ prototype.prototype_id }/${ prototype.image }" alt=""></a>
                    <div class="caption">
                      <h3>
                        ${ prototype.title }
                      </h3>
                      <div class="proto-meta">
                        <div class="proto-user">
                          <a href="/users/${ prototype.user_id}">${ prototype.user_name }</a>
                        </div>
                        <div class="proto-posted">
                          ${ prototype.posted_date }
                        </div>
                      </div>
                    </div>
                  </div>
                </div>`

    return html;
  }

  $(document).off('click', '.btn-order');
  $(document).on('click', '.btn-order', function(){

    var order_by = "";
    if($(this).hasClass('btn-popular')){
      order_by = "popular";
    }else if($(this).hasClass('btn-newest')){
      order_by = "newest";
    }

    $.ajax({
      url: '/prototypes',
      type: 'GET',
      data: { order_by: order_by },
      dataType: 'json'
    })
    .done(function(prototypes){
      $('.proto-list .row').empty();
      if(prototypes.length !== 0){
        prototypes.forEach(function(prototype){
          var html = buildHTML(prototype);
          $('.proto-list .row').append(html);
        });
      }
    })
    .fail(function(response){

    })
  });
});
