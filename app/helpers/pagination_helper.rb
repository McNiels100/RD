module PaginationHelper
  def pagination_window(current_page, total_pages, window_size = 2)
    window_start = [ current_page - window_size, 1 ].max
    window_end = [ current_page + window_size, total_pages ].min

    {
      start: window_start,
      end: window_end,
      show_first_page: window_start > 1,
      show_first_ellipsis: window_start > 2,
      show_last_page: window_end < total_pages,
      show_last_ellipsis: window_end < total_pages - 1
    }
  end

  def page_link(page_num, current_page, params)
    if page_num == current_page
      content_tag(:a, page_num, class: "active", href: "#")
    else
      link_to page_num, url_for(params.permit!.merge(page: page_num))
    end
  end

  def prev_next_link(is_prev, current_page, total_pages, params)
    label = is_prev ? "&laquo;" : "&raquo;"
    disabled = (is_prev && current_page <= 1) || (!is_prev && current_page >= total_pages)

    if disabled
      content_tag(:a, label.html_safe, class: "disabled", href: "#")
    else
      target_page = is_prev ? current_page - 1 : current_page + 1
      link_to label.html_safe, url_for(params.permit!.merge(page: target_page))
    end
  end

  def page_info(current_page, per_page, total_items)
    start_item = total_items == 0 ? 0 : (current_page - 1) * per_page + 1
    end_item = [ current_page * per_page, total_items ].min
    "Showing #{start_item}-#{end_item} of #{total_items} items"
  end
end
