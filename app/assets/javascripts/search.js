var Search = {
  init: function(selector){
    if($(selector).length >0){
      $(".color-filter").on("click",function(){
        $(this).addClass("selected");
        Search.ajax_request();
      });

      $(".brand-filter").on("change",function(){
        Search.ajax_request();
      });

      $(".price-filter").on("change",function(){
        Search.ajax_request();
      });

      $(".per-page").on("click",function(){
        $(".active-per").removeClass("active-per");
        $(this).addClass("active-per");
        Search.ajax_request();
      });
    }
  },
  ajax_request: function(){
    color_selected = new Array();
    $(".color-filter.selected .item_icon").each(function(index){
      color_name = $(this).attr("title");
      color_selected.push(color_name);
    });

    brand_selected = new Array();
    $('.brand-filter:checked').each(function(index){
      brand_name = $(this).val();
      brand_selected.push(brand_name);
    });

    price_selected = new Array();
    $('.price-filter:checked').each(function(index){
      price = $(this).val();
      price_selected.push(price);
    })

    per_page = $(".active-per").attr("data-length");

    $.ajax({
      method: "GET",
      url: search_products_path,
      data: {color_selected: color_selected,brand_selected: brand_selected,price_selected: price_selected,per_page: per_page},
      }).done(function(data) {

    });
    
  }
}

$(function(){  
  Search.init(".search-page");
});