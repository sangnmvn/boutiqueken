$(document).ready(function(){
  
  //OWN CAROUSEL
  $("#owl-demo").owlCarousel({
	  autoPlay: 3000, 
	  items : 8,
	  itemsDesktop : [1199,8],
	  itemsDesktopSmall : [979,6],
	  itemsTablet: 	[768,4],
	  itemsMobile: 	[479,2],
	      // Navigation
      navigation : true,
      navigationText : ['<i class="fa fa-angle-left" aria-hidden="true"></i>','<i class="fa fa-angle-right" aria-hidden="true"></i>'],
      rewindNav : true,
      scrollPerPage : false
  });

  //Mobile menu
  // $('.m-trigger').on('click', function(){
  // 	$('.main-navigation-mobile').css({
  // 		'right'   : '0',
  // 		'display' : 'block'
  // 	});
  // });
  // $('.close-close').find('span').on('click', function(){
  // 	$('.main-navigation-mobile').css({
  // 		'right'   : '-32rem',
  // 		'display' : 'none'
  // 	});
  // });

  //Mobile menu
  $('.m-trigger, .close-close a').on('click', function(e){
    e.preventDefault()

    $('body').toggleClass('navbar-open');

    if ( $('.m-trigger .fa').hasClass('fa-bars') ) {
      $('.m-trigger .fa').removeClass('fa-bars').addClass('fa-times');
    } else {
      $('.m-trigger .fa').removeClass('fa-times').addClass('fa-bars');
    }
  });

  $.sidebarMenu($('.sidebar-menu'));

  //input required
  setTimeout(function(){
    $('input[required="required"]').before('<span class="reqf">*</span>');
    $('select[required="required"]').closest('.select').before('<span class="reqf">*</span>');
  },200)
  

  //product aside bar toggling
  $('.trigger').on('click', function(){
    if($(this).hasClass("sub-trigger")){
      $(this).parent().find('ul').slideToggle();
    }
    else if($(this).parent().find(".sub-group-name").length>0){
      $(this).parent().find(".sub-group-name ul").slideToggle();
    }
    else{
      $(this).siblings('ul').slideToggle();
    }
    
    var arrow = $(this).find('i');
    
    if(arrow.hasClass('fa-chevron-right')){
      arrow.removeClass('fa-chevron-right').addClass('fa-chevron-down');
    }else if(arrow.hasClass('fa-chevron-down')){
      arrow.removeClass('fa-chevron-down').addClass('fa-chevron-right');
    }
    else if(arrow.hasClass('fa-plus-square')){
      arrow.removeClass('fa-plus-square').addClass('fa-minus-square');
    }
    else if(arrow.hasClass('fa-minus-square')){
      arrow.removeClass('fa-minus-square').addClass('fa-plus-square');
    }

    
  });

  //Product details features toggling
  $('.single-product-feat').find('strong').on('click', function(){
    $(this).siblings('.feat-content').slideToggle(200);
    var arrow = $(this).find('i');
    if(arrow.hasClass('fa-angle-right')){
      arrow.removeClass('fa-angle-right').addClass('fa-angle-down');
    }else{
      arrow.removeClass('fa-angle-down').addClass('fa-angle-right');
    }
  });

  //My Account navigation
  // $('.ul-account li').find('a').on('click', function(){
  //   $(this).closest('li').addClass('active').siblings().removeClass('active');
  // });
  //Information Area Hide/Show
  // $('.ul-account li').find('a').on('click', function(e){
  //   e.preventDefault();
  //   var ulA = $(this).data('account');
  //   $('.all-informations-wrapper').find('.single-account').filter("[data-account='" + ulA + "']").siblings('.single-account').removeClass('show');
  //   $('.all-informations-wrapper').find('.single-account').filter("[data-account='" + ulA + "']").addClass('show');
  //   // $('.all-informations-wrapper').find('.single-account').filter("[id='" + ulA + "']").siblings().hide();
  // });

  //Change password trigger
  setTimeout(function(){
    if($(".profile-page").length >0){
      // $('.change-password-trigger').find('input').attr('checked', 'checked');
      $('.change-password-trigger').click( function(){
        $('.change-password-slideToggle').slideToggle(250);
        if ($('.change-password-trigger input').attr('checked')) {
            $('.change-password-trigger input').removeAttr('checked');
        } else {
            $('.change-password-trigger input').attr('checked', 'checked');
        }
      });

    }else{
      $('.change-password-trigger').find('input').attr('checked', 'checked');
      $('.change-password-trigger').click( function(){
        $('.change-password-slideToggle').slideToggle(250);
        if ($('.change-password-trigger input').attr('checked')) {
            $('.change-password-trigger input').removeAttr('checked');
        } else {
            $('.change-password-trigger input').attr('checked', 'checked');
        }
      });
    }
    
  },200)

  

  //dashboard Alert
  $('.dashboard-welcome-alert').find('.close').on('click', function(){
    $(this).closest('.dashboard-welcome-alert').fadeOut(200);
  });

  //Single Order
  $('.order-links').find('a').on('click', function(e){
    e.preventDefault();
    var pro = $(this).data('order');
    $('.single-order-wrapper').find('.single-product-order-details').filter("[data-order='" + pro + "']").siblings('.single-product-order-details').fadeOut(350);
    $('.single-order-wrapper').find('.single-product-order-details').filter("[data-order='" + pro + "']").fadeIn(350);
    $(this).closest('.my-order-list').fadeOut(100);
  });

  $('.single-order-wrapper').find('.signup-submit-buttons').find('button').on('click', function(){
    $(this).closest('.single-product-order-details').fadeOut(100);
    $(this).closest('.single-order-wrapper').siblings('.my-order-list').fadeIn(350);
  });


  
  $('dd').filter(":nth-child(n+4)").hide();
  $('dt').on('click', function(){
    $(this).next().slideToggle().siblings('dd').slideUp();
    $(this).find('.fa-plus').toggleClass("rote-me");
    $(this).siblings('dt').find('.fa-plus').removeClass("rote-me");
  });

  var eachColorImg = $('.coloring-ul').find('li');

  eachColorImg.on({
    mouseenter : function(){
      var textColor = $(this).data('color');
      $('.coloring').find('span').text(textColor);
    },
    mouseout : function(){
      // $('.coloring').find('span').text("");
    }
  });

//Product color

  var productColorImg = $('.product-details-info').find('.coloring-ul').find('li'),
      productLargeImg = $('.product-img-wrapper').find('img');

  productColorImg.on({
    click: function(e){
      e.preventDefault();
      $(this).addClass('active').siblings().removeClass('active');

      var thumbActive = $(this).data('img');

      $(this).closest('.single-product').find(productLargeImg)
        .filter("[data-img='" + thumbActive + "']")
        .addClass('active')
          .siblings().removeClass('active');
    }
  });


});