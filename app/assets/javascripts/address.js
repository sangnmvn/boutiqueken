var Address = {
  init: function(selector){
    if($(selector).length >0){
      $("#address_country").on("change",function(){
        select_wrapper = $(".state-div");
        country_code =$(this).val();
        url ="/home/subregions?country=" + country_code
        select_wrapper.load(url);
      });
    }
  }
}

$(function(){
  Address.init(".address-form");
  ProductList.init(".product-list");
  ViewProduct.init();
  $("#content-slider").lightSlider({
                loop:true,
                keyPress:true
            });
  Product.init(".image-product-detail");
});



var ProductList = {
  init: function(selector){
    if($(selector).length >0){
      $(".per-page").on("click",function(){
        per_page = $(this).attr("data-length")
        $.ajax({
          method: "GET",
          url: category_path,
          data: {per_page: per_page},
          }).done(function(data) {
          
          });
      });
    }
  },
  reinit_per_page: function(){
    $(".per-page").on("click",function(){
        per_page = $(this).attr("data-length")
        $.ajax({
          method: "GET",
          url: category_path,
          data: {per_page: per_page},
          }).done(function(data) {
          
          });
      });
  }
}


var ViewProduct ={
  init: function(){

    check = Cookies.get('product-views');
    if(check==null || typeof(check)=="undefined"){
      Cookies.set('product-views',"");
    }
  },
  setview: function(product_info){
    list_views = jQuery.parseJSON(Cookies.get("product-views"));
    product={};
    product["main_image_url"] = product_info["main_image_url"];
    product["product_id"]= product_info["id"];
    product["regular_price"] = product_info["regular_price"];
    product["sale_price"] = product_info["sale_price"];
    
    if(list_views.length<10){
      list_views.push(product);
    }else{
      list_views.shift();
      list_views.push(product);
    }

    Cookies.set("product-views",list_views);
  },
  render: function(){
    html = '<h1><Recently Viewed</h1><div class="recent-view-all-item"><div class="item"><ul id="content-slider" class="content-slider"><li>';
    list_views = jQuery.parseJSON(Cookies.get("product-views"));

    if(list_views.length >0){
      $(".recent-view").html(html);
    }

  }
}


var Product={
  init: function(selector){
    if($(selector).length >0){
      $("#zoom_03").elevateZoom({gallery:'gallery_01', cursor: 'pointer', galleryActiveClass: "active",loadingIcon: "http://www.elevateweb.co.uk/spinner.gif"}); 
      $("#zoom_03").bind("click", function(e) {  
        var ez =   $('#zoom_03').data('elevateZoom');
        ez.closeAll(); //NEW: This function force hides the lens, tint and window 
        $.fancybox(ez.getGalleryList());
        return false;
      });
      this.init_events();       
      
    }
  },

  init_events: function(){
    var c_element;
    $(".color-picking").on("click",function(){

    //   data_image = $(this).attr("product-image");
    //   console.log(data_image);
    //   data_large_image = $(this).attr("product-large-image");
    //   image_t = "<img src = '" + data_image +"' width='100'/>";
    //   $("#gallery_01 .active").removeClass("active");
    //   c_element = $("<a></a>").addClass("elevatezoom-gallery width-25 active").attr("href","#").attr("data-update","").attr("data-image",data_image).attr("data-zoom-image",data_large_image).html(image_t).appendTo("#gallery_01");
      
    // });
    // setTimeout(function(){
    //   $("#zoom_03").elevateZoom({gallery:'gallery_01', cursor: 'pointer', galleryActiveClass: "active",loadingIcon: "http://www.elevateweb.co.uk/spinner.gif"}); 
    //         $("#zoom_03").bind("click", function(e) {  
    //           var ez =   $('#zoom_03').data('elevateZoom');
    //           ez.closeAll(); //NEW: This function force hides the lens, tint and window 
    //           $.fancybox(ez.getGalleryList());
    //           return false;
    //         });
    // },500);
    
    // $(c_element).trigger("click");

      color_name = $(this).attr("color-name");
      console.log(color_name);
      $(".product-thumb-image").addClass("hide");
      $(".product-thumb-image active").removeClass("active");
      $(".product-thumb-image[color-name='" + color_name + "']").removeClass("hide").addClass("active");
      $(".product-thumb-image[color-name='" + color_name + "']").trigger("click");
    });
  }
}