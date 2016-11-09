class HomeController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  layout "static_layout",only: [:about_us,:faq,:domestic_shipping_return,:international_shipping_return,:privacy_policy,:safe_shopping_guarantee,:secure_shopping,:term_of_use]

  protect_from_forgery with: :exception
  def index
    # redirect_to new_user_session_path
  end

  def subregions
  	render partial: "addresses/state_select"
  end
  
  def about_us
  	@seo_title = "Women's Clothing, Shoes & Accessories | Boutiqueken"
    @seo_desc = "Shop women's clothing, shoes, accessories, beauty, and more from your favorite brands and designer collections. Free shipping and returns every day."
    @seo_keywords="boutiqueken,  Shop boutiqueken.com , Women's Apparel, Men's Apparel, Shoes, Handbags, Beauty, makup."
  end


  def faq
  	@seo_title = "Boutiqueken  Online & In Store: Shop Dresses, Shoes, Handbags, Jewelry & More"
    @seo_desc = "Where style meets savings. Shop online or in store for brands you love at up to 70% off. Return by mail or to Boutiqueken  stores. Free shipping on all orders over $100."
    @seo_keywords="boutiqueken,  Shop boutiqueken.com , Women's Apparel, Men's Apparel, Shoes, Handbags, Beauty, makup."
  end

  def domestic_shipping_return
  	@seo_title = "Clothing  Shop: Apparel for Women, Men & Kids | boutiqueken.com"
    @seo_desc = "BOUTIQUEKEN - Clothing FASTEST FREE SHIPPING WORLDWIDE on Clothing & FREE EASY RETURNS"
    @seo_keywords="boutiqueken,  Shop boutiqueken.com , Women's Apparel, Men's Apparel, Shoes, Handbags, Beauty, makup"
  end

  def international_shipping_return
  	@seo_title = "Men and Womens shoes, Shipped Free | BOUTIQUEKEN.COM"
    @seo_desc = "Vast selection of shoes, sandals, accessories, and more! Enjoy free shipping BOTH ways, an amazing 60-day return window, and 24/7 customer service."
    @seo_keywords="boutiqueken,  Shop boutiqueken.com , Women's Apparel, Men's Apparel, Shoes, Handbags, Beauty, makup"
  end

  def privacy_policy
  	
  end

  def safe_shopping_guarantee
    @seo_title = "Boutiqueken  .com - Shoes, clothing, accessories and more on sale!"
    @seo_desc = "Discounted shoes, clothing, accessories and more at Boutiqueken .com! Shop for brands you love on sale. Score on the Style, Score on the Price."
    @seo_keywords="boutiqueken,  Shop boutiqueken.com , Women's Apparel, Men's Apparel, Shoes, Handbags, Beauty, makup"
  	
  end

  def secure_shopping
  	@seo_title = "Online Shoes, Clothing, Free Shipping and Returns| Boutiqueken.com"
    @seo_desc = "Free shipping BOTH ways on online shoes, clothing, and more! 60-day return policy, over 1000 brands, 24/7 friendly customer service."
    @seo_keywords="boutiqueken,  Shop boutiqueken.com , Women's Apparel, Men's Apparel, Shoes, Handbags, Beauty, makup"
  end

  def term_of_use
  	
  end

end
