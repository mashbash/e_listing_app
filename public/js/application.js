$(document).ready(function(){
  $(".allcategories").on('submit', function(e){
    e.preventDefault();
    $.ajax({
      type: this.method,
      url: this.action,
      data: $(this).serialize(),
      dataType: "html",
    }).success(function(data) {
      $('.container').append(data);
    });
  });
});
