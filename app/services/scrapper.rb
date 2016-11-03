require "socksify"
require "socksify/http"

require "json"
require "csv"

# Mechanize: call @agent.set_socks(addr, port) before using
# any of it's methods;
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
  MAX_THREAD = 15
  BATCH_SIZE = 25000

  HOME_SPECIAL_CATES = {
    "Dining & Entertaining": "http://www1.macys.com/catalog/index.ognc?CategoryID=7498&cm_sp=us_hdr-_-home-_-7498_dining-%26-entertaining_COL1",
    "Furniture": "http://www1.macys.com/catalog/index.ognc?CategoryID=29391&cm_sp=us_hdr-_-home-_-29391_furniture_COL1",
    "Kitchen": "http://www1.macys.com/catalog/index.ognc?CategoryID=7497&cm_sp=us_hdr-_-home-_-7497_kitchen_COL1",
    "Luggage & Backpacks": "http://www1.macys.com/catalog/index.ognc?CategoryID=16908&cm_sp=us_hdr-_-home-_-16908_luggage-%26-backpacks_COL1",
    "Mattresses": "http://www1.macys.com/catalog/index.ognc?CategoryID=25931&cm_sp=us_hdr-_-home-_-25931_mattresses_COL1",
    "Holiday Lane": "http://www1.macys.com/catalog/index.ognc?CategoryID=30599&cm_sp=us_hdr-_-home-_-30599_holiday-lane_COL1"
  }

  def initialize
    @root_url = 'https://www.macys.com'

    @agent = Mechanize.new

    set_cookies(@agent)

    @number_of_threads = 10

    @mutex = Mutex.new
    @current_batch = 0
    @number_of_products = 0
    @current_file = nil

    @ppd_mutex = Mutex.new
    @ppd_current_batch = 0
    @ppd_number_of_products = 0
    @ppd_current_file = nil

    @start_date = Time.now.strftime("%Y%m%d")
    FileUtils.mkdir_p("./tmp/#{@start_date}")
    @current_cat_name = ""

    @scrapped_site_cat_ids = {}
    @existing_products = {}

  end

  def load_existing_products
    begin
      sql =%{
        SELECT id, site_cat_id, site_product_id FROM products;
      } 

      products = Product.connection.execute(sql)

      products.each do |prod|
        site_cat_id = prod["site_cat_id"]
        site_product_id = prod["site_product_id"]

        key = "#{site_cat_id}\t#{site_product_id}"

        @existing_products[key] = prod["id"].to_i
      end
    rescue Exception => e
      puts "Message: #{e.message}"
      puts "Backtrace: #{e.backtrace}"
    end
  end

  def import_others
    scrape_menu
    scrape_left_nav
    scrape_filters
    scrape_seo_information
  end

  def scrape_menu
    begin
      puts "[BEGIN] Scrapping menu and sub-menu"
      start_time = Time.now

      page = @agent.get(@root_url)

      set_cookies(@agent)

      menu = page.search("#globalMastheadCategoryMenu")

      if menu.count == 0
        puts "[WARN] Cannot scrape menu because of changing in the site structure"
        return
      end

      puts "\nMain Menu"
      puts "---------"

      pos = 0
      menu.search("li").each do |mnu_item|
        cat_id = mnu_item.attributes["id"].value.split("_").last

        anchor = mnu_item.search("a").first
        cat_name = replace_macys_info(anchor.text)
        cat_url = @root_url + anchor.attributes["href"].value

        cat = Category.find_or_create_by(cat_name: cat_name)
        cat.site_cat_id = cat_id
        cat.pos = pos
        cat.save

        pos += 1

        puts "Scrapping sub-menu for #{cat_name}"

        scrape_sub_menu(cat, page)
      end

      puts "[END] Scrapping menu and sub-menu finished in #{Time.now - start_time}"
    rescue Exception => e 
      puts e.message
      puts e.backtrace.join("\n")
    end
  end

  def scrape_sub_menu(parent_cat, page)
    begin
      sub_menu_id = "#Flyout_#{parent_cat.site_cat_id}"

      cat_divs = page.search("#globalMastheadFlyout").search(sub_menu_id)

      if cat_divs.count == 0
        puts "[WARN] Cannot scrape the sub menu because of chaninging in the site structure"
        return
      end

      pos = 0

      cat_divs.search(".//div[@class='flexLabelLinksContainer']").each do |cat_div|
        group_cat_name = ""

        cat_div.search("li").each do |leaf_cat|
          if leaf_cat.children.first.name == "label"
            group_cat_name = replace_macys_info(leaf_cat.children.first.text)
            puts "- #{group_cat_name}"
          else
            if leaf_cat.search("a").count > 0
              cat_el = leaf_cat.search("a").first

              unless leaf_cat.attributes["id"].nil?
                site_cat_id = leaf_cat.attributes["id"].text.split("_").last.to_i
                site_cat_id = leaf_cat.attributes["id"].text.split("?id=").last.to_i if site_cat_id == 0
              
                # remove clearance links
                if cat_el.attributes["class"].nil?
                  cat_name = replace_macys_info(cat_el.text)

                  puts "  - #{cat_name} - site_cat_id #{site_cat_id} - parent_id #{parent_cat.id}"

                  unless cat_name.blank?
                    cat = Category.find_or_create_by(group_name: group_cat_name, site_cat_id: site_cat_id, cat_name: cat_name, parent_id: parent_cat.id, is_shown_in_menu: true)
                    cat.cat_name = replace_macys_info(cat_name)
                    cat.group_name = group_cat_name
                    cat.site_cat_id = site_cat_id
                    cat.parent_id = parent_cat.id
                    cat.pos = pos
                    cat.is_shown_in_menu = true
                    cat.save

                    pos += 1
                  end
                end
              end
            end
          end
        end
      end
    rescue Exception => e 
      puts e.message
      puts e.backtrace.join("\n")
    end
  end

  def scrape_left_nav
    begin
      puts "[BEGIN] Scrapping left navigation"
      start_time = Time.now

      page = @agent.get(@root_url)

      menu = page.search("#globalMastheadCategoryMenu")

      if menu.count == 0
        puts "[WARN] Cannot scrape the left nav because of changing in the site structure"
        return
      end

      menu.search("li").each do |mnu_item|
        cat_id = mnu_item.attributes["id"].value.split("_").last
        next if cat_id.nil?

        anchor = mnu_item.search("a").first
        cat_url = @root_url + anchor.attributes["href"].value

        cat = Category.where(site_cat_id: cat_id, parent_id:nil).first
        max_deep = 2

        scrape_left_nav_details(cat, cat_url, max_deep)
      end

      puts "[END] Scrapping left navigation finished in #{Time.now - start_time}\n\n"
    rescue Exception => e 
      puts e.message
      puts e.backtrace.join("\n")
    end
  end

  def scrape_left_nav_details(root_cat, url, deep=1)
    begin
      return if deep < 1
      deep -= 1

      page = @agent.get(url)


      # crawl left nav
      puts "\nScrapping Left Nav of #{url}"

      nav_sub_cat = page.search("#firstNavSubCat")

      if nav_sub_cat.present?
        scrape_left_nav_others(root_cat, page, deep)
      elsif page.search(".//div[@class='subCatList']").present?
        scrape_left_nav_brands(root_cat, page)
      else
        seo_title, seo_keywords, seo_desc = extract_seo_information(page)
        root_cat.seo_title = seo_title
        root_cat.seo_keywords = seo_keywords
        root_cat.seo_desc = seo_desc
        root_cat.save
        return
      end

      # crawl feature categories
      puts "\nScrapping Feature Categories #{url}"
      
      kid = ".//div[@class='flexPool flexPoolMargin']"
      active = "map"

      if nav_sub_cat.present?
        scrape_others_featured_cates(root_cat, page)
      elsif page.search(kid).present?
        scrape_kids_featured_cates(root_cat, page)
      elsif page.search(active).search("area").present?
        scrap_active_featured_cates(root_cat, page)
      else
        scrap_brand_featured_brands(root_cat, page)
      end

      # update seo information for root_cat
      seo_title, seo_keywords, seo_desc = extract_seo_information(page)

      root_cat.seo_title = seo_title
      root_cat.seo_keywords = seo_keywords
      root_cat.seo_desc = seo_desc
      root_cat.save

    rescue Exception => e 
      puts e.message
      puts e.backtrace.join("\n")
    end      
  end

  def scrape_left_nav_brands(root_cat, page)
    begin
      nav = page.search(".//div[@class='subCatList']").children

      pos = 0

      nav.each do |item|
        unless item.text.strip.empty?
          cat_name = replace_macys_info(item.text.strip)
          site_cat_id = item.attributes["id"].text

          if site_cat_id.to_i == 0
            #puts "scrape_left_nav_brands - #{site_cat_id}"
            #puts "Cannot extract site_cat_id of cat_name #{cat_name}"
            next
          end

          cat = Category.find_or_initialize_by(site_cat_id: site_cat_id, parent_id: root_cat.id, cat_name: cat_name)

          if cat.new_record?
            cat.is_shown_in_menu = false
            cat.cat_name = cat_name
            cat.parent_id = root_cat.id
            cat.site_cat_id = site_cat_id
            cat.save
          end

          puts "cat_name: #{cat_name} - site_cat_id: #{site_cat_id} - cat_id: #{cat.id} - parent_id: #{cat.parent_id}"

          nav = LeftNav.find_or_create_by(parent_id: root_cat.id, site_cat_id: site_cat_id)
          nav.category_id = cat.id
          nav.site_cat_id = site_cat_id
          nav.parent_id = root_cat.id
          nav.cat_name = cat_name
          nav.pos = pos
          nav.save

          pos += 1
        end
      end
    rescue Exception => e
      puts e.message
      puts e.backtrace.join("\n")
    end      
  end

  def scrape_left_nav_others(root_cat, page, deep)
    begin
      nav = page.search("#firstNavSubCat").search(".//li[@class='nav_cat_item_bold']")
      group_pos = 0
      nav.each do |group_cat|
        group_cat_name = replace_macys_info(group_cat.search("span").first.text)

        group_pos += 1
        pos = 0

        group_cat.search("a").each do |cat|
          site_cat_id = cat.attributes["href"].text.split("?id=").last.split("&").first
          url = cat.attributes["href"].text
          cat_name = replace_macys_info(cat.text)

          if site_cat_id.to_i == 0
            #puts "scrape_left_nav_others - #{site_cat_id}"
            #puts "Cannot scrape site_cat_id of cat_name #{cat_name} - page #{page.uri.to_s} - skipped"
            next
          end

          cat = Category.find_or_initialize_by(site_cat_id: site_cat_id, parent_id: root_cat.id, cat_name: cat_name)

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
          nav.category_id = cat.id
          nav.parent_id = root_cat.id
          nav.site_cat_id = site_cat_id
          nav.pos = pos
          nav.group_pos = group_pos
          nav.save

          pos += 1

          scrape_left_nav_details(cat, url, deep)
        end
      end
    rescue Exception => e
      puts e.message
      puts e.backtrace.join("\n")
    end
  end  

  def scrape_kids_featured_cates(root_cat, page)
    begin
      f_cate_groups = page.search(".//div[@class='flexPool flexPoolMargin']")

      pos = 0
      f_cate_groups.each do |f_cate_group|
        cat_el = f_cate_group.search("a").first

        cat_name = replace_macys_info(cat_el.text.strip)
        site_cat_id = cat_el.attributes["href"].text.split("?CategoryID=").last
        site_cat_id = cat_el.attributes["href"].text.split("?id=").last.split("&").first if site_cat_id.to_i == 0
        image_url = f_cate_group.search("img").first.attributes["src"].text

        if site_cat_id.to_i == 0
          puts "scrape_kids_featured_cates - #{site_cat_id}"
          puts "Cannot scrape site_cat_id of cat_name #{cat_name} - page #{page.uri.to_s}"
          next
        end

        cat = Category.find_or_initialize_by(site_cat_id: site_cat_id, parent_id: root_cat.id, cat_name: cat_name)

        if cat.new_record?
          cat.is_shown_in_menu = false
          cat.cat_name = cat_name
          cat.parent_id = root_cat.id
          cat.site_cat_id = site_cat_id
          cat.save
        end

        f_cat = FeaturedCategory.find_or_create_by(parent_id: root_cat.id, site_cat_id: site_cat_id)
        f_cat.cat_name = cat_name
        f_cat.parent_id = root_cat.id
        f_cat.site_cat_id = site_cat_id
        f_cat.category_id = cat.id unless cat.nil?
        f_cat.image_url = image_url
        f_cat.pos = pos
        f_cat.save

        pos += 1
      end
    rescue Exception => e 
      puts e.message
      puts e.backtrace.join("\n")
    end
  end

  def scrap_active_featured_cates(root_cat, page)
    begin
      f_cates = page.search("map").search("area")

      f_cate_count = 0
      pos = 0

      f_cates.each do |f_cate|
        cat_name = f_cate.attributes["alt"].text

        unless ['go you macys active'].include? cat_name
          cat_name = replace_macys_info(cat_name)

          if cat_name.blank?
            puts "scrap_active_featured_cates - cat_name is blank - skipped"
            next
          end

          cat = Category.find_or_initialize_by(cat_name: cat_name)

          if cat.new_record?
            cat.is_shown_in_menu = false
            cat.cat_name = cat_name
            cat.parent_id = root_cat.id
            cat.site_cat_id = cat.site_cat_id unless cat.nil?
            cat.save
          end
          
          f_cat = FeaturedCategory.find_or_create_by(parent_id: root_cat.id, category_id: cat.id)
          f_cat.cat_name = cat_name
          f_cat.category_id = cat.id
          f_cat.parent_id = root_cat.id
          f_cat.pos = pos
          f_cat.save

          f_cate_count += 1
          pos += 1

          break if f_cate_count == FEATURE_CATE_LIMIT[root_cat.cat_name]
        end
      end
    rescue Exception => e 
      puts e.message
      puts e.backtrace.join("\n")
    end
  end

  def scrap_brand_featured_brands(root_cat, page)
    begin
      f_brands = page.search(".//li[@class='featuredBrand']")

      pos = 0

      f_brands.each do |f_brand|
        f_brand_el = f_brand.search("a").first

        cat_name = replace_macys_info(f_brand_el.text.strip)
        site_cat_id = f_brand_el.attributes["href"].text.split("?CategoryID=").last
        site_cat_id = f_brand_el.attributes["href"].text.split("?id=").last if site_cat_id.to_i == 0

        if site_cat_id.to_i == 0
          puts "scrap_brand_featured_brands - #{site_cat_id} skipped"
          puts "Cannot scrape site_cat_id of cat_name #{cat_name} - page #{page.uri.to_s}"
          next
        end

        cat = Category.find_or_initialize_by(site_cat_id: site_cat_id, parent_id: root_cat.id, cat_name: cat_name)

        if cat.new_record?
          cat.is_shown_in_menu = false
          cat.cat_name = cat_name
          cat.parent_id = root_cat.id
          cat.site_cat_id = site_cat_id
          cat.save
        end
        
        f_cat = FeaturedCategory.find_or_create_by(parent_id: root_cat.id, site_cat_id: site_cat_id)
        f_cat.site_cat_id = site_cat_id
        f_cat.category_id = cat.id
        f_cat.cat_name = cat_name
        f_cat.parent_id = root_cat.id
        f_cat.pos = pos
        f_cat.save

        pos += 1
      end
    rescue Exception => e 
      puts e.message
      puts e.backtrace.join("\n")
    end
  end

  def scrape_others_featured_cates(root_cat, page)
    begin
      f_cates = page.search(".//div[@class='adCatIcon']")
      f_cate_count = 0

      pos = 0

      f_cates.each do |f_cate|
        f_cate_ele = f_cate.search("a").search("div").first
        site_cat_id = f_cate.search("a").first.attributes["href"].text.split("?CategoryID=").last.split("&").first
        site_cat_id = f_cate.search("a").first.attributes["href"].text.split("?id=").last.split("&").first if site_cat_id.to_i == 0
        image_url = f_cate.search("img").first.attributes["src"].text

        unless f_cate_ele.nil?
          cat_name = replace_macys_info(f_cate_ele.text)
          
          if site_cat_id.to_i == 0

            puts "scrape_others_featured_cates - #{site_cat_id}"
            puts "url #{f_cate.search("a").first.attributes["href"].text}"
            puts "Cannot scrape site_cat_id of cat_name #{cat_name} - page #{page.uri.to_s}"
            next
          end

          cat = Category.find_or_initialize_by(site_cat_id: site_cat_id, parent_id: root_cat.id, cat_name: cat_name)

          if cat.new_record?
            cat.is_shown_in_menu = false
            cat.cat_name = cat_name
            cat.parent_id = root_cat.id
            cat.site_cat_id = site_cat_id
            cat.save
          end

          f_cat = FeaturedCategory.find_or_create_by(parent_id: root_cat.id, site_cat_id: site_cat_id)
          f_cat.site_cat_id = site_cat_id
          f_cat.cat_name = cat_name
          f_cat.category_id = cat.id unless cat.nil?
          f_cat.image_url = image_url
          f_cat.parent_id = root_cat.id
          f_cat.pos = pos
          f_cat.save

          pos += 1

          f_cate_count += 1

          break if f_cate_count == FEATURE_CATE_LIMIT[root_cat.cat_name]
        end     
      end
    rescue Exception => e 
      puts e.message
      puts e.backtrace.join("\n")
    end    
  end

  def scrape_filters
    begin
      puts "[BEGIN] Scrapping filters"
      start_time = Time.now

      page = @agent.get(@root_url)

      menu = page.search("#globalMastheadCategoryMenu")

      #threads = []
      #thread_count = 0

      # scrape filters from sub-menu
      menu.search("li").each do |mnu_item|
        #threads[thread_count] = Thread.new {
          cat_id = mnu_item.attributes["id"].value.split("_").last

          anchor = mnu_item.search("a").first
          cat_name = replace_macys_info(anchor.text)
          cat_url = @root_url + anchor.attributes["href"].value

          puts "- Scrapping #{cat_name} filters"
          start = Time.now

          scrape_filters_details(cat_id, @root_url)
          
          cat = Category.where(site_cat_id: cat_id, parent_id: nil).first

          max_deep = 4
          scrape_filters_from_left_nav(cat, cat_url, max_deep)

          puts "- Finished scrapping #{cat_name} filters in #{Time.now - start}\n\n"
        #}
        
        #thread_count += 1
      end

      #threads.each {|t| t.join}

      puts "[END] Scrapping filters finished in #{Time.now - start_time}"
    rescue Exception => e 
      puts e.message
      puts e.backtrace.join("\n")
    end      
  end

  def scrape_filters_details(site_root_cat_id, url)
    begin
      puts "scrape_filters_details #{url}"

      full_url = url

      unless url.start_with?("http")
        full_url = "#{@root_url}#{url}"
      end

      page = @agent.get(full_url)

      sub_menu_id = "#Flyout_#{site_root_cat_id}"

      cat_divs = page.search("#globalMastheadFlyout").search(sub_menu_id)

      cat_divs.search(".//div[@class='flexLabelLinksContainer']").each do |cat_div|
        cat_div.search("li").each do |leaf_cat|
          next if leaf_cat.children.first.name == "label"

          if leaf_cat.search("a").count > 0
            cat_el = leaf_cat.search("a").first

            unless leaf_cat.attributes["id"].nil?
              site_cat_id = leaf_cat.attributes["id"].text.split("_").last.to_i
              site_cat_id = leaf_cat.attributes["id"].text.split("?id=").last.split("&").first.to_i if site_cat_id == 0
              site_cat_url = cat_el.attributes["href"].text
              cat_name = replace_macys_info(cat_el.text)

              puts "cat_name: -------> #{cat_name}"

              root_cat = Category.where(site_cat_id: site_root_cat_id, parent_id: nil).first
              max_deep = 2
              scrape_filters_for_subcat(root_cat, site_cat_id, site_cat_url, cat_name, max_deep)
            end
          else
            puts "leaf_cat: #{leaf_cat}"
          end
        end
      end
    rescue Exception => e 
      puts e.message
      puts e.backtrace.join("\n")
    end      
  end

  def scrape_filters_for_subcat(root_cat, site_cat_id, url, cat_name, deep=1)
    begin
      return if deep < 1
      deep -= 1

      puts "Scrapping filters in #{url}"

      page = @agent.get(url)

      seo_title, seo_keywords, seo_desc = extract_seo_information(page)

      facets = page.search("#facets")

      if facets.empty?
        puts "Cannot find filters in this page #{url}"
        puts "-> Scrape category list"

        cat = Category.find_or_create_by(site_cat_id: site_cat_id, parent_id: root_cat.id, cat_name: cat_name)

        cat.site_cat_id = site_cat_id
        cat.parent_id = root_cat.id
        cat.cat_name = cat_name
        cat.seo_title = seo_title
        cat.seo_keywords = seo_keywords
        cat.seo_desc = seo_desc
        cat.save

        unless url.start_with?("http")
          full_url = "#{@root_url}#{url}"
        else
          full_url = url
        end

        scrape_left_nav_details(cat, full_url)

        scrape_filters_from_left_nav(cat, full_url, deep)

        return
      end

      boxes = facets.children

      cat = Category.where(site_cat_id: site_cat_id, parent_id: root_cat.id, cat_name: cat_name).first

      if cat.nil?
        puts "scrape_filters_for_subcat: cannot find cat by site_cat_id #{site_cat_id} - parent_id #{root_cat.id} - cat_name #{cat_name}"
        return
      end

      cat.seo_title = seo_title
      cat.seo_keywords = seo_keywords
      cat.seo_desc = seo_desc
      cat.save

      group_pos = 0

      boxes.each do |box|
        unless box.text.strip.blank?
          next if ['UPC_BOPS_PURCHASABLE', 'SPECIAL_OFFERS'].include? box.attributes["id"].text

          box_type = replace_macys_info(box.attributes["aria-label"].text)
          ui_type = box.attributes["data-uitype"].text
          filter_product_field_name = box.attributes["id"].text

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
                filter = Filter.find_or_create_by(category_id: cat.id, group_name: box_type, sub_group_name: sub_box_type)
                filter.filter_ui_type = ui_type
                filter.group_name = box_type
                filter.group_pos = group_pos
                filter.sub_group_name = sub_box_type
                filter.sub_group_pos = sub_group_pos
                filter.filter_product_field_name = filter_product_field_name
                filter_values = []

                sub_box.search("a").each do |item|
                  displayname = item.search(".//span[@class='item']").first.attributes["data-displayname"].text
                  value = item.attributes["data-value"].text

                  filter_values << {name: replace_macys_info(displayname), value: replace_macys_info(value)}
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
            filter.sub_group_pos = 0
            filter.filter_product_field_name = filter_product_field_name
            filter_values = []

            puts " - #{sub_box_type}"
            box.search("a").each_with_index do |item, idx|
              break if idx > 9

              displayname = item.search(".//span[@class='item']").first.attributes["data-displayname"].text
              value = item.attributes["data-value"].text

              filter_values << {name: replace_macys_info(displayname), value: replace_macys_info(value)}
            end
            filter.filters = filter_values.to_json
            filter.save

            sub_box_type = "All Brands"
            filter = Filter.find_or_create_by(category_id: cat.id, group_name: box_type, sub_group_name: sub_box_type)
            filter.filter_ui_type = ui_type
            filter.group_name = box_type
            filter.group_pos = group_pos
            filter.sub_group_name = sub_box_type
            filter.sub_group_pos = 1
            filter.filter_product_field_name = filter_product_field_name

            filter_values = []

            puts " - #{sub_box_type}"
            box.search("a").each_with_index do |item, idx|
              displayname = item.search(".//span[@class='item']").first.attributes["data-displayname"].text
              value = item.attributes["data-value"].text

              filter_values << {name: replace_macys_info(displayname), value: replace_macys_info(value)}
            end

            filter.filters = filter_values.to_json
            filter.save
          else
            filter = Filter.find_or_create_by(category_id: cat.id, group_name: box_type, sub_group_name: nil)
            filter.filter_ui_type = ui_type
            filter.group_name = box_type
            filter.group_pos = group_pos
            filter.filter_product_field_name = filter_product_field_name

            filter_values = []

            # crawl details in a box
            box.search("a").each do |item|
              displayname = item.search(".//span[@class='item']").first.attributes["data-displayname"].text
              value = item.attributes["data-value"].text

              filter_values << {name: replace_macys_info(displayname), value: replace_macys_info(value)}
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

  def scrape_filters_from_left_nav(root_cat, url, deep=1)
    begin
      return if deep < 1
      deep -= 1

      page = @agent.get(url)
      nav = page.search("#firstNavSubCat").search(".//li[@class='nav_cat_item_bold']")
  
      current_cat_name = ""      
      nav.each do |group_cat|
        group_cat.search("a").each do |cat|
          site_cat_id = cat.attributes["href"].text.split("?id=").last.split("&").first

          if site_cat_id.to_i == 0
            puts "scrape_filters_from_left_nav: cannot scrape site_cat_id #{site_cat_id} - #{cat.attributes["href"].text}"
            next
          end

          url = cat.attributes["href"].text
          cat_name = replace_macys_info(cat.text)

          # compare current_cat_name vs cat_name to prevent duplicate scrapping filters
          # due to duplicate urls
          if current_cat_name != cat_name
            puts "cat_name =========> #{cat_name}"
            scrape_filters_for_subcat(root_cat, site_cat_id, url, cat_name, deep)
          end

          current_cat_name = cat_name
        end
      end
    rescue Exception => e
      puts e.message
      puts e.backtrace.join("\n")
    end
  end  

  def scrape_products(scrape_cat_name=nil, update_db=true, number_of_threads=10)
    begin

      @number_of_threads = number_of_threads

      puts "[BEGIN] Scrapping products by #{@number_of_threads} threads"

      load_existing_products

      start_time = Time.now

      page = @agent.get(@root_url)

      menu = page.search("#globalMastheadCategoryMenu")

      menu.search("li").each do |mnu_item|
        cat_id = mnu_item.attributes["id"].value.split("_").last

        anchor = mnu_item.search("a").first
        cat_name = replace_macys_info(anchor.text)
        cat_url = @root_url + anchor.attributes["href"].value

        @current_cat_name = cat_name

        puts "Scrapping #{cat_name} products"

        if !scrape_cat_name.nil?
          if cat_name == scrape_cat_name
            scrape_others_cat_products(cat_id, @root_url)
            scrape_products_for_left_cat(cat_url)

            @current_file.flush unless @current_file.nil?
            @ppd_current_file.flush unless @ppd_current_file.nil?

            import_crawled_products_to_db(@start_date, cat_name, @current_batch)
            import_product_price_details_to_db(@start_date, cat_name, @ppd_current_batch)

            break
          end
        else
          scrape_others_cat_products(cat_id, @root_url)
          scrape_products_for_left_cat(cat_url)

          @current_file.flush unless @current_file.nil?
          @ppd_current_file.flush unless @ppd_current_file.nil?

          import_crawled_products_to_db(@start_date, cat_name, @current_batch)
          import_product_price_details_to_db(@start_date, cat_name, @ppd_current_batch)

          @current_batch = 0
          @ppd_current_batch = 0
        end
      end

      if update_db
        update_products_after_import()
        update_product_price_details_after_import()
      end
      puts "[END] Scrapping products finished in #{Time.now - start_time}"
    rescue Exception => e 
      puts e.message
      puts e.backtrace.join("\n")
    end
  end

  def scrape_others_cat_products(site_root_cat_id, url)
    begin
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

              scrape_products_per_subcat(site_cat_id, site_cat_url)
            end
          end
        end
      end
    rescue Exception => e 
      puts e.message
      puts e.backtrace.join("\n")
    end
  end

  def scrape_products_for_left_cat(url, current_cat_name=nil)
    begin
      if current_cat_name.present?
        @current_cat_name = current_cat_name
      end

      puts "[BEGIN] Scrapping products for left cates"
      start = Time.now

      agent = Mechanize.new

      set_cookies(agent)

      page = agent.get(url)

      nav = page.search("#firstNavSubCat").search(".//li[@class='nav_cat_item_bold']")

      nav.each do |group_cat|
        group_cat.search("a").each do |cat|
          site_cat_id = cat.attributes["href"].text.split("?id=").last.split("&").first
          cat_url = cat.attributes["href"].text

          scrape_products_per_subcat(site_cat_id, cat_url)        
        end
      end

      puts "[END] Scrapping products for left cates in #{Time.now - start}"
    rescue Exception => e
      puts e.message
      puts e.backtrace.join("\n")
    end
  end

  def scrape_products_per_subcat(site_cat_id, url)
    begin
      if @scrapped_site_cat_ids[site_cat_id].present?
        puts "We scrapped products of this site_cat_id #{site_cat_id} - url #{url}"
        return
      end

      full_url = ""

      unless url.start_with?("http")
        full_url = "#{@root_url}#{url}"
      else
        full_url = url
      end

      puts "\nScrapping products from #{full_url}"

      page = @agent.get(full_url)

      url_paging_root = page.uri.to_s.split("?").first

      product_count_el = page.search("#productCount")

      if product_count_el.empty?
        puts "[WARN] This page is not a product list page\n\n"
        puts "url: #{full_url}"
        scrape_products_for_left_cat(full_url)
        return
      end

      product_count = product_count_el.first.text.strip.to_i

      total_product = 0

      current_page = 1

      url_paging = full_url

      while (product_count > 0 && total_product < product_count)
        products = page.search(".//li[@class='productThumbnail borderless']")

        break if products.empty? 

        threads = []
        thread_count = 0

        #puts "total products in this page: #{products.count}"
        #puts "url_paging: #{url_paging}"

        products.each do |product|
          total_product_t = total_product
          
          tmp_product_id = product.attributes["id"].text
          total_product += 1

          key = "#{site_cat_id}\t#{tmp_product_id}"

          if !@existing_products[key].present?
            threads[thread_count] = Thread.new {
              product_id = product.attributes["id"].text

              product_url = "#{@root_url}#{product.search("a").first.attributes["href"].text}"
              puts "#{total_product_t}/#{product_count}/#{current_page} - #{product_url}"

              scrape_product_or_product_collection_page(product_id, product_url, total_product_t, site_cat_id)
            }

            thread_count += 1
            @existing_products[key] = 0
          else
            #puts "Existing product key #{key}"
            #puts "#{total_product_t}/#{product_count}/#{current_page} - #{"#{@root_url}#{product.search("a").first.attributes["href"].text}"}"
          end

          if thread_count == @number_of_threads || total_product == product_count
            threads.each {|t| t.join}

            threads = []
            thread_count = 0
          end
        end

        # go to the next page
        if total_product < product_count
          current_page += 1

          page_index = "/Pageindex/#{current_page}?id=#{site_cat_id}"
          url_paging = "#{url_paging_root}#{page_index}"

          page = @agent.get(url_paging)
        end
      end
      @scrapped_site_cat_ids[site_cat_id] = site_cat_id
    rescue Exception => e
      puts e.message
      puts e.backtrace.join("\n")
    end
  end

  def scrape_product_or_product_collection_page(product_id, url, pos, site_cat_id)
    begin
      agent = Mechanize.new

      set_cookies(agent)

      page = agent.get(url)

      product_main_data = page.search("#productMainData")

      unless product_main_data.empty?
        scrape_product_page(page, product_id, product_main_data.first, pos, url, site_cat_id)
      else 
        pdp_main_data = page.search("#pdpMainData")

        unless pdp_main_data.empty?
          scrape_product_collection_page(page, product_id, pos, url, site_cat_id)
        end
      end
    rescue Exception => e 
      puts e.message
      puts e.backtrace.join("\n")
    end      
  end

  def scrape_product_collection_page(product_page, site_product_id, pos, product_url, site_cat_id)
    url = "http://www1.macys.com/shop/catalog/product/newthumbnail/json?productId=#{site_product_id}&source=100"

    begin
      agent = Mechanize.new

      set_cookies(agent)

      product_thumbnail_page = agent.get(url)
      product_thumbnail_data = product_thumbnail_page.body.encode("UTF-8",'binary',invalid: :replace, undef: :replace, replace: "")
      product_thumbnail_data = product_thumbnail_data.gsub(/\t/,'')

      product_thumbnail = JSON.parse(
        replace_macys_info(product_thumbnail_data)
      )["productThumbnail"]

      short_desc = CGI.unescapeHTML(product_thumbnail["productDescription"])
      long_desc = CGI.unescapeHTML(product_thumbnail["longDescription"])
      bullet_text = product_thumbnail["bulletText"].collect{|i| CGI.unescapeHTML(i)}.to_json
      child_site_product_ids = product_thumbnail["childProductIds"].to_json
      child_site_products = product_thumbnail["childProducts"]

      #site_category_id = product_thumbnail["categoryId"]
      video_id = product_thumbnail["videoID"]
      product_atts = product_thumbnail["attributes"].collect {|i|
        if i.is_a?(Array) 
            i.collect{|y| CGI.unescapeHTML(y)}
        else
            CGI.unescapeHTML(i)
          end
      }.to_json

      main_image_url = product_thumbnail["imageSource"]
      additional_images = product_thumbnail["additionalImages"].to_json

      colorway_primary_images = product_thumbnail["colorwayPrimaryImages"].to_json
      colorway_additional_images = product_thumbnail["colorwayAdditionalImages"].to_json
      swatch_color_list = product_thumbnail["swatchColorList"].to_json

      brand_name = product_thumbnail["brand"]
      price_range = product_thumbnail["price"].to_json
      cust_rating = product_thumbnail["custRatings"]

      seo_title, seo_keywords, seo_desc = extract_seo_information(product_page)

      shipping_return = CGI.unescapeHTML(product_thumbnail["freeShipMessage"])
      free_ship_message = product_thumbnail["shippingReturnNotes"].collect{|i| CGI.unescapeHTML(i)}.to_json

      product = Product.new()
      
      product.site_product_id = site_product_id
      product.short_desc = short_desc
      product.long_desc = long_desc
      product.bullet_text = bullet_text
      product.main_image_url = main_image_url
      product.additional_images = additional_images
      product.site_cat_id = site_cat_id
      product.video_id = video_id
      product.colorway_primary_images = colorway_primary_images
      product.colorway_additional_images = colorway_additional_images
      product.swatch_color_list = swatch_color_list
      product.product_atts = product_atts
      product.child_site_product_ids = child_site_product_ids
      product.is_collection = true
      product.pos = pos
      product.brand_name = brand_name
      product.price_range = price_range
      product.url = product_url
      product.seo_title = seo_title
      product.seo_keywords = seo_keywords
      product.seo_desc = seo_desc
      product.cust_rating = cust_rating
      product.shipping_return = shipping_return
      product.free_ship_message = free_ship_message
      
      add_product_to_file(product)

      update_product_price_details(product)

      # scrape child products
      scrape_child_products_in_collection(site_cat_id, site_product_id, child_site_products, product_url)

    rescue Exception => e
      puts "[EXCEPTION] #{e.message} - at url: #{url} - product_url: #{product_url}"
      puts e.backtrace.join("\n")
    end
  end

  def scrape_child_products_in_collection(site_cat_id, site_product_id, child_site_products, product_url)
    begin
      
      return if child_site_products.nil?

      puts "[BEGIN] Scrapping child products of collection #{product_url}"

      agent = Mechanize.new
      
      set_cookies(agent)

      pos = 0

      child_site_products.each do |prod|
        product_id = prod["ID"]
        url = "#{@root_url}#{prod["semanticURL"]}"

        puts "Scrapping child product of product #{site_product_id}: #{url}"

        page = agent.get(url)

        product_main_data = page.search("#productMainData")

        scrape_product_page(page, product_id, product_main_data.first, pos, url, site_cat_id, true)
        
        pos += 1
      end
      puts "[END] Scrapping child products of collection #{product_url}"
    rescue Exception => e
      puts "[EXCEPTION] #{e.message} - at product_url: #{product_url}"
      puts e.backtrace.join("\n")
    end
  end

  def scrape_product_page(product_page, site_product_id, data, pos, product_url, site_cat_id, is_child=false)
    url = "http://www1.macys.com/shop/catalog/product/newthumbnail/json?productId=#{site_product_id}&source=100"

    begin
      size_chart_canvas_url = "http://www1.macys.com/shop/catalog/product/canvassizechart/json?canvasId="

      agent = Mechanize.new
      
      set_cookies(agent)

      product_thumbnail_page = agent.get(url)

      if product_thumbnail_page.present? && product_thumbnail_page.code != "200"
        retry_times = 0

        puts "Trying to get the url #{url}"

        while retry_times < 3
          product_thumbnail_page = agent.get(url)
          break if product_thumbnail_page.code == "200"

          retry_times += 1
        end
      end

      product_thumbnail_data = product_thumbnail_page.body.encode("UTF-8",'binary',invalid: :replace, undef: :replace, replace: "")

      product_thumbnail = JSON.parse(
        replace_macys_info(product_thumbnail_data)
      )["productThumbnail"]

      product_data = data.children.first.text.encode("UTF-8",'binary',invalid: :replace, undef: :replace, replace: "").gsub(/\t/,"")

      product = JSON.parse(replace_macys_info(product_data))

      seo_title, seo_keywords, seo_desc = extract_seo_information(product_page)

      # product description
      short_desc = CGI.unescapeHTML(product_thumbnail["productDescription"])
      long_desc = CGI.unescapeHTML(product_thumbnail["longDescription"])
      bullet_text = product_thumbnail["bulletText"].collect{|i| CGI.unescapeHTML(i)}.to_json
      site_category_id = product_thumbnail["categoryId"]
      video_id = product_thumbnail["videoID"]

      main_image_url = product_thumbnail["imageSource"]
      additional_images = product_thumbnail["additionalImages"].to_json
      colorway_primary_images = product_thumbnail["colorwayPrimaryImages"].to_json
      colorway_additional_images = product_thumbnail["colorwayAdditionalImages"].to_json
      colorway_pricing_swatches = product["colorwayPricingSwatches"]
      swatch_color_list = product_thumbnail["swatchColorList"].to_json
      brand_name = CGI.unescapeHTML(product_thumbnail["brand"])
      sizes = product["sizesList"].to_json

      tiered_price = product["colorwayPrice"]["tieredPrice"]
      regular_price, was_price, macys_sale_price = extract_price_info(tiered_price)

      begin
        product_atts = product_thumbnail["attributes"].collect {|i|
          if i.is_a?(Array) 
              i.collect{|y| CGI.unescapeHTML(y)}
          else
              CGI.unescapeHTML(i)
            end
        }.to_json
      rescue Exception => ex
        puts "Message: #{ex.message}"
        puts "Backtrace: #{ex.backtrace}"
        puts "Data: #{product_thumbnail["attributes"]}"
      end

      cust_rating = product_thumbnail["custRatings"]
      shipping_return = CGI.unescapeHTML(product_thumbnail["freeShipMessage"])
      free_ship_message = product_thumbnail["shippingReturnNotes"].collect{|i| CGI.unescapeHTML(i)}.to_json

      size_chart_canvas_id = product_thumbnail["sizeChartCanvasId"]

      size_chart_json = ""

      if !size_chart_canvas_id.nil?
        # fetch size chart table
        size_chart_page = agent.get("#{size_chart_canvas_url}#{size_chart_canvas_id}")
        size_chart_json = size_chart_page.body

        if size_chart_canvas_url.blank?
          puts "size_chart_json: #{size_chart_json.inspect}"
          puts "url: #{size_chart_canvas_url}=#{size_chart_canvas_id}"
        end
      end

      size_chart_id = product_thumbnail["sizeChart"]

      # crawl 'customers also loved/shopped'
      recommendations_page = agent.post('http://www1.macys.com/sdp/rto/request/recommendations',{
          maxRecommendations: "15",
          requester: "MCOM-NAVAPP",
          timeout: "15000",
          cts: "http://www.macys.com",
          productId: "#{site_product_id}",
          categoryId: "#{site_category_id}",
          context: "PDP_ZONE_A|PDP_ZONE_B",
          visitorId: "1111111111",
          countryCode: "US",
          zipCode: "",
          stateCode: "CA",
          customerId: "111111111"
        },
        "Content-Type" => "application/x-www-form-urlencoded; charset=UTF-8"
      )

      recommendations = JSON.parse(recommendations_page.body)

      related_product_ids = nil
      related_loved_product_ids = nil

      if recommendations["status"] == "SUCCESS"
        begin
          related_products = recommendations["recommendationsOnAllZones"]["MCOM-NAVAPP-PDP_ZONE_A"]["recommendationVBList"]
          related_product_ids = related_products.collect{|product| product["recommendedItemId"]}.to_json

          related_loved_products = recommendations["recommendationsOnAllZones"]["MCOM-NAVAPP-PDP_ZONE_B"]["recommendationVBList"]
          related_loved_product_ids = related_loved_products.collect{|product| product["recommendedItemId"]}.to_json
        rescue
          puts "Could not get related_products for site_product_id #{site_product_id} and site_cat_id #{site_product_id}"
        end
      else
        puts "Cannot get recommendations for product(#{productId} - category(#{categoryId}))"
      end    

      product = Product.new()

      product.site_product_id = site_product_id
      product.short_desc = short_desc
      product.long_desc = long_desc
      product.bullet_text = bullet_text
      product.site_cat_id = site_cat_id
      product.video_id = video_id
      product.main_image_url = main_image_url
      product.additional_images = additional_images
      product.colorway_primary_images = colorway_primary_images
      product.colorway_additional_images  = colorway_additional_images
      product.colorway_pricing_swatches = colorway_pricing_swatches.to_json
      product.swatch_color_list = swatch_color_list
      product.sizes = sizes
      product.brand_name = brand_name
      product.product_atts = product_atts
      product.related_products = related_product_ids
      product.related_loved_products = related_loved_product_ids
      product.pos = pos
      product.is_price_color = true if !colorway_pricing_swatches.nil? && colorway_pricing_swatches.count > 1
      product.regular_price = regular_price
      product.was_price = was_price
      product.sale_price = calculate_sale_price(macys_sale_price)
      product.macys_sale_price = macys_sale_price
      product.size_chart_id = size_chart_id
      product.size_chart_table = size_chart_json
      product.url = product_url
      product.seo_title = seo_title
      product.seo_keywords = seo_keywords
      product.seo_desc = seo_desc
      product.cust_rating = cust_rating
      product.shipping_return = shipping_return
      product.free_ship_message = free_ship_message
      product.is_child = is_child

      add_product_to_file(product)

      update_product_price_details(product)

    rescue Exception => e
      puts "[EXCEPTION] #{e.message} - at url: #{url} - product_url: #{product_url}"
      puts e.backtrace.join("\n")
    end
  end

  def update_product_price_details(product)
    begin
      product_img_map = {}
      color_img_map = {}

      product_img_map = JSON.parse(product.colorway_primary_images) if (product.colorway_primary_images != 'null')
      color_imgs = JSON.parse(product.swatch_color_list)
      color_img_map = {}

      color_imgs.each do |color_img|
        color_img.each do |k, v|
          unless ["spriteIndex","spritePosition"].include? k
            color_img_map[k] = v
          end
        end
      end

      unless product.colorway_pricing_swatches.nil?
        # price and color mapping
        h = JSON.parse(product.colorway_pricing_swatches)

        h.each do |price_with_sign, colors|
          price = price_with_sign.gsub(/\$/,'')

          colors.each do |color_name, nothing|
            ppd = ProductPriceDetail.new
            ppd.site_product_id = product.site_product_id
            ppd.price = price
            ppd.color_name = color_name
            ppd.color_image = color_img_map[color_name]
            ppd.product_image = product_img_map[color_name]
            
            add_product_price_details_to_file(ppd)
          end
        end
      else
        color_img_map.each do |color_name, color_img|
          ppd = ProductPriceDetail.new
          ppd.site_product_id = product.site_product_id
          ppd.color_name = color_name
          ppd.color_image = color_img
          ppd.product_image = product_img_map[color_name]
          
          add_product_price_details_to_file(ppd)
        end
      end
    rescue Exception => e
      puts "[EXCEPTION] #{e.message} - at product url: #{product.url}"
      puts e.backtrace.join("\n")
    end
  end

  def extract_price_info(tiered_price)
    regular_price = was_price = sale_price = ""

    begin
      tiered_price.each do |price_h|
        price = price_h["value"]

        if price_h["label"] == "Reg. [PRICE]"
          regular_price = price.first
        elsif price_h["label"] == "Was [PRICE]"
          was_price = price.first
        elsif price_h["label"] == "Sale [PRICE]"
          sale_price = price.first
        else
          sale_price = price.first
        end
      end

      return regular_price, was_price, sale_price
    rescue Exception => e 
      puts "[Exception] #{e.message} - data: #{tiered_price}"
      puts e.backtrace.join("\n")
      return "","",""
    end
  end

  def replace_macys_info(data)
    return nil if data.nil?

    return data.gsub(/Macys.com|macys|Macy's|Macy/, SITE_NAME)
  end

  def extract_seo_information(page)
    begin
      seo_title = seo_keywords = seo_desc = ""

      unless page.search("title").first.nil?
        seo_title = replace_macys_info(page.search("title").first.text)
      end

      unless page.search(".//meta[@name='keywords']").first.nil?
        seo_keywords = replace_macys_info(page.search(".//meta[@name='keywords']").first.attributes["content"].text)
      end
      
      unless page.search(".//meta[@name='description']").first.nil?
        seo_desc = replace_macys_info(page.search(".//meta[@name='description']").first.attributes["content"].text)
      end
      
      seo_title = CGI.unescapeHTML(seo_title)
      seo_keywords = CGI.unescapeHTML(seo_keywords)
      seo_desc = CGI.unescapeHTML(seo_desc)

      return seo_title, seo_keywords, seo_desc
    rescue Exception => e
      puts "Message: #{e.message}"
      puts "Backtrace: #{e.backtrace}"
    end
  end

  def scrape_seo_information
    begin
      pages = {
        "root": @root_url
      }

      pages.each do |k, url|
        page = @agent.get(url)

        seo_title, seo_keywords, seo_desc = extract_seo_information(page)

        seo_info = SeoInfo.find_or_create_by(page_name: k)
        seo_info.seo_title = seo_title
        seo_info.seo_keywords = seo_keywords
        seo_info.seo_desc = seo_desc
        seo_info.save
      end
    rescue Exception => e
      puts e.message
      puts e.backtrace.join("\n")
    end
  end

  def set_cookies(agent)
    if Rails.env.development?
      agent.agent.set_socks('localhost', 8123)
    end

    cookie = Mechanize::Cookie.new("shippingCountry", "US")
    cookie.domain = ".macys.com"
    cookie.path = "/"
    agent.cookie_jar.add(cookie)

    cookie = Mechanize::Cookie.new("currency", "USD")
    cookie.domain = ".macys.com"
    cookie.path = "/"
    agent.cookie_jar.add(cookie)
  end

  def calculate_sale_price(macys_sale_price)
    sale_price = macys_sale_price

    if macys_sale_price < 100
      sale_price -= sale_price * 0.1
    elsif macys_sale_price >= 100 && macys_sale_price < 150
      sale_price -= sale_price * 0.133
    elsif macys_sale_price >= 150 && macys_sale_price < 200
      sale_price -= sale_price * 0.155
    elsif macys_sale_price >= 200 && macys_sale_price < 500
      sale_price -= sale_price * 0.25
    elsif macys_sale_price >= 500
      sale_price -= sale_price * 0.3
    end

    return sale_price
  end

  def add_product_to_file(product)
    begin
      @mutex.lock

      if @number_of_products % BATCH_SIZE == 0
        @current_file.flush unless @current_file.nil?

        @current_file = CSV.open("./tmp/#{@start_date}/#{@current_cat_name}_products_batch_#{@current_batch}.csv", "wb")
        @current_batch += 1
      end

      @current_file << product.attributes.values unless product.nil?
      @number_of_products += 1
    rescue Exception => e
      puts "Message: #{e.message}"
      puts "Backtrace: #{e.backtrace}"
    ensure
      @mutex.unlock
    end
  end

  def import_crawled_products_to_db(start_date, current_cat_name, number_of_batches=0)
    begin
      return if number_of_batches <= 0

      for i in 0...number_of_batches
        puts "Begin to import batch #{i}"
        start = Time.now

        products = CSV.read("./tmp/#{start_date}/#{current_cat_name}_products_batch_#{i}.csv", 
                            external_encoding: "ISO8859-1",
                            internal_encoding: "utf-8")
        
        Product.transaction do
          columns = Product.attribute_names
          Product.import columns, products, validate: false
        end

        puts "Finished importing batch #{i} in #{Time.now - start}\n"
      end
    rescue Exception => e
      puts "Message: #{e.message}"
      puts "Backtrace: #{e.backtrace}"
    end
  end

  def update_products_after_import
    begin
      puts "Begin to update products"
      start = Time.now

      sql =<<-SQL 
        update products p
        set category_id = c.id
        from categories c
        where c.site_cat_id = p.site_cat_id;
      SQL

      Product.connection.execute(sql)

      puts "Finished updating products in #{Time.now - start}"
    rescue Exception => e
      puts "Message: #{e.message}"
      puts "Backtrace: #{e.backtrace}"
    end
  end

  def add_product_price_details_to_file(product_price_detail)
    begin
      @ppd_mutex.lock

      if @ppd_number_of_products % BATCH_SIZE == 0
        @ppd_current_file.flush unless @ppd_current_file.nil?

        @ppd_current_file = CSV.open("./tmp/#{@start_date}/#{@current_cat_name}_product_price_details_batch_#{@ppd_current_batch}.csv", "wb")
        @ppd_current_batch += 1
      end

      @ppd_current_file << product_price_detail.attributes.values unless product_price_detail.nil?
      @ppd_number_of_products += 1
    rescue Exception => e
      puts "Message: #{e.message}"
      puts "Backtrace: #{e.backtrace}"
    ensure
      @ppd_mutex.unlock
    end
  end

  def import_product_price_details_to_db(start_date, current_cat_name, number_of_batches=0)
    begin
      return if number_of_batches <= 0

      for i in 0...number_of_batches
        puts "Begin to import product price details batch #{i}"
        start = Time.now

        ppds = CSV.read("./tmp/#{start_date}/#{current_cat_name}_product_price_details_batch_#{i}.csv")
        
        ProductPriceDetail.transaction do
          columns = ProductPriceDetail.attribute_names
          ProductPriceDetail.import columns, ppds, validate: false
        end

        puts "Finished importing product price details batch #{i} in #{Time.now - start}\n"
      end
    rescue Exception => e
      puts "Message: #{e.message}"
      puts "Backtrace: #{e.backtrace}"
    end
  end

  def update_product_price_details_after_import
    begin
      puts "Begin to update product price details"
      start = Time.now

      sql =<<-SQL 
        update product_price_details p
        set product_id = c.id
        from products c
        where c.site_product_id = p.site_product_id;
      SQL

      ProductPriceDetail.connection.execute(sql)

      puts "Finished updating product price details in #{Time.now - start}"
    rescue Exception => e
      puts "Message: #{e.message}"
      puts "Backtrace: #{e.backtrace}"
    end
  end
end
