class PaginationListLinkRenderer < WillPaginate::ActionView::LinkRenderer
  protected
  def page_number(page)
    unless page == current_page
      tag(:li, tag(:a,page, href: url(page)))
    else
      tag(:li,tag(:span,page),class:'uk-active')
    end
  end

  def gap
    text = @template.will_paginate_translate(:page_gap) { '&hellip;' }
    %(<li><span>&hellip;</span></li>)
  end

  def previous_page
    num = @collection.current_page > 1 && @collection.current_page - 1
    previous_or_next_page(num, 'uk-icon-angle-double-left')
  end

  def next_page
    num = @collection.current_page < @collection.total_pages && @collection.current_page + 1
    previous_or_next_page(num, 'uk-icon-angle-double-right')
  end

  def previous_or_next_page(page, classname)
    if page
      tag(:li, tag(:a,tag(:i,"",class: classname), href: url(page)))
    else
      tag(:li, tag(:span,tag(:i,"",class: classname)),class: 'uk-disabled')
    end
  end

  def html_container(html)
    tag(:ul, html, class: "uk-pagination uk-margin-medium-top uk-margin-medium-bottom")
  end
end