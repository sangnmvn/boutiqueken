//= require jquery
//= require jquery_ujs
//= require bower_assets/js/common.min
//= require bower_assets/js/uikit_custom.min
//= require bower_assets/js/altair_admin_common.min
//= require bower_assets/js/pages/components_notifications.min
//= require bower_assets/js/kendoui_custom.min


var AdminOrder ={
  init: function(selector){
    if($(selector).length>0){
      $(".show-track-modal").on("click",function(){
        id = $(this).attr("data-id");
        $.ajax({
          method: "GET",
          url: "/admin/show_order",
          data: {order_id: id},
        }).done(function(data) {
          
        });
      });

      
    }
  },
  init_select: function(){
    $(".select-order-status").on("change",function(){
        status = $(this).val();
        console.log(status);
        if(status ==4){
          $(".shipped-comments").removeClass("hide");
        }else{
          $(".shipped-comments").addClass("hide");
        }
      });
    $("#kUI_datepicker_a").kendoDatePicker({
      format: "d-MM-yyyy"
    });
  }
}

$(function(){
  AdminOrder.init(".order-mgmt");
});