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
})