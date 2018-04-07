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
                  width: "100px",
                  class: previewClassName,
                  title: file.name
              }));
      };
    })(file);

    reader.readAsDataURL(file);
  });
}
