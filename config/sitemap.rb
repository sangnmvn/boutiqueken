# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.boutiqueken.com"
SitemapGenerator::Sitemap.create do

  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  add "/secure-user-sign-in-up"
  add "/secure-sign-up"
  add "/faq"
  add "/domestic-shipping-and-return"
  add "/international-shipping-and-return"
  add "/privacy-policy"
  add "/safe-shopping-guarantee"
  add "/secure-shopping"
  add "/term-of-use"
  add "/404"
  add "/500"
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  Product.find_each do |product|
    add product_path(product.to_friend_or_id), :lastmod => product.updated_at
  end

  Category.find_each do |cate|
    add category_path(cate.to_friend_or_id), :lastmod => cate.updated_at
  end
end
