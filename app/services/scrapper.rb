require "socksify"
require "socksify/http"
require "json"

# Mechanize: call @agent.set_socks(addr, port) before using
# any of it's methods; it might be working in other cases,
# but I just didn't tried :)
class Mechanize::HTTP::Agent
public
  def set_socks addr, port
    set_http unless @http
    class << @http
      attr_accessor :socks_addr, :socks_port

      def http_class
        Net::HTTP.SOCKSProxy(socks_addr, socks_port)
      end
    end
    @http.socks_addr = addr
    @http.socks_port = port
  end
end

class Scrapper

  FEATURE_CATE_LIMIT = {
    "HOME" => 4,
    "ACTIVE" => 10
  }

  SITE_NAME = "Boutiqueken"

  def initialize
    @root_url = 'https://www.macys.com'
    @agent = Mechanize.new

    #TODO: 
    #+ root url and proxy should be loaded from configuration
    #+ change country before scrapping
    @agent = Mechanize.new
    @agent.agent.set_socks('localhost', 8123)
  end

  def full_import
    scrape_menu

    #scrape_left_nav
  end

  def scrape_menu
    page = @agent.get(@root_url)

    menu = page.search("#globalMastheadCategoryMenu")

    puts "\nMain Menu"
    puts "---------"

    pos = 0
    menu.search("li").each do |mnu_item|
      cat_id = mnu_item.attributes["id"].value.split("_").last

      anchor = mnu_item.search("a").first
      cat_name = anchor.text
      cat_url = @root_url + anchor.attributes["href"].value

      cat = Category.find_or_create_by(cat_name: cat_name)
      cat.site_cat_id = cat_id
      cat.pos = pos
      cat.save

      pos += 1

      scrape_sub_menu(cat, page)

      scrape_left_nav(cat, cat_url)
    end
  end

  def scrape_sub_menu(parent_cat, page)
    sub_menu_id = "#Flyout_#{parent_cat.site_cat_id}"

    cat_divs = page.search("#globalMastheadFlyout").search(sub_menu_id)

    cat_divs.search(".//div[@class='flexLabelLinksContainer']").each do |cat_div|

      group_cat_name = ""
      pos = 0

      cat_div.search("li").each do |leaf_cat|
        if leaf_cat.children.first.name == "label"
          group_cat_name = leaf_cat.children.first.text
          pos = 0
        else
          if leaf_cat.search("a").count > 0
            cat_el = leaf_cat.search("a").first

            unless leaf_cat.attributes["id"].nil?
              site_cat_id = leaf_cat.attributes["id"].text.split("_").last.to_i
            
              # remove clearance links
              if cat_el.attributes["class"].nil?
                cat_name = cat_el.text

                unless cat_name.blank?
                  cat = Category.find_or_create_by(site_cat_id: site_cat_id)
                  cat.cat_name = cat_name
                  cat.group_name = group_cat_name
                  cat.site_cat_id = site_cat_id
                  cat.parent_id = parent_cat.id
                  cat.pos = pos
                  cat.save

                  pos += 1
                end
              end
            end
          end
        end
      end
    end
  end

  def scrape_left_nav(root_cat, url)
    page = @agent.get(url)

    # crawl left nav
    puts "\nScrapping Left Nav of #{url}"
    if root_cat.cat_name == 'BRANDS'
      scrape_left_nav_brands(root_cat, page)
    else
      scrape_left_nav_others(root_cat, page)
    end

    # crawl feature categories
    puts "\nScrapping Feature Categories #{url}"
    
    if root_cat.cat_name == "KIDS"
      scrape_kids_featured_cates(root_cat, page)
    elsif root_cat.cat_name == 'ACTIVE'
      scrap_active_featured_cates(root_cat, page)
    elsif root_cat.cat_name == 'BRANDS'
      scrap_brand_featured_brands(root_cat, page)
    else
      scrape_others_featured_cates(root_cat, page)
    end

    # update seo information for root_cat
    meta_tags = page.search("//meta[@name='description']")

    unless meta_tags.empty?
      seo_desc = page.search("//meta[@name='description']").first.attributes["content"].value

      seo_desc = seo_desc.gsub(/Macys.com/, SITE_NAME)
      seo_desc = seo_desc.gsub(/macys/, SITE_NAME)
      seo_desc = seo_desc.gsub(/Macy's/, SITE_NAME)

      root_cat.seo_desc = seo_desc
      root_cat.save
    end
  end

  def scrape_left_nav_brands(root_cat, page)
    nav = page.search(".//div[@class='subCatList']").children

    pos = 0

    nav.each do |item|
      unless item.text.strip.empty?
        cat_name = item.text.strip
        site_cat_id = item.attributes["id"].text

        if site_cat_id.to_i == 0
          puts "scrape_left_nav_brands - #{site_cat_id}"
          puts "cat_name #{cat_name}"
        end

        cat = Category.find_or_initialize_by(parent_id: root_cat.id, site_cat_id: site_cat_id)

        if cat.new_record?
          cat.is_shown_in_menu = false
          cat.cat_name = cat_name
          cat.parent_id = root_cat.id
          cat.site_cat_id = site_cat_id
          cat.save
        end

        nav = LeftNav.find_or_create_by(parent_id: root_cat.id, site_cat_id: site_cat_id)
        nav.cat_id = cat.id
        nav.site_cat_id = site_cat_id
        nav.parent_id = root_cat.id
        nav.cat_name = cat_name
        nav.pos = pos
        nav.save

        pos += 1
      end
    end
  end

  def scrape_left_nav_others(root_cat, page)
    nav = page.search("#firstNavSubCat").search(".//li[@class='nav_cat_item_bold']")

    group_pos = 0
    nav.each do |group_cat|
      group_cat_name = group_cat.search("span").first.text

      puts "+ #{group_cat_name}"

      group_pos += 1
      pos = 0

      group_cat.search("a").each do |cat|
        site_cat_id = cat.attributes["href"].text.split("?id=").last.split("&").first
        cat_name = cat.text
        
        if site_cat_id.to_i == 0
          puts "scrape_left_nav_others - #{site_cat_id}"
          puts "cat_name #{cat_name}"
        end

        cat = Category.find_or_initialize_by(parent_id: root_cat.id, site_cat_id: site_cat_id)

        if cat.new_record?
          cat.is_shown_in_menu = false
          cat.cat_name = cat_name
          cat.parent_id = root_cat.id
          cat.site_cat_id = site_cat_id
          cat.save
        end

        nav = LeftNav.find_or_create_by(parent_id: root_cat.id, site_cat_id: site_cat_id)
        nav.group_name = group_cat_name
        nav.cat_name = cat_name
        nav.cat_id = cat.id
        nav.parent_id = root_cat.id
        nav.site_cat_id = site_cat_id
        nav.pos = pos
        nav.group_pos = group_pos
        nav.save

        pos += 1
      end
    end
  end  

  def scrape_kids_featured_cates(root_cat, page)
    f_cate_groups = page.search(".//div[@class='flexPool flexPoolMargin']")

    pos = 0
    f_cate_groups.each do |f_cate_group|
      cat_el = f_cate_group.search("a").first

      cat_name = cat_el.text.strip
      site_cat_id = cat_el.attributes["href"].text.split("?id=").last.split("&").first

      if site_cat_id.to_i == 0
        puts "scrape_kids_featured_cates - #{site_cat_id}"
        puts "cat_name #{cat_name}"
      end

      cat = Category.where(parent_id: root_cat.id, site_cat_id: site_cat_id).first

      f_cat = FeaturedCategory.find_or_create_by(parent_id: root_cat.id, site_cat_id: site_cat_id)
      f_cat.cat_name = cat_name
      f_cat.parent_id = root_cat.id
      f_cat.site_cat_id = site_cat_id
      f_cat.category_id = cat.id unless cat.nil?
      f_cat.pos = pos
      f_cat.save

      pos += 1
    end
  end

  def scrap_active_featured_cates(root_cat, page)
    f_cates = page.search("map").search("area")

    f_cate_count = 0
    pos = 0

    f_cates.each do |f_cate|
      f_cate_name = f_cate.attributes["alt"].text

      unless ['go you macys active'].include? f_cate_name

        if f_cate_name.blank?
          puts "scrap_active_featured_cates - #{f_cate_name}"
        end

        f_cat = FeaturedCategory.find_or_create_by(parent_id: root_cat.id, cat_name: f_cate_name)
        f_cat.cat_name = f_cate_name
        f_cat.parent_id = root_cat.id
        f_cat.pos = pos
        f_cat.save

        f_cate_count += 1
        pos += 1
        break if f_cate_count == FEATURE_CATE_LIMIT[root_cat.cat_name]
      end
    end
  end

  def scrap_brand_featured_brands(root_cat, page)
    f_brands = page.search(".//li[@class='featuredBrand']")

    pos = 0

    f_brands.each do |f_brand|
      f_brand_el = f_brand.search("a").first

      cat_name = f_brand_el.text.strip
      site_cat_id = f_brand_el.attributes["href"].text.split("?CategoryID=").last

      if site_cat_id.to_i == 0
        puts "scrap_brand_featured_brands - #{site_cat_id}"
        puts "cat_name #{cat_name}"
      end

      cat = FeaturedCategory.find_or_create_by(parent_id: root_cat.id, site_cat_id: site_cat_id)
      cat.site_cat_id = site_cat_id
      cat.cat_name = cat_name
      cat.parent_id = root_cat.id
      cat.pos = pos
      cat.save

      pos += 1
    end
  end

  def scrape_others_featured_cates(root_cat, page)
    f_cates = page.search(".//div[@class='adCatIcon']")
    f_cate_count = 0

    pos = 0

    f_cates.each do |f_cate|
      f_cate_ele = f_cate.search("a").search("div").first
      site_cat_id = f_cate.search("a").first.attributes["href"].text.split("?CategoryID=").last.split("&").first
      site_cat_id = f_cate.search("a").first.attributes["href"].text.split("?id=").last if site_cat_id.to_i == 0

      unless f_cate_ele.nil?
        cat_name = f_cate_ele.text
        
        if site_cat_id.to_i == 0
          puts "scrape_others_featured_cates - #{site_cat_id}"
          puts "cat_name #{cat_name}"
        end

        cat = FeaturedCategory.find_or_create_by(parent_id: root_cat.id, site_cat_id: site_cat_id)
        cat.site_cat_id = site_cat_id
        cat.cat_name = cat_name
        cat.parent_id = root_cat.id
        cat.pos = pos
        cat.save

        pos += 1

        f_cate_count += 1

        break if f_cate_count == FEATURE_CATE_LIMIT[root_cat.cat_name]
      end     
    end
  end

  def scrape_options_test()
    page = @agent.get('http://www1.macys.com/shop/womens-clothing/womens-activewear?id=29891&edge=hybrid&cm_sp=us_hdr-_-women-_-29891_activewear_COL1')

    boxes = page.search("#facets").children

    boxes.each do |box|
      unless box.text.strip == ""
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
        elsif box_type == "Brand"
          item_pos = 0
          
          sub_box_type = "Featured Brands"

          puts " - #{sub_box_type}"
          box.search("a").each_with_index do |item, idx|
            break if idx > 9
            url = "#{@root_url}#{item.attributes["href"].text}"
            puts "  - #{item.attributes["data-value"].text}"
          end

          sub_box_type = "All Brands"
          puts " - #{sub_box_type}"

          box.search("a").each_with_index do |item, idx|
            url = "#{@root_url}#{item.attributes["href"].text}"
            puts "  - #{item.attributes["data-value"].text}"
          end
        else
          # crawl details in a box
          # box.search("a").each do |item|
          #   url = "#{@root_url}#{item.attributes["href"].text}"
          #   puts "  - #{item.attributes["data-value"].text} #{url}"

          #   #scrape_product_per_option(url)
          # end
        end
      end

      puts "\n"
    end
  end

  def scrape_filters

    puts "Scrapping filters"

    page = @agent.get(@root_url)

    menu = page.search("#globalMastheadCategoryMenu")

    menu.search("li").each do |mnu_item|
      cat_id = mnu_item.attributes["id"].value.split("_").last

      anchor = mnu_item.search("a").first
      cat_name = anchor.text
      cat_url = @root_url + anchor.attributes["href"].value

      puts "Scrapping #{cat_name} filters"
      start = Time.now

      if cat_name == "HOME"
        #scrape_home_filters()
      elsif cat_name == "BRANDS"
        #scrape_others_filters(cat_id, cat_url)
      elsif ["BED & BATH"].include? cat_name
        scrape_others_filters(cat_id, cat_url)
      end

      puts "Finished scrapping #{cat_name} filters in #{Time.now - start}\n\n"

    end
  end

  def scrape_home_filters
    url = ""
  end

  def scrape_brands_filters
    url = ""
  end

  def scrape_others_filters(site_root_cat_id, url)
    puts url

    page = @agent.get(url)

    sub_menu_id = "#Flyout_#{site_root_cat_id}"

    cat_divs = page.search("#globalMastheadFlyout").search(sub_menu_id)

    cat_divs.search(".//div[@class='flexLabelLinksContainer']").each do |cat_div|
      cat_div.search("li").each do |leaf_cat|
        next if leaf_cat.children.first.name == "label"

        if leaf_cat.search("a").count > 0
          cat_el = leaf_cat.search("a").first

          unless leaf_cat.attributes["id"].nil?
            site_cat_id = leaf_cat.attributes["id"].text.split("_").last.to_i
            site_cat_url = cat_el.attributes["href"].text

            #scrap_others_filters_for_subcat(site_root_cat_id, site_cat_id, site_cat_url)
            scrape_products_per_subcat(site_cat_id, site_cat_url)

            break
          end
        end
      end
    end
  end

  def scrap_others_filters_for_subcat(site_root_cat_id, site_cat_id, url)
    begin
      page = @agent.get(url)

      boxes = page.search("#facets").children

      parent_cat = Category.where(site_cat_id: site_root_cat_id, parent_id: nil).first
      cat = Category.where(site_cat_id: site_cat_id, parent_id: parent_cat.id).first

      if cat.nil?
        puts "Could not find the cat: site_root_cat_id - #{site_root_cat_id} - site_cat_id - #{site_cat_id}"
        return
      end

      group_pos = 0

      boxes.each do |box|
        unless box.text.strip.blank?
          next if ['UPC_BOPS_PURCHASABLE', 'SPECIAL_OFFERS'].include? box.attributes["id"].text

          box_type = box.attributes["aria-label"].text
          ui_type = box.attributes["data-uitype"].text

          puts "+ #{box_type}"

          if box.search("h2").count > 1
            puts "Inside a filter with subs"

            sub_boxes = box.search(".//li[@class='typbox collapsed ']")
            sub_boxes |= box.search(".//li[@class='typbox groupFacet ']")

            sub_group_pos = 0

            sub_boxes.each do |sub_box|
              sub_box_type = sub_box.search("h2").first.text
              puts "  - #{sub_box_type}"

              sub_box.search("a").each do |item|
                #{item.attributes["href"].text}
                puts "    * #{item.attributes["data-value"].text} "

                filter = Filter.find_or_create_by(category_id: cat.id, group_name: box_type, sub_group_name: sub_box_type)
                filter.filter_ui_type = ui_type
                filter.group_name = box_type
                filter.group_pos = group_pos
                filter.sub_group_name = sub_box_type
                filter_sub_group_pos = sub_group_pos
                filter_values = []

                sub_box.search("a").each do |item|
                  displayname = item.search(".//span[@class='item']").first.attributes["data-displayname"].text
                  value = item.attributes["data-value"].text

                  puts "displayname #{displayname}"
                  puts "value #{value}"

                  filter_values << {name: displayname, value: value}
                end

                filter.filters = filter_values.to_json
                filter.save
              end

              sub_group_pos += 1
            end
          elsif box_type == "Brand"          
            sub_box_type = "Featured Brands"

            filter = Filter.find_or_create_by(category_id: cat.id, group_name: box_type, sub_group_name: sub_box_type)
            filter.filter_ui_type = ui_type
            filter.group_name = box_type
            filter.group_pos = group_pos
            filter.sub_group_name = sub_box_type
            filter_values = []

            puts " - #{sub_box_type}"
            box.search("a").each_with_index do |item, idx|
              break if idx > 9
              # url = "#{@root_url}#{item.attributes["href"].text}"
              # puts "  - #{item.attributes["data-value"].text}"
              displayname = item.search(".//span[@class='item']").first.attributes["data-displayname"].text
              value = item.attributes["data-value"].text

              filter_values << {name: displayname, value: value}
            end
            filter.filters = filter_values.to_json
            filter.save

            sub_box_type = "All Brands"
            filter = Filter.find_or_create_by(category_id: cat.id, group_name: box_type, sub_group_name: sub_box_type)
            filter.filter_ui_type = ui_type
            filter.group_name = box_type
            filter.group_pos = group_pos
            filter.sub_group_name = sub_box_type
            filter_values = []

            puts " - #{sub_box_type}"
            box.search("a").each_with_index do |item, idx|
              #url = "#{@root_url}#{item.attributes["href"].text}"
              #puts "  - #{item.attributes["data-value"].text}"

              displayname = item.search(".//span[@class='item']").first.attributes["data-displayname"].text
              value = item.attributes["data-value"].text

              filter_values << {name: displayname, value: value}
            end

            filter.filters = filter_values.to_json
            filter.save
          else
            filter = Filter.find_or_create_by(category_id: cat.id, group_name: box_type, sub_group_name: nil)
            filter.filter_ui_type = ui_type
            filter.group_name = box_type
            filter.group_pos = group_pos

            filter_values = []

            # crawl details in a box
            box.search("a").each do |item|
              displayname = item.search(".//span[@class='item']").first.attributes["data-displayname"].text
              value = item.attributes["data-value"].text

              filter_values << {name: displayname, value: value}

              # url = "#{@root_url}#{item.attributes["href"].text}"
              # puts "  - #{item.attributes["data-value"].text} #{url}"

              #scrape_product_per_option(url)
            end

            filter.filters = filter_values.to_json
            filter.save
          end

          group_pos += 1
        end

        puts "\n"
      end
    rescue Exception => e
      puts e.message
      puts e.backtrace.join("\n")
    end
  end

  def scrape_products_per_subcat(site_cat_id, url)
    begin
      full_url = "#{@root_url}#{url}"
      puts "\nScrapping products from #{full_url}"

      page = @agent.get(full_url)

      url_paging_root = page.uri.to_s.split("?").first

      product_count_el = page.search("#productCount")

      if product_count_el.empty?
        puts "*** This page is not a product list page\n\n"
        puts "url: #{url}"
        return
      end

      product_count = product_count_el.first.text.strip.to_i

      total_product = 0

      current_page = 1

      while(product_count > 0 && total_product < product_count)
        products = page.search(".//li[@class='productThumbnail borderless']")

        products.each do |product|
          product_id = product.attributes["id"].text

          product_url = "#{@root_url}#{product.search("a").first.attributes["href"].text}"

          puts "#{total_product}/#{product_count} - #{product_url}"

          scrape_product_or_product_collection_page(product_id, product_url)

          total_product += 1
        end

        # go to the next page
        if total_product < product_count
          current_page += 1

          page_index = "/Pageindex/#{current_page}?id=#{site_cat_id}"
          url_paging = "#{url_paging_root}#{page_index}"

          page = @agent.get(url_paging)
        end
      end
    rescue Exception => e
      puts e.message
      puts e.backtrace.join("\n")
    end
  end

  def scrape_product_or_product_collection_page(product_id, url)
    page = @agent.get(url)

    product_main_data = page.search("#productMainData")

    unless product_main_data.empty?
      scrape_product_page(product_id, product_main_data)
    else 
      pdp_main_data = page.search("#pdpMainData")

      unless pdp_main_data.empty?
        scrape_product_collection_page(product_id, pdp_main_data)
      end
    end
  end

  def scrape_product_collection_page(product_id, data)
    puts "inside production collection scrapping function"
  end

  def scrape_product_page(product_id, data)
    begin
      url = "http://www1.macys.com/shop/catalog/product/newthumbnail/json?productId=#{product_id}&source=100"

      product_thumbnail_page = @agent.get(url)

      product_thumbnail = JSON.parse(product_thumbnail_page.body)["productThumbnail"]

      product = JSON.parse(data)

      # product description
      short_desc = product_thumbnail["productDescription"]
      long_desc = product_thumbnail["longDescription"]
      bullet_text = product_thumbnail["bulletText"].to_json
      main_image_url = product["imageUrl"]
      category_id = product_thumbnail["categoryId"]
      video_id = h["productThumbnail"]["videoID"]
      colorway_pricing_swatches = product["colorwayPricingSwatches"].to_json
      color_swatch_map = product["colorSwatchMap"].to_json
      sizes = product["sizesList"].to_json
      brand_name = product["brandName"]
      attributes = product_thumbnail["attributes"].to_json

      # crawl 'customers also loved/shopped'
      recommendations = @agent.post('http://www1.macys.com/sdp/rto/request/recommendations',{
          maxRecommendations: "15",
          requester: "MCOM-NAVAPP",
          timeout: "15000",
          cts: "http://www.macys.com",
          productId: "#{product_id}",
          categoryId: "#{category_id}",
          context: "PDP_ZONE_A|PDP_ZONE_B",
          visitorId: "1111111111",
          countryCode: "US",
          zipCode: "",
          stateCode: "CA",
          customerId: "111111111"
        },
        "Content-Type" => "application/x-www-form-urlencoded; charset=UTF-8"
      )

      related_products = 
      related_loved_product = 

      # NOTE: based on h["productThumbnail"]["childProductIds"] to product or product collection
      # CASE 1: only one product in detail page
      h = JSON.parse(page.body)

      

      # get imgs
      color_primary_imgs = h["productThumbnail"]["colorwayPrimaryImages"]
      color_add_imgs = h["productThumbnail"]["colorwayAdditionalImages"]


      # CASE 2: product collection page
      page = agent.get('http://www1.macys.com/shop/catalog/product/newthumbnail/json?productId=866649&source=100')
      h = JSON.parse(page.body)

      # collection details
      collection_details = h["productThumbnail"]

      # list of products in collection
      # this first one is id of collection 
      productIds = h["productThumbnail"]["childProductIds"]

      # get imgs
      color_primary_imgs = h["productThumbnail"]["colorwayPrimaryImages"]
      color_add_imgs = h["productThumbnail"]["colorwayAdditionalImages"]

      # get video id
      video_id = h["productThumbnail"]["videoID"]

      # long description
      long_desc = h["productThumbnail"]["longDescription"]

      # bullet text
      bullet_texts = h["productThumbnail"]["bulletText"]

      # product description / product name / product short description
      short_desc = h["productThumbnail"]["productDescription"]
    rescue Exception => e
    end
  end
end
