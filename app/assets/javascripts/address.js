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
  ProductList.init(".category-list");
  ViewProduct.init();
  ViewProduct.render();
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

      this.init_filter_events();
    }
  },
  init_filter_events: function(){
    $(".color-filter").on("click",function(){
      if($(this).hasClass("selected")){
        $(this).removeClass("selected");
      }else{
        $(this).addClass("selected");  
      }
      ProductList.ajax_request();
    });

    $(".brand-filter").on("click",function(){
      ProductList.ajax_request();
    });


    $(".size-filter").on("click",function(){
      ProductList.ajax_request();
    });

    $(".price-filter").on("click",function(){
      ProductList.ajax_request();
    });


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
    });

    size_selected = new Array();
    $('.size-filter:checked').each(function(index){
      size = $(this).val().split(",")[1].trim();
      size_selected.push(size);
    });

    per_page = $(".active-per").attr("data-length");

    $.ajax({
      method: "GET",
      url: category_path,
      data: {size_selected: size_selected,color_selected: color_selected,brand_selected: brand_selected,price_selected: price_selected,per_page: per_page},
      }).done(function(data) {
      
      });
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
    console.log(product_info);
    saved_cookies = Cookies.get("product-views");
    list_views = new Array();
    if(saved_cookies !=""){
      list_views = jQuery.parseJSON(saved_cookies);
    }
    
    
    product={};
    product["main_image_url"] = "http://macys-o.scene7.com/is/image/MCY/products/" + product_info.main_image_url;
    product["product_id"]= product_info.id;
    product["name"] =  product_info.short_desc;
    product["regular_price"] = product_info.regular_price;
    product["sale_price"] = product_info.sale_price;
    list_views = jQuery.grep(list_views, function(obj) {
      console.log(obj.product_id);
      console.log(product.id);
        return obj.product_id !== product_info.id;
    });
    console.log(list_views);
    if(list_views.length<10){
      list_views.unshift(product);
    }else{
      list_views.pop();
      list_views.unshift(product);
    }

    Cookies.set("product-views",list_views);
  },
  render: function(){
    saved_cookies = Cookies.get("product-views");
    if(saved_cookies !=""){
      list_views = jQuery.parseJSON(saved_cookies);
      
      jQuery.each(list_views,function(index,value){
        regular_price = ViewProduct.show_price(value.regular_price);
        sale_price = ViewProduct.show_price(value.sale_price);
        li = $("<li></li>");
        link_a = $("<a></a>").attr("href","/products/" + value.product_id);
        div_single = $("<div></div>").addClass("recent-view-single-item");
        image = $("<img></img>").attr("src",value.main_image_url+"?wid=126&hei=154").appendTo(div_single);
        title = $("<p></p>").html(value.name).appendTo(div_single);
        reg_price = $("<span></span>").addClass("reg-price").html("<strong> Reg. $" + regular_price + "</strong>").appendTo(div_single);
        sale_price = $("<span></span>").addClass("sale-price").html("<strong> Ssle. $" + sale_price + "</strong>").appendTo(div_single);

        div_single.appendTo(link_a);
        link_a.appendTo(li);
        li.appendTo("#content-slider");
      });

      $(".recent-view").removeClass("hide");
      $("#content-slider").lightSlider({
                loop:false,
                keyPress:true,
                item: 6
            });
    }
    

  },
  show_price: function(price){
    if(price == null){
      return "";
    }else{
      return price;
    }
  }
}


var Product={
  init: function(selector){
    if($(selector).length >0){
      $("#zoom_03").elevateZoom({gallery:'gallery_01', cursor: 'pointer', galleryActiveClass: "active",loadingIcon: "/loader/ajax-loader.gif"}); 
      // $("#zoom_03").bind("click", function(e) {  
      //   var ez =   $('#zoom_03').data('elevateZoom');
      //   ez.closeAll(); //NEW: This function force hides the lens, tint and window 
      //   $.fancybox(ez.getGalleryList());
      //   return false;
      // });
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
      $('.color-picking.active').removeClass("active");

      color_name = $(this).attr("color-name");
      $(this).addClass("active");
      console.log(color_name);
      $(".product-thumb-image").addClass("hide");
      $(".product-thumb-image active").removeClass("active");
      $(".product-thumb-image[color-name='" + color_name + "']").removeClass("hide").addClass("active");
      $(".product-thumb-image[color-name='" + color_name + "']").trigger("click");
    });

    $(".vertical .carousel").jCarouselLite({
        btnNext: ".vertical .next",
        btnPrev: ".vertical .prev",
        vertical: true
    });


    $(".btn-show-sizechart").on("click",function(){
      console.log("click");
      has_id = $(this).attr("size_id");
      console.log(has_id);
      if(has_id){
        $(".modal-size-chart").find(".image-size-chart").attr("src",has_id);
        $(".modal-size-chart").find(".image-size-chart").removeClass("hide");
        $(".modal-size-chart").modal("show");
      }

    });

  }
}