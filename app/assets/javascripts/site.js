$(document).ready(function(){
    $("#sidebar-wrapper > ul > li > a").click(function(){
		$("#sidebar-wrapper > ul > li.active > a").parent().removeClass("active");
        $(this).parent().addClass("active");
    });	

	var window_height = $(window).height();
	var ee = $(".navigation_top").height();
	var ff = $("#wrapper").height();
	
    var hh = $("body").height();
	var bb = parseInt(window_height) - parseInt(ee);
	$("#sidebar-wrapper").css("min-height", bb);
        $("#page-content-wrapper").css("min-height", bb);
        $('#wrapper').css("min-height", bb +"px");
    
    
    
    
    $(".panel-group > div > .panel-heading").click(function () {
        $(this).parent().toggleClass("selector").siblings().removeClass("selector");
    }); 
	
    $(".dropdown_custom .dropdown_custom_toggle button").click(function(){
        var thisBtn = $(this);
        $(".dropdown_custom_menu").slideToggle("slow", function(){
          if($('.dropdown_custom_menu').is(":visible")){
            thisBtn.find('i').removeClass('fa-plus').addClass('fa-minus');
          }else{
            thisBtn.find('i').removeClass('fa-minus').addClass('fa-plus');
          }
        });
    });
    
    $('.dropdown_custom_menu').on('click', 'button.close-proj', function(){
      $(".dropdown_custom_menu").slideUp("slow", function(){
        $(".dropdown_custom .dropdown_custom_toggle button").find('i').removeClass('fa-minus').addClass('fa-plus');
      });
    });
    
  $('#frmContractProposals').keypress(
    function (event) {
      if (event.which == '13') {
        event.preventDefault();
      }
  });
  
  $('#sidebar-wrapper').find('li.select').parents('li.sub_link').addClass('active');
  
  $('form').submit(function(){
    var form = $(this);
    $('input').each(function(i){
        var self = $(this);
        try{
            var v = self.autoNumeric('get');
//            self.autoNumeric('destroy');
            self.val(v);
        }catch(err){}
    });
    return true;
  });

});

function myPrint() {
    window.print();
}

