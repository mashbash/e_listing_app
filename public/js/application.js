$(document).ready(function(){
  
  $(".allcategories").on('submit', function(e){
    e.preventDefault();
    $.ajax({
      type: this.method,
      url: this.action,
      data: $(this).serialize(),
      dataType: "html",
    }).success(function(data) {
      $('.listings').html(data);
      //refresh every 15secs? how to call on partial html
    });
  });

  //click on categories and make search form appear and disappear

});
