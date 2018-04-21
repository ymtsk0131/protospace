// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .

$(function(){
  //画像ファイルプレビュー表示のイベント追加 fileを選択時に発火するイベントを登録
  $(document).on('change', '.cover-image-upload', function(e) {
    var file = e.target.files[0],
        reader = new FileReader(),
        $preview = $(".main-thumbnail-preview");
        t = this;

    // 画像ファイル以外の場合は何もしない
    if(file.type.indexOf("image") < 0){
      return false;
    }

    // ファイル読み込みが完了した際のイベント登録
    reader.onload = (function(file) {
      return function(e) {
        //既存のプレビューを削除
        $preview.empty();
        // .prevewの領域の中にロードした画像を表示するimageタグを追加
        $preview.append($('<img>').attr({
                  src: e.target.result,
                  width: "350px",
                  class: ".main-thumbnail-preview",
                  title: file.name
              }));
        $(".img-existed").css({ "display": "none" });
      };
    })(file);

    reader.readAsDataURL(file);
  });
});

$(function() {
  for(var i = 1; i <= 3; i++) {
    previewSubImage(i);
  }
});

function previewSubImage(label) {
  var eventClassName = ".image-upload-" + label;
  var previewClassName = ".sub-thumbnail-preview-" + label;
  var existedImageClassName = ".img-existed-" + label;

  //画像ファイルプレビュー表示のイベント追加 fileを選択時に発火するイベントを登録
  $(document).on('change', eventClassName, function(e) {
    var file = e.target.files[0],
        reader = new FileReader(),
        $preview = $(previewClassName);
        t = this;
    // 画像ファイル以外の場合は何もしない
    if(file.type.indexOf("image") < 0){
      return false;
    }

    // ファイル読み込みが完了した際のイベント登録
    reader.onload = (function(file) {
      return function(e) {
        //既存のプレビューを削除
        $preview.empty();
        // .prevewの領域の中にロードした画像を表示するimageタグを追加
        $preview.append($('<img>').attr({
                  src: e.target.result,
                  // width: "100%",
                  class: previewClassName,
                  title: file.name
              }));
        $(existedImageClassName).css({ "display": "none" });
      };
    })(file);

    reader.readAsDataURL(file);
  });
}
