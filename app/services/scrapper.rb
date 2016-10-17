class Scrapper

  FEATURE_CATE_LIMIT = {
    "HOME" => 4,
    "ACTIVE" => 10
  }

  def initialize
    @root_url = 'https://www.macys.com'
    @agent = Mechanize.new

    #TODO: 
    #+ root url and proxy should be loaded from configuration
    #+ change country before scrapping
    @agent.set_proxy '96.9.252.126', 8080
    #@agent.set_proxy '127.0.0.1', 5555
  end

  def process
    # scrape home page
    page = @agent.get(@root_url)

    # scrape menu
    scrape_menu(page)
  end

  def scrape_menu(page)
    menu = page.search("#globalMastheadCategoryMenu")

    puts "\nMain Menu"
    puts "---------"
    menu.search("li").each do |mnu_item|
      cat_id = mnu_item.attributes["id"].value.split("_").last

      anchor = mnu_item.search("a").first
      cat_name = anchor.text
      cat_url = @root_url + anchor.attributes["href"].value

      puts "\n#{cat_name} - #{cat_url}"
      #scrape_sub_menu(page, cat_id)

      scrape_left_nav(cat_name, cat_url)
    end
  end

  def scrape_sub_menu(page, cat_id)
    sub_menu_id = "#Flyout_#{cat_id}"

    cat_divs = page.search("#globalMastheadFlyout").search(sub_menu_id)

    cat_divs.search(".//div[@class='flexLabelLinksContainer']").each do |cat_div|
      cat_div.search("li").each do |leaf_cat|
        if leaf_cat.children.first.name == "label"
          group_cat_name = leaf_cat.children.first.text

          puts "+ #{group_cat_name}" unless group_cat_name.blank?
        else
          if leaf_cat.search("a").count > 0
            cat = leaf_cat.search("a").first

            # remove clearance links
            if cat.attributes["class"].nil?
              cat_name = cat.text

              puts "  - #{cat_name}" unless cat_name.blank?
            end
          end
        end
      end
    end
  end

  def scrape_left_nav(root_cat_name, url)
    page = @agent.get(url)

    # crawl left nav
    puts "\nScrapping Left Nav of #{url}"
    if root_cat_name == 'BRANDS'
      scrape_left_nav_brands(page)
    else
      scrape_left_nav_others(page)
    end

    # crawl feature categories
    puts "\nScrapping Feature Categories #{url}"
    
    if root_cat_name == "KIDS"
      scrape_kids_feature_cates(page)
    elsif root_cat_name == 'ACTIVE'
      scrap_active_feature_cates(root_cat_name, page)
    elsif root_cat_name == 'BRANDS'
      scrap_brand_feature_brands(page)
    else
      scrape_others(root_cat_name, page)
    end
  end

  def scrape_left_nav_brands(page)
    nav = page.search(".//div[@class='subCatList']").search("a")

    nav.each do |item|
      cat_name = item.text.strip

      puts "+ #{cat_name}"
    end
  end

  def scrape_left_nav_others(page)
    nav = page.search("#firstNavSubCat").search(".//li[@class='nav_cat_item_bold']")

    nav.each do |group_cat|
      group_cat_name = group_cat.search("span").first.text

      puts "+ #{group_cat_name}"

      cats = []
      group_cat.search("a").each do |cat|
        cat_name = cat.text
        cats << cat_name
      end

      puts "  - #{cats.uniq.join("\n  - ")}"
    end
  end  

  def scrape_kids_feature_cates(page)
    f_cate_groups = page.search(".//div[@class='flexPool flexPoolMargin']")

    f_cate_groups.each do |f_cate_group|
      f_cate_name = f_cate_group.search("a").first.text.strip

      puts "* #{f_cate_name}"
    end
  end

  def scrap_active_feature_cates(root_cat_name, page)
    f_cates = page.search("map").search("area")

    f_cate_count = 0
    f_cates.each do |f_cate|
      f_cate_name = f_cate.attributes["alt"].text

      unless ['go you macys active'].include? f_cate_name
        puts "* #{f_cate_name}"
        f_cate_count += 1

        break if f_cate_count == FEATURE_CATE_LIMIT[root_cat_name]
      end
    end
  end

  def scrap_brand_feature_brands(page)
    f_brands = page.search(".//li[@class='featuredBrand']")

    f_brands.each do |f_brand|
      f_brand_name = f_brand.search("a").first.text.strip

      puts "* #{f_brand_name}"
    end
  end

  def scrape_others(root_cat_name, page)
    f_cates = page.search(".//div[@class='adCatIcon']")
    f_cate_count = 0

    f_cates.each do |f_cate|
      f_cate_ele = f_cate.search("a").search("div").first

      unless f_cate_ele.nil?
        f_cate_name = f_cate_ele.text
        puts "* #{f_cate_name}"

        f_cate_count += 1

        break if f_cate_count == FEATURE_CATE_LIMIT[root_cat_name]
      end     
    end
  end

  def scrape_options
    # bed & bath -> All Bedding Basics
    #page = @agent.get('http://www1.macys.com/shop/bed-bath/all-bedding-basics?id=70527&edge=hybrid&cm_sp=us_hdr-_-bed-%26-bath-_-70527_all-bedding-basics_COL1')
    page = agent.get('http://www1.macys.com/shop/shoes/boots/Boot_height/Tall?id=25122&cm_sp=us_hdr-_-shoes-_-tall_COL2')

    boxes = page.search("#facets").children

    boxes.each do |box|
      unless box.text.strip.blank?
        next if ['UPC_BOPS_PURCHASABLE', 'SPECIAL_OFFERS'].include? box.attributes["id"].text

        box_type = box.attributes["aria-label"].text

        puts "+ #{box_type}"

        if box.search("h2").count > 1
          sub_boxes = box.search(".//li[@class='typbox collapsed ']")
          sub_boxes |= box.search(".//li[@class='typbox groupFacet ']")

          sub_boxes.each do |sub_box|
            sub_box_type = sub_box.search("h2").first.text
            puts "  - #{sub_box_type}"

            sub_box.search("a").each do |item|
              puts "    * #{item.attributes["data-value"].text} #{item.attributes["href"].text}"
            end
          end
        else
          # crawl details in a box
          box.search("a").each do |item|
            url = "#{@root_url}#{item.attributes["href"].text}"
            puts "  - #{item.attributes["data-value"].text} #{url}"

            scrape_product_per_option(url)
          end
        end
      end

      puts "\n"
    end
  end

  def scrape_product_per_option(url)
    url = 'http://www1.macys.com/shop/womens-clothing/womens-activewear/Department_type,Pageindex/Accessories,1?id=29891'
    page = agent.get(url)

    total_product = 0

    current_page = 1

    while(true)
      products = page.search(".//div[@class='innerWrapper']")

      products.each do |product|      
        short_desc = product.search(".//div[@class='shortDescription']").search("a").first.text.strip

        reg_prices = product.search(".//div[@class='prices']").search(".//span[@class='first-range ']")
        reg_price = ""
        unless reg_prices.empty?
          reg_price = product.search(".//div[@class='prices']").search(".//span[@class='first-range ']").first.text.strip  
        end
        
        sale_prices = product.search(".//div[@class='prices']").search(".//span[@class='first-range priceSale']")
        sale_price = ""
        unless sale_prices.empty?
          sale_price = product.search(".//div[@class='prices']").search(".//span[@class='first-range priceSale']").first.text.strip      
        end

        puts "#{total_product} - #{short_desc} - #{reg_price} - #{sale_price}"

        total_product += 1
      end

      # go to the next page
      has_next_btn = !page.search("//a[starts-with(@class, 'arrowRight')]").empty?

      puts "has_next_btn: #{has_next_btn}"
      puts "#{page.search("//a[starts-with(@class, 'arrowRight')]")}"

      if has_next_btn
        url = url.gsub(/#{current_page}\?id=/, "#{current_page + 1}?id=")

        puts "next url #{url}"
        
        page = agent.get(url)

        current_page += 1
      else
        break
      end
    end
  end

  def scrape_product_page
    page = agent.get('http://www1.macys.com/shop/product/ideology-rapidry-heathered-t-shirt-only-at-macys?ID=2255076&CategoryID=29891#fn=sp%3D1%26spc%3D2092%26ruleId%3D65%7CBS%7CBA%26slotId%3D6')

  end
end
